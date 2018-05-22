//
//  MyAuthHistoryViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MyAuthHistoryViewController.h"
#import "UIColor+TPCategory.h"
#import "AuthTableViewCell.h"
#import "BidderManager.h"
#import "BCNetWorkTool.h"
#import "AuthHistoryDTO.h"
#import "MJExtension.h"
#import "BidNoDataView.h"
#import "AuthStatusUnReslovedViewController.h"
#import "AuthStatusPassOrRejectViewController.h"

@interface MyAuthHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *data;

@end

@implementation MyAuthHistoryViewController



- (void)_initTableViews{
    
    __weak typeof(&*self) weakSelf = self;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor colorFromHexRGB:@"f1f1f1"];
    
    self.tableView = tableView;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    
    [tableView registerClass:[AuthTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AuthTableViewCell class])];
    
    [tableView addHeaderWithCallback:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf vs_showLoading];
        });
        
        NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
        
        NSString * bidderId = [BidderManager shareInstance].authedEnterPrise.bidder.id?:@"";
        
        NSDictionary *dic = @{@"page":@"1",@"row":@"10",@"partyId":partyId,@"bidderId":bidderId};
        
        
        [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/bidder-apply-history/version/1.2.0" withSuccess:^(id callBackData) {
            
            NSDictionary *dic = (NSDictionary *)callBackData;
            
            NSLog(@"%@",dic);
            
            weakSelf.data = [AuthHistoryDTO mj_objectArrayWithKeyValuesArray:dic[@"applyList"]];
            
            
            [weakSelf.tableView headerEndRefreshing];
            [weakSelf.tableView footerEndRefreshing];
            
            [weakSelf.tableView reloadData];
            
            if ([dic[@"nextPage"] isEqualToString:@"Y"]) {
                [weakSelf.tableView setFooterHidden:NO];
            }else{
                [weakSelf.tableView setFooterHidden:YES];
            }
            
            [weakSelf vs_hideLoadingWithCompleteBlock:nil];
            
            
            
            
        } orFail:^(id callBackData) {
            
            [weakSelf.view showTipsView:[callBackData domain]];
            
            [weakSelf.tableView headerEndRefreshing];
            [weakSelf.tableView footerEndRefreshing];
            
            [weakSelf vs_hideLoadingWithCompleteBlock:nil];
        }];
        
    }];
    
    
    
    
    [tableView addFooterWithCallback:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf vs_showLoading];
        });
        
        
        NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
        
        NSString * bidderId = [BidderManager shareInstance].authedEnterPrise.bidder.id?:@"";
        
        NSInteger page = self.data.count / 10 + 1;
        
        NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%zi",page],@"row":@"10",@"partyId":partyId,@"bidderId":bidderId};
        
        
        [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/bidder-apply-history/version/1.2.0" withSuccess:^(id callBackData) {
            
            NSDictionary *dic = (NSDictionary *)callBackData;
            
            NSLog(@"%@",dic);
            
            NSArray *tmp = [AuthHistoryDTO mj_objectArrayWithKeyValuesArray:dic[@"applyList"]];
            
            weakSelf.data = [weakSelf.data arrayByAddingObjectsFromArray:tmp];
            
            [weakSelf.tableView headerEndRefreshing];
            [weakSelf.tableView footerEndRefreshing];
            
            [weakSelf.tableView reloadData];
            
            if ( [dic[@"nextPage"] isEqualToString:@"Y"]) {
                [weakSelf.tableView setFooterHidden:NO];
            }else{
                [weakSelf.tableView setFooterHidden:YES];
            }
            
            [weakSelf vs_hideLoadingWithCompleteBlock:nil];
            
            
            
        } orFail:^(id callBackData) {
            
            [weakSelf.view showTipsView:[callBackData domain]];
            
            [weakSelf.tableView headerEndRefreshing];
            [weakSelf.tableView footerEndRefreshing];
            
            [weakSelf vs_hideLoadingWithCompleteBlock:nil];
        }];
        
    }];
    
}



#pragma mark -

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self vs_setTitleText:@"申请历史"];
    
    [self _initTableViews];
    
    [self.tableView headerBeginRefreshing];
    
    
}


#pragma mark -


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.data.count == 0) {
        BidNoDataView *noDataView = [self.tableView viewWithTag:1011];
        if (noDataView == nil) {
            noDataView = [BidNoDataView noDataViewWithType:BidNoDataViewTypeAuth];
        }
        
        [self.tableView addSubview:noDataView];
        
        noDataView.tag = 1011;
        
        noDataView.frame = self.view.bounds;
        
    }else{
        
        BidNoDataView *noDataView = [self.tableView viewWithTag:1011];
        if (noDataView) {
            [noDataView removeFromSuperview];
        }
    }
    
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AuthHistoryDTO *data = [self.data objectAtIndex:indexPath.row];
    
    if ([data.status isEqualToString:@"REJECT"]) {
        
        static  AuthTableViewCell *cell;
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AuthTableViewCell class])];
        });
        
        cell.dto = data;
        
        [cell.contentView setNeedsLayout];
        [cell.contentView layoutIfNeeded];
        
        CGFloat height = CGRectGetMaxY(cell.rejectReasonContent.frame);
        
        return height + 20;
        
    }else{
        return 160;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AuthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AuthTableViewCell class])];
    
    AuthHistoryDTO *data = [self.data objectAtIndex:indexPath.row];
    
    cell.dto = data;
    
    return cell;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorFromHexRGB:@"f0eff5"];
        
        return view;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    AuthHistoryDTO *data = [self.data objectAtIndex:indexPath.row];
    //    
    //    if ([data.status isEqualToString:@"UNRESOLVED"]) {
    //        
    //        AuthStatusUnReslovedViewController *vc = [[AuthStatusUnReslovedViewController alloc] initWithNibName:@"AuthStatusUnReslovedViewController" bundle:nil];
    //        
    //        [self.navigationController pushViewController:vc animated:YES ];
    //        
    //    }else  if ([data.status isEqualToString:@"PASS"]) {
    //        
    //        AuthStatusPassOrRejectViewController *vc = [[AuthStatusPassOrRejectViewController alloc] initWithNibName:@"AuthStatusPassOrRejectViewController" bundle:nil];
    //        
    //        [vc.statusView.statusButton setTitle:@"认证已通过" forState:UIControlStateNormal];
    //        [vc.statusView.statusButton setTitleColor:_Colorhex(0x2f9f7e) forState:UIControlStateNormal];
    //        [vc.statusView.statusButton setImage:[UIImage imageNamed:@"msg_icon_n_2"] forState:UIControlStateNormal];
    //        
    //        vc.dto = self.data[indexPath.row];
    //        
    //        [self.navigationController pushViewController:vc animated:YES];
    //        
    //    }else  if ([data.status isEqualToString:@"REJECT"]) {
    //        AuthStatusPassOrRejectViewController *vc = [[AuthStatusPassOrRejectViewController alloc] initWithNibName:@"AuthStatusPassOrRejectViewController" bundle:nil];
    //        [vc.statusView.statusButton setTitle:@"认证失败" forState:UIControlStateNormal];
    //        [vc.statusView.statusButton setTitleColor:_Colorhex(0x444444) forState:UIControlStateNormal];
    //        [vc.statusView.statusButton setImage:[UIImage imageNamed:@"list_icon_02"] forState:UIControlStateNormal];
    //        vc.dto = self.data[indexPath.row];
    //        
    //        [self.navigationController pushViewController:vc animated:YES];
    //    }
}

@end
