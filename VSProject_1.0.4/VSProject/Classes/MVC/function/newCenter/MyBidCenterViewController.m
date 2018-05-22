//
//  MyBidCenterViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/23.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MyBidCenterViewController.h"
#import "MyBidCenterTableViewCell.h"
#import "MyBidListCenterViewController.h"
#import "MyBidCollectionViewController.h"
#import "MyAuthHistoryViewController.h"
#import "BidderManager.h"
#import "AuthEnterpriseViewController.h"
#import "AuthStatusUnReslovedViewController.h"
#import "AuthStatusPassOrRejectViewController.h"
#import "BCNetWorkTool.h"
#import "MJExtension.h"
#import "BidDepositBackListViewController.h"

@interface MyBidCenterViewController ()
{
    
    NSArray *topNameArray;
    
}

_PROPERTY_NONATOMIC_STRONG(UITableView, tableView)
_PROPERTY_NONATOMIC_STRONG(UIImageView, headImageView)
_PROPERTY_NONATOMIC_STRONG(UILabel, nickNameLabel)

@end

@implementation MyBidCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    
    [self vs_showRightButton:NO];
    
    
    [self vs_setTitleText:@"我的招投标"];
    
    
    topNameArray = @[@"我的投标",@"企业认证",@"我的收藏",@"保证金退款"];
    
    
    [self.view addSubview:self.tableView];
    
    
}





#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return topNameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 49;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyBidCenterTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyBidCenterTableViewCell class])];
    
    
    
    cell.contentTitleLabel.text = topNameArray[indexPath.row];
    
    
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = topNameArray[indexPath.row];
    
    //@[@"我的投标",@"企业认证",@"我的收藏"];
    if ([title isEqualToString:@"我的投标"]) {
        
        [self vs_showLoading];
        
        NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
        
        NSDictionary *dic = @{
                              @"partyId" : partyId
                              };
        
        [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-authed-enterprise/version/1.2.0" withSuccess:^(id callBackData) {
            
            [self vs_hideLoadingWithCompleteBlock:nil];
            
            [BidderManager shareInstance].authedEnterPrise = [AuthedEnterprise mj_objectWithKeyValues:callBackData];
            
            
            MyBidListCenterViewController *vc = [MyBidListCenterViewController new];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        } orFail:^(id callBackData) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            
            MyBidListCenterViewController *vc = [MyBidListCenterViewController new];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        
        
        
    }else if ([title isEqualToString:@"企业认证"]) {
        
        [self vs_showLoading];
        
        NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
        
        NSDictionary *dic = @{
                              @"partyId" : partyId
                              };
        
        [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-authed-enterprise/version/1.2.0" withSuccess:^(id callBackData) {
            
            [self vs_hideLoadingWithCompleteBlock:nil];
            
            [BidderManager shareInstance].authedEnterPrise = [AuthedEnterprise mj_objectWithKeyValues:callBackData];
            
            
            NSString *status = [BidderManager shareInstance].authedEnterPrise.authStatus;
            
            if ([status isEqualToString:@"UNAPPLY"]) {
                AuthEnterpriseViewController *vc = [AuthEnterpriseViewController new];
                [vc setDataSource:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder];
                [self.navigationController pushViewController:vc animated:YES];
            }else if([status isEqualToString:@"UNRESOLVED"]){
                
                AuthStatusUnReslovedViewController *vc = [[AuthStatusUnReslovedViewController alloc] initWithNibName:@"AuthStatusUnReslovedViewController" bundle:nil];
                
                [self.navigationController pushViewController:vc animated:YES ];
                
            }else if([status isEqualToString:@"PASS"]){
                
                AuthStatusPassOrRejectViewController *vc = [[AuthStatusPassOrRejectViewController alloc] initWithNibName:@"AuthStatusPassOrRejectViewController" bundle:nil];
                
                [vc.statusView.statusButton setTitle:@"认证已通过" forState:UIControlStateNormal];
                [vc.statusView.statusButton setTitleColor:_Colorhex(0x2f9f7e) forState:UIControlStateNormal];
                [vc.statusView.statusButton setImage:[UIImage imageNamed:@"msg_icon_n_2"] forState:UIControlStateNormal];
                
                vc.data = [BidderManager shareInstance].authedEnterPrise;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if([status isEqualToString:@"REJECT"]){
                AuthEnterpriseViewController *vc = [AuthEnterpriseViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
            
            
            
        } orFail:^(id callBackData) {
            [self vs_hideLoadingWithCompleteBlock:nil];
        }];
        

    }else if ([title isEqualToString:@"我的收藏"]) {
        
        MyBidCollectionViewController *vc = [MyBidCollectionViewController new];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"保证金退款"]) {
        
        BidDepositBackListViewController *vc = [BidDepositBackListViewController new];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view)) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = (id<UITableViewDelegate>)self;
        _tableView.dataSource = (id<UITableViewDataSource>)self;
        
        _tableView.backgroundColor = _COLOR_WHITE;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        [_tableView registerClass:[MyBidCenterTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MyBidCenterTableViewCell class])];
    }
    
    
    return _tableView;
    
}

@end
