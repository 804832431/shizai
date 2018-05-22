//
//  EnterpriseJoinViewController.m
//  VSProject
//
//  Created by certus on 16/4/2.
//  Copyright © 2016年 user. All rights reserved.
//

#import "EnterpriseJoinViewController.h"
#import "EnterpriseInfoCell.h"
#import "DownCell.h"
#import "ManagementManger.h"
#import "SinglePickerView.h"
#import "DetaileAdressViewController.h"

@interface EnterpriseJoinViewController (){
    
    NSArray *leftsectionOne;
    NSArray *leftsectionTwo;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) ManagementManger *manger;
@property (strong, nonatomic) NSMutableDictionary *dataDic;

@end

@implementation EnterpriseJoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"申请企业入驻"];
    [self setupViews];
    //    _tableView.scrollEnabled= NO;
    leftsectionOne = @[@"企业名称",@"联系人姓名",@"联系人电话"];
    leftsectionTwo = @[@"办公地点",@"行业类型",@"注册资本"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews
{
    _registerBtn.layer.cornerRadius = 3.f;
    _registerBtn.clipsToBounds = YES;
    [_registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //这种分离器式样目前只支持分组样式表视图
    
}

- (void)registerAction:(UIButton *)sender {
    
    NSString *companyName = [self.dataDic objectForKey:@"companyName"];
    NSString *contact = [self.dataDic objectForKey:@"contact"];
    NSString *contactNumber = [self.dataDic objectForKey:@"contactNumber"];
    
    if ([companyName isEmptyString]) {
        [self.view showTipsView:@"请填写企业名称!"];
        return;
    }else if ([contact isEmptyString]) {
        [self.view showTipsView:@"请填写联系人姓名!"];
        return;
    }else if ([contactNumber isEmptyString]) {
        [self.view showTipsView:@"请填写联系人电话!"];
        return;
    }else {
        [self requestRegisterCompanyInfo];
    }
    
}

- (void)registersuccess {
    
    [self.view showTipsView:@"注册成功" afterDelay:0.4f completeBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


#pragma mark -- Request

- (void)requestRegisterCompanyInfo{
    
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:self.dataDic];
    NSString *organizationId =[VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.organizationId;
    organizationId = organizationId.length > 0 ? organizationId :@"0";
    [para setObject:organizationId forKey:@"organizationId"];
    [self vs_showLoading];
    [self.manger requestRegisterCompanyInfo:para success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self registersuccess];
        
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
    
    NSDictionary *company = self.dataDic;
    if (indexPath.section == 0) {
        static NSString *identifier = @"EnterpriseInfoCell";
        EnterpriseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"EnterpriseInfoCell" owner:nil options:nil] lastObject];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.leftLabel.text = leftsectionOne[indexPath.row];
        switch (indexPath.row) {
            case 0:
            {
                cell.rightLabel.text = ![[company objectForKey:@"companyName"] isEmptyString]?[company objectForKey:@"companyName"]:@"请填写（必填）";
            }
                break;
                
            case 1:
            {
                cell.rightLabel.text = ![[company objectForKey:@"contact"] isEmptyString]?[company objectForKey:@"contact"]:@"请填写（必填）";
                
            }
                break;
                
            case 2:
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.tintColor = [UIColor grayColor];
                
                NSString *phoneNumber = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username;
                cell.rightLabel.text = phoneNumber;
                [self.dataDic setObject:phoneNumber forKey:@"contactNumber"];
            }
                break;
            default:
                break;
        }
        return cell;
    }else {
        
        static NSString *identifier = @"DownCell";
        DownCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DownCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftLabel.textColor = _COLOR_HEX(0x656666);
        cell.rightLabel.textColor = _COLOR_HEX(0x878889);
        
        cell.leftLabel.text = leftsectionTwo[indexPath.row];
        NSString *emuneKey = @"";
        
        switch (indexPath.row) {
            case 0:
            {
                [cell.downPic setHidden:YES];
                NSString *name =[VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.name;
                cell.rightLabel.text = name;
                
            }
                break;
                
            case 1:
            {
                emuneKey = [company objectForKey:@"companyType"];
                if ([emuneKey isEmptyString]) {
                    cell.rightLabel.text = @"";
                }else {
                    cell.rightLabel.text = [self valeByEmuneKey:emuneKey]?:@"其它";
                }
                
            }
                break;
                
            case 2:
            {
                emuneKey = [company objectForKey:@"registerCapital"];
                if ([emuneKey isEmptyString]) {
                    cell.rightLabel.text = @"";
                }else {
                    cell.rightLabel.text = [self valeByEmuneKey:emuneKey];
                }
            }
                break;
                
            default:
                break;
        }
        return cell;
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row < 2) {
        EnterpriseInfoCell *cell = (EnterpriseInfoCell *)[_tableView cellForRowAtIndexPath:indexPath];
        
        DetaileAdressViewController *controller = [[DetaileAdressViewController alloc]init];
        controller.title = cell.leftLabel.text;
        controller.adreess = ![cell.rightLabel.text isEqualToString:@"请填写（必填）"]? cell.rightLabel.text : @"";
        
        controller.adrtessBlock = ^(NSString *adress){
            EnterpriseInfoCell *cell1 = (EnterpriseInfoCell *)[_tableView cellForRowAtIndexPath:indexPath];
            cell1.rightLabel.text = adress;
            switch (indexPath.row) {
                case 0:
                    [self.dataDic setObject:adress forKey:@"companyName"];
                    break;
                    
                case 1:
                    [self.dataDic setObject:adress forKey:@"contact"];
                    break;
                    
                default:
                    break;
            }
        };
        [self.navigationController pushViewController:controller animated:YES];
        
        
    }else if (indexPath.section == 1 && indexPath.row >= 1 ){
        NSArray *arr = [@[] mutableCopy];
        SinglePickerView *pickerView = [[SinglePickerView alloc]initWithFrame:self.view.bounds pickerViewType:PICKER_NORMAL];
        pickerView.tag = indexPath.row+100;
        switch (indexPath.row) {
                
            case 1:
                arr = @[@"通信/互联网科技",@"贸易批发零售",@"文创",@"金融业",@"建筑业",@"商业服务",@"加工制造",@"交通运输物流",@"服务业",@"文娱体育",@"其它"];
                break;
                
            case 2:
                arr = @[@"0-10万",@"10-100万",@"100-500万",@"大于500万"];
                break;
                
            default:
                break;
        }
        pickerView.dataList = [NSArray arrayWithArray:arr];
        pickerView.delegate = (id<SinglePickerViewDelegate>)self;
        [pickerView show];
        
    }
}

#pragma mark -- SinglePickerViewDelegate

- (void)SinglePickerView:(SinglePickerView *)pickerView selectedValue:(NSString *)selectedValue {
    
    
    NSString *key = [self keyByEmuneValue:selectedValue];
    
    switch (pickerView.tag -100) {
        case 1:
            [self.dataDic setObject:key forKey:@"companyType"];
            break;
            
        case 2:
            [self.dataDic setObject:key forKey:@"registerCapital"];
            break;
            
        default:
            break;
    }
    EnterpriseInfoCell *cell = (EnterpriseInfoCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:pickerView.tag -100 inSection:1]];
    cell.rightLabel.text = selectedValue;
    
    
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
        _dataDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"companyName":@"",@"contact":@"",@"contactNumber":@"",@"companyType":@"",@"registerCapital":@""}];
    }
    return _dataDic;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
