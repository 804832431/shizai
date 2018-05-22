//
//  EditAuthorityViewController.m
//  VSProject
//
//  Created by certus on 16/3/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "EditAuthorityViewController.h"
#import "MoreCareCell.h"
#import "ManagementManger.h"
#import "ApplicationVisitModel.h"

@interface EditAuthorityViewController () {
    
    BOOL checkAllSelected;
}

@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameText;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *checkAll;
@property (strong, nonatomic) IBOutlet UILabel *checkLabel;
@property (strong, nonatomic) IBOutlet UIButton *sureButton;
@property (strong, nonatomic) ManagementManger *manger;
@property (strong, nonatomic) NSMutableArray *dataList;



@end

@implementation EditAuthorityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"编辑企业使用权限"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_checkAll addTarget:self action:@selector(checkAll:) forControlEvents:UIControlEventTouchUpInside];
    [_sureButton addTarget:self action:@selector(sureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self requestGetEmployeeInfo];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Action

- (void)checkAll:(UIButton *)sender {

    checkAllSelected = !checkAllSelected;
    [self setSelectedCheckAll:checkAllSelected];
    [self CheckedAllCells:checkAllSelected];

}

- (void)sureButton:(UIButton *)sender {

    [self requestUpdateEmployeeInfo];
}
#pragma mark -- Private

- (void)setSelectedCheckAll:(BOOL)selected {
    
    NSLog(@"_selectedCare=%d",selected);
    if (selected) {
        [_checkAll setImage:[UIImage imageNamed:@"xuanzh"] forState:UIControlStateNormal];
        _checkLabel.text = @"全不选";
    }else {
        [_checkAll setImage:[UIImage imageNamed:@"weixuanzh"] forState:UIControlStateNormal];
        _checkLabel.text = @"全选";
    }
}

- (void)CheckedAllCells:(BOOL)selected {
    if (selected) {
        for (int i=0; i<self.dataList.count;i++) {
            ApplicationVisitModel *model = self.dataList[i];
            model.allowVisit = @"1";
        }
        [_tableView reloadData];
    }else {
        for (int i=0; i<self.dataList.count;i++) {
            ApplicationVisitModel *model = self.dataList[i];
            model.allowVisit = @"0";
        }
        [_tableView reloadData];
    }

}
- (BOOL)CheckedAll {

    for (int i=0; i<self.dataList.count;i++) {
        ApplicationVisitModel *model = self.dataList[i];
        if (model.allowVisit && [model.allowVisit isEqualToString:@"0"]) {
            return NO;
            break;
        }
    }
    return YES;
}

- (void)reloadData {

    _accountLabel.text = _model.userLoginId;
    _nameText.text = _model.name;
    [_tableView reloadData];
    if ([self CheckedAll]) {
        checkAllSelected = YES;
    }else {
        checkAllSelected = NO;
    }
    [self setSelectedCheckAll:checkAllSelected];
}

#pragma mark -- Request

- (void)requestGetEmployeeInfo {
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSString *partyId =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    if (partyId) {
        [dic setObject:partyId forKey:@"partyId"];
    }
    NSString *companyId =_model.id;
    [dic setObject:companyId forKey:@"rltCompanyPartyId"];
    [self vs_showLoading];
    [self.manger requestGetEmployeeInfo:dic success:^(NSDictionary *responseObj) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSDictionary *info = [responseObj objectForKey:@"info"];
        _model = [[EmployeeModel alloc]initWithDictionary:info error:nil];
        NSArray *applications = [responseObj objectForKey:@"applications"];
        self.dataList = [ApplicationVisitModel arrayOfModelsFromDictionaries:applications];
        [self reloadData];
        
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

- (void)requestUpdateEmployeeInfo {
    
    if (_nameText.text.length <= 0) {
        [self.view showTipsView:@"请填写员工姓名！"];
        return;
    }
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (ApplicationVisitModel *appModel in self.dataList) {
        if ([appModel.allowVisit isEqualToString:@"1"]) {
            NSDictionary *dic = @{@"appId":appModel.application.id};
            [mutableArr addObject:dic];
        }
    }
    NSString *partyId =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    NSString *companyId =_model.id;

    NSDictionary *dic = @{@"applicationList":mutableArr,@"name":_nameText.text,@"rltCompanyPartyId":companyId,@"partyId":partyId};
    
    [self vs_showLoading];
    [self.manger requestUpdateEmployeeInfo:dic success:^(NSDictionary *responseObj) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:@"修改成功！" afterDelay:0.5f completeBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];

    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];

}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreCareCell *cell = (MoreCareCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    ApplicationVisitModel *model = self.dataList[indexPath.row];
    BOOL selected = cell.selectedCare;
    if (!selected) {
        cell.selectedCare = YES;
        model.allowVisit = @"1";
    }else {
        cell.selectedCare = NO;
        model.allowVisit = @"0";
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
    
    return 45;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    MoreCareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MoreCareCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreCareCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ApplicationVisitModel *model = self.dataList[indexPath.row];
    NSString *careStrng = model.allowVisit;
    if (careStrng && [careStrng isEqualToString:@"1"]) {
        cell.selectedCare = YES;
    }else {
        cell.selectedCare = NO;
    }
    cell.nameLabel.text = model.application.appName;
    
    
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
