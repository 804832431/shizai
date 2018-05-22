//
//  EnterpriseInfoViewController.m
//  VSProject
//
//  Created by CertusNet on 16/3/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "EnterpriseInfoViewController.h"
#import "EnterpriseInfoCell.h"
#import "ManagementManger.h"
#import "SinglePickerView.h"
#import "DetaileAdressViewController.h"

@interface EnterpriseInfoViewController () {

    NSArray *leftsectionOne;
    NSArray *leftsectionTwo;
}
@property (strong, nonatomic) IBOutlet UIButton *quitBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ManagementManger *manger;
@property (strong, nonatomic) NSDictionary *dataDic;

@end

@implementation EnterpriseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vs_setTitleText:@"企业信息"];
    [self setupViews];
//    _tableView.scrollEnabled= NO;
    leftsectionOne = @[@"企业名称",@"联系人",@"联系人电话",@"邮箱"];
    leftsectionTwo = @[@"注册资金",@"所属行业",@"企业规模",@"企业性质",@"企业选址",@"企业简介"];

    if (_roleType == ROLE_employee) {
        [_quitBtn setTitle:@"退出企业" forState:0];
        [_quitBtn addTarget:self action:@selector(quitAction:) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.delegate = nil;
    }else if (_roleType == ROLE_admin) {
        [_quitBtn setHidden:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self requestCompanyInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupViews
{
    _quitBtn.layer.cornerRadius = 3.f;
    _quitBtn.clipsToBounds = YES;

    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //这种分离器式样目前只支持分组样式表视图

}

- (void)quitAction:(UIButton *)sender {

    [self requestRemoveEmployee];
}


- (void)quitsuccess {
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController dismissViewControllerAnimated:NO completion:^{
//        [KNotificationCenter postNotificationName:kHome_BackHomeC object:nil];
//    }];
}


#pragma mark -- Request
- (void)requestCompanyInfo {
    [self vs_showLoading];
    [self.manger requestCompanyInfo:nil success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        self.dataDic = responseObj;
        [_tableView reloadData];
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

- (void)requestRemoveEmployee {
    
    [self vs_showLoading];
    
    NSDictionary *relationshipment = [self.dataDic objectForKey:@"relationshipment"];
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";

    NSDictionary *para = @{@"operateBy":@"employee",@"partyId":partyId,@"rltCompanyPartyId":[relationshipment objectForKey:@"id"]};
    [self.manger requestRemoveEmployee:para success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSString *resultCode = [responseObj objectForKey:@"resultCode"];
        
        if (resultCode && [resultCode isEqualToString:@"CODE-00000"]) {

            [self quitsuccess];
        }else {
            [self.view showTipsView:@"退出失败"];
        }
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
    
}

- (void)requestUpdateCompanyInfo:(NSDictionary *)para changeCell:(void(^)(void))changeCell{
    
    [self vs_showLoading];
    [self.manger requestUpdateCompanyInfo:para success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        changeCell();
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
    
}
#pragma mark -- UITableViewDataSource
//要加tableView的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return leftsectionOne.count;
    }else {
        return leftsectionTwo.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    EnterpriseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EnterpriseInfoCell" owner:nil options:nil] lastObject];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *company = [self.dataDic objectForKey:@"company"];
    if (indexPath.section == 0) {
        cell.leftLabel.text = leftsectionOne[indexPath.row];
        switch (indexPath.row) {
            case 0:
            {
                cell.rightLabel.text = [company objectForKey:@"name"];
            }
                break;
                
            case 1:
            {
                cell.rightLabel.text = [company objectForKey:@"contact"];

            }
                break;
                
            case 2:
            {
                cell.rightLabel.text = [company objectForKey:@"contactNumber"];
            }
                break;
            case 3:
            {
                cell.rightLabel.text = [company objectForKey:@"emailAddress"];
            }
                break;
            default:
                break;
        }

    }else {
        cell.leftLabel.text = leftsectionTwo[indexPath.row];
        NSString *emuneKey = @"";

        switch (indexPath.row) {
            case 0:
            {
               emuneKey = [company objectForKey:@"registerCapital"];
                cell.rightLabel.text = [self valeByEmuneKey:emuneKey];

            }
                break;
                
            case 1:
            {
                emuneKey = [company objectForKey:@"companyType"];
                cell.rightLabel.text = [self valeByEmuneKey:emuneKey]?:@"其它";

            }
                break;
                
            case 2:
            {
                emuneKey = [company objectForKey:@"companyScale"];
                cell.rightLabel.text = [self valeByEmuneKey:emuneKey];
            }
                break;
                
            case 3:
            {
                emuneKey = [company objectForKey:@"companyProp"];
                cell.rightLabel.text = [self valeByEmuneKey:emuneKey]?:@"其它";
            }
                break;
            case 4:
            {
                cell.rightLabel.text = [company objectForKey:@"address"];
            }
                break;
            case 5:
            {
                cell.rightLabel.text = [company objectForKey:@"description"];
            }
                break;

            default:
                break;
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row <=3) {
        NSArray *arr = [@[] mutableCopy];
        SinglePickerView *pickerView = [[SinglePickerView alloc]initWithFrame:self.view.bounds pickerViewType:PICKER_NORMAL];
        pickerView.tag = indexPath.row+100;
        switch (indexPath.row) {
            case 0:
                arr = @[@"0-10万",@"10-100万",@"100-500万",@"大于500万"];
                break;
                
            case 1:
                arr = @[@"通信/互联网科技",@"贸易批发零售",@"文创",@"金融业",@"建筑业",@"商业服务",@"加工制造",@"交通运输物流",@"服务业",@"文娱体育",@"其它"];
                break;

            case 2:
                arr = @[@"20人以下",@"20-99人",@"100-499人",@"500-999人",@"1000-9999人",@"10000人以上"];
                break;

            case 3:
                arr = @[@"国企",@"民营",@"合资",@"外商独资",@"股份制企业",@"其它"];
                break;

            default:
                break;
        }
        pickerView.dataList = [NSArray arrayWithArray:arr];
        pickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [pickerView show];

    }else {
        
        EnterpriseInfoCell *cell = (EnterpriseInfoCell *)[_tableView cellForRowAtIndexPath:indexPath];

        DetaileAdressViewController *controller = [[DetaileAdressViewController alloc]init];
        controller.title = cell.leftLabel.text;
        controller.adreess = cell.rightLabel.text;
        
        controller.adrtessBlock = ^(NSString *adress){
            NSArray *arr = @[@"companyName",@"contact",@"contactNumber",@"emailAddress",@"registerCapital",@"companyType",@"companyScale",@"companyProp",@"address",@"description"];
            NSString *paraKey = [arr objectAtIndex:indexPath.section*4 + indexPath.row];
            NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
            NSDictionary *dic = @{@"partyId":partyId,@"updateKey":paraKey,@"updateValue":adress};

            [self requestUpdateCompanyInfo:dic changeCell:^{
                EnterpriseInfoCell *cell1 = (EnterpriseInfoCell *)[_tableView cellForRowAtIndexPath:indexPath];
                cell1.rightLabel.text = adress;
            }];
        };
        [self.navigationController pushViewController:controller animated:YES];
        
    }
}

#pragma mark -- SinglePickerViewDelegate

- (void)SinglePickerView:(SinglePickerView *)pickerView selectedValue:(NSString *)selectedValue {
    
    NSArray *arr = @[@"companyName",@"contact",@"contactNumber",@"emailAddress",@"registerCapital",@"companyType",@"companyScale",@"companyProp",@"address",@"description"];
    NSString *paraKey = [arr objectAtIndex:4 + pickerView.tag -100];

    NSString *key = [self keyByEmuneValue:selectedValue];
    NSLog(@"key--%@",key);
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";

    NSDictionary *dic = @{@"partyId":partyId,@"updateKey":paraKey,@"updateValue":key};
    [self requestUpdateCompanyInfo:dic changeCell:^{
        EnterpriseInfoCell *cell = (EnterpriseInfoCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:pickerView.tag -100 inSection:1]];
        cell.rightLabel.text = selectedValue;
    }];
    
}

#pragma mark -- Private

- (NSString *)valeByEmuneKey:(NSString *)key {
    
    NSDictionary *dic = @{@"cap_0":@"0-10万",
                          @"cap_1":@"10-100万",
                          @"cap_2":@"100-500万",
                          @"cap_3":@"大于500万",
                          @"CommunicationIT":@"通信/互联网科技",
                          @"WholesaleRetailTrad":@"贸易批发零售",
                          @"Winchance":@"文创",
                          @"Finance":@"金融业",
                          @"Construction":@"建筑业",
                          @"BusinessService":@"商业服务",
                          @"ProcessManufacture":@"加工制造",
                          @"TransportationLogistics":@"交通运输物流",
                          @"Service":@"服务业",
                          @"RecreationalSports":@"文娱体育",
                          @"cs_1":@"20人以下",
                          @"cs_2":@"20-99人",
                          @"cs_3":@"100-499人",
                          @"cs_4":@"500-999人",
                          @"cs_5":@"1000-9999人",
                          @"cs_6":@"10000人以上",
                          @"StateOwnedCom":@"国企",
                          @"PrivOperCom":@"民营",
                          @"JointVenture":@"合资",
                          @"Wfoe":@"外商独资",
                          @"Corporation":@"股份制企业",
                          @"Other":@"其它"
                          };
    NSString *value = [dic objectForKey:key];
    return value;
    
}

- (NSString *)keyByEmuneValue:(NSString *)key {
    
    NSDictionary *dic = @{@"0-10万":@"cap_0",
                          @"10-100万":@"cap_1",
                          @"100-500万":@"cap_2",
                          @"大于500万":@"cap_3",
                          @"通信/互联网科技":@"CommunicationIT",
                          @"贸易批发零售":@"WholesaleRetailTrad",
                          @"文创":@"Winchance",
                          @"金融业":@"Finance",
                          @"建筑业":@"Construction",
                          @"商业服务":@"BusinessService",
                          @"加工制造":@"ProcessManufacture",
                          @"交通运输物流":@"TransportationLogistics",
                          @"服务业":@"Service",
                          @"文娱体育":@"RecreationalSports",
                          @"20人以下":@"cs_1",
                          @"20-99人":@"cs_2",
                          @"100-499人":@"cs_3",
                          @"500-999人":@"cs_4",
                          @"1000-9999人":@"cs_5",
                          @"10000人以上":@"cs_6",
                          @"国企":@"StateOwnedCom",
                          @"民营":@"PrivOperCom",
                          @"合资":@"JointVenture",
                          @"外商独资":@"Wfoe",
                          @"股份制企业":@"Corporation",
                          @"其它":@"Other"
                          };
    NSString *value = [dic objectForKey:key];
    return value;
}



- (ManagementManger *)manger {

    if (!_manger) {
        _manger = [[ManagementManger alloc]init];
    }
    return _manger;
}

- (NSDictionary *)dataDic {
    
    if (!_dataDic) {
        _dataDic = [[NSDictionary alloc]init];
    }
    return _dataDic;
}

@end
