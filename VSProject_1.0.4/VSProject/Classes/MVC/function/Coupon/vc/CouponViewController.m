//
//  CouponViewController.m
//  VSProject
//
//  Created by certus on 16/4/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import "CouponViewController.h"
#import "CouponCell.h"
#import "CouponManger.h"
#import "CouponModel.h"

@interface CouponViewController () {
    
    NSMutableArray *couponList;
    CouponManger *manger;
    int page;
    int row;
    
}

@property (nonatomic,strong)NSArray *dataList;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;
@property (strong, nonatomic) IBOutlet UIButton *convertBtn;
@property (nonatomic,strong)UIView *noCouponView;

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self vs_setTitleText:@"优惠券"];
    
    couponList = [NSMutableArray array];
    manger = [[CouponManger alloc]init];
    page = 1;
    row = 10;
    __weak typeof(self)weakself = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView addHeaderWithCallback:^{
        [weakself refresh];
    }];
    [_tableView addFooterWithCallback:^{
        [weakself getmore];
    }];
    
    [_convertBtn addTarget:self action:@selector(actionConvert) forControlEvents:UIControlEventTouchUpInside];
    
    [_tableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- private

- (void)showNoCouponView {
    
    for (UIView *view in self.view.subviews) {
        if (view.tag == 10010) {
            return;
        }
    }
    [self.view insertSubview:self.noCouponView aboveSubview:self.tableView];
    
    [self.noCouponView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_tableView.mas_centerX);
        make.centerY.equalTo(_tableView.mas_centerY);
        make.width.equalTo(@150).offset(13);
        make.height.equalTo(@80);
    }];
}

- (void)hideNoCouponView {
    
    [self.noCouponView removeFromSuperview];
    
}
#pragma mark -- Action

- (void)refresh {
    page = 1;
    [self requestCouponList];
    
}

- (void)getmore {
    page ++;
    [self requestCouponList];
    
}

- (void)refreshTableView {
    
    if (couponList.count > 0) {
        [self hideNoCouponView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }else {
        [self showNoCouponView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.tableView reloadData];
    
}


- (void)actionConvert {
    [self requestConvertCoupon];
    
}

#pragma mark -- request

- (void)requestCouponList {
    
    [self.view bringSubviewToFront:self.progressHUD];
    [self vs_showLoading];
    NSString *username=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username?:@"";
    
    NSDictionary *para = @{@"page":[NSNumber numberWithInt:page],
                           @"row":[NSNumber numberWithInt:row],
                           @"userLoginId":username,
                           @"key":_key?:@"all",
                           @"orderAmount":_orderAmount?:@"",
                           @"merchantId":_merchantId?:@""
                           };
    [manger requestCouponList:para success:^(NSDictionary *responseObj) {
        //停止刷新
        if (page == 1) {
            [couponList removeAllObjects];
            [_tableView headerEndRefreshing];
        }else {
            [_tableView footerEndRefreshing];
        }
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        //数据
        NSArray *list = [CouponModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"couponList"] error:nil];
        
        if (list && [list isKindOfClass:[NSArray class]] && list.count > 0) {
            [couponList addObjectsFromArray:list];
        }
        
        [self refreshTableView];
    } failure:^(NSError *error) {
        //
        [self refreshTableView];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

- (void)requestConvertCoupon {
    
    NSString *convertCode = [_inputTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (convertCode.length <= 0) {
        [self.view showTipsView:@"请输入兑换码！"];
        return;
    }
    
//    else if (![JudgmentUtil validateDiscountCode:convertCode]) {
//        [self.view showTipsView:@"兑换码格式错误，请重新输入！"];
//        return;
//    }
    
    [self.view bringSubviewToFront:self.progressHUD];
    [self vs_showLoading];
    
    [_inputTextField resignFirstResponder];
    NSString *username=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.username?:@"";
    
    NSDictionary *para = @{@"userLoginId":username,@"code":convertCode};
    [manger requestConvertCoupon:para success:^(NSDictionary *responseObj) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        [self.view showTipsView:@"兑换成功！"];
        _inputTextField.text = @"";
        [_tableView headerBeginRefreshing];
    } failure:^(NSError *error) {
        //
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

#pragma mark -- UITableViewDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length <= 0) {
        [self refreshTableView];
    }
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_couponModelBlock) {
        CouponModel *m_model = [couponList objectAtIndex:indexPath.row];
        _couponModelBlock(m_model);
        [self vs_back];
    }
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return couponList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"CouponCell";
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CouponCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CouponModel *m_model = [couponList objectAtIndex:indexPath.row];
    [cell vp_updateUIWithModel:m_model];
    
    return cell;
}

- (UIView *)noCouponView {
    
    if (!_noCouponView) {
        _noCouponView = [[[NSBundle mainBundle]loadNibNamed:@"NoCoupon" owner:nil options:nil] lastObject];
        _noCouponView.tag = 10010;
    }
    return _noCouponView;
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
