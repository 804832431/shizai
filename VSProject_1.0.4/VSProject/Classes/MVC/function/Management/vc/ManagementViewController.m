//
//  ManagementViewController.m
//  VSProject
//
//  Created by certus on 16/3/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ManagementViewController.h"
#import "InviteViewController.h"
#import "ManagementCell.h"
#import "EditAuthorityViewController.h"
#import "ManagementManger.h"
#import "EmployeeModel.h"


#define deleteBase 10000
#define editeBase 100

@interface ManagementViewController ()

@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UILabel *headLeft;
@property (strong, nonatomic) IBOutlet UILabel *headMid;
@property (strong, nonatomic) IBOutlet UILabel *headRight;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ManagementManger *manger;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) NSString *companyId;;

@end

@implementation ManagementViewController

- (void)adjustsubViews {
    
    _addButton.layer.cornerRadius = 3.f;
    _addButton.clipsToBounds = YES;
    _headLeft.layer.borderColor = _COLOR_HEX(0xcbcbcb).CGColor;
    _headLeft.layer.borderWidth = 0.5f;
    _headMid.layer.borderColor = _COLOR_HEX(0xcbcbcb).CGColor;
    _headMid.layer.borderWidth = 0.5f;
    _headRight.layer.borderColor = _COLOR_HEX(0xcbcbcb).CGColor;
    _headRight.layer.borderWidth = 0.5f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self vs_setTitleText:@"企业管理"];
    [self vs_showRightButton:YES];
    [self.vm_rightButton setImage:[UIImage imageNamed:@"tianj"] forState:0];
    [self adjustsubViews];
    [_addButton addTarget:self action:@selector(inviteEmployee:) forControlEvents:UIControlEventTouchUpInside];
    __weak typeof(self)weakself = self;
    [_tableView addHeaderWithCallback:^{
        [weakself requestCompanyEmployee];
    }];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self requestCompanyEmployee];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Request

- (void)requestCompanyEmployee {
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSString *partyId =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    if (partyId) {
        [dic setObject:partyId forKey:@"partyId"];
    }
    [dic setObject:@"-1" forKey:@"page"];
    [dic setObject:@"-1" forKey:@"row"];
    [self vs_showLoading];
    [self.manger requestCompanyEmployee:dic success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSArray *employee = [responseObj objectForKey:@"employee"];
        _companyId = [responseObj objectForKey:@"companyId"]?:@"";
        self.dataList = [EmployeeModel arrayOfModelsFromDictionaries:employee];
        
        [_tableView headerEndRefreshing];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
        [_tableView headerEndRefreshing];
    }];
}

- (void)requestRemoveEmployee:(NSUInteger)index {
    
    [self vs_showLoading];
    EmployeeModel *model = self.dataList[index];
    
    NSString *partyId =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    NSDictionary *para = @{@"operateBy":@"admin",@"partyId":partyId,@"rltCompanyPartyId":model.id};
    [self.manger requestRemoveEmployee:para success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSString *resultCode = [responseObj objectForKey:@"resultCode"];
        
        if (resultCode && [resultCode isEqualToString:@"CODE-00000"]) {
            [self.dataList removeObjectAtIndex:index];
            [_tableView reloadData];
        }else {
            [self.view showTipsView:@"删除失败"];
        }
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
    
}


#pragma mark -- Action

- (void)actionBack {
    
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        [KNotificationCenter postNotificationName:kHome_BackHomeC object:nil];
    }];
}

- (void)vs_rightButtonAction:(id)sender {
    
    NSString *url = [NSString stringWithFormat:@"%@/api/page/company/companyRegist.jsp?qy=%@",SERVER_IP_H5,_companyId];
    [self shareClickedWithContent:@"变革，无处不在！立即注册，加入企业！" Title:@"注册分享页" shareInviteUrl:[NSString stringWithFormat:@"%@",url]];
}

- (void)inviteEmployee:(UIButton *)sender {
    
    InviteViewController *vc = [[InviteViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)editEmployee:(UIButton *)sender {
    
    if (sender.tag >= editeBase) {
        NSUInteger index = sender.tag - editeBase;
        EditAuthorityViewController *vc = [[EditAuthorityViewController alloc]init];
        vc.model = self.dataList[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)deleteEmployee:(UIButton *)sender {
    
    if (sender.tag >= deleteBase) {
        [self sureDeleteEmployee:sender.tag];
    }
}

#pragma mark -- Private

- (void)sureDeleteEmployee:(NSUInteger )index{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要删除此条记录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = index;
    [alert show];
    
}

#pragma mark -- UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag >= deleteBase && buttonIndex == 1) {
        
        [self requestRemoveEmployee:alertView.tag-deleteBase];
        
    }
    
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    MessageContentViewController *vc = [[MessageContentViewController alloc]init];
    //    vc.m_model = [_datalist objectAtIndex:indexPath.row];
    //    [self.navigationController pushViewController:vc animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self sureDeleteEmployee:indexPath.row+deleteBase];
    }
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 51;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    ManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ManagementCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    EmployeeModel *model = self.dataList[indexPath.row];
    cell.m_account.text = model.userLoginId;
    cell.m_name.text = model.name;
    cell.m_editButton.tag = indexPath.row + editeBase;
    cell.m_deleteButton.tag = indexPath.row + deleteBase;
    [cell.m_editButton addTarget:self action:@selector(editEmployee:) forControlEvents:UIControlEventTouchUpInside];
    [cell.m_deleteButton addTarget:self action:@selector(deleteEmployee:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (ManagementManger *)manger {
    
    if (!_manger) {
        _manger = [[ManagementManger alloc]init];
    }
    return _manger;
}

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc]init];
    }
    return _dataList;
}

@end
