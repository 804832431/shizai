//
//  EnterpriseChannelViewController.m
//  VSProject
//
//  Created by pangchao on 16/12/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "EnterpriseChannelViewController.h"
#import "EnterpriseTableViewCell.h"
#import "EnterpriseModel.h"
#import "BCNetWorkTool.h"
#import "EnterpriceInfoViewController.h"
#import "UIColor+TPCategory.h"

#define ROW_COUNT 10

@interface EnterpriseChannelViewController () <UITableViewDelegate, UITableViewDataSource>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, strong) NSMutableArray *enterpriseChannelList;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation EnterpriseChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"企业频道"];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.view setBackgroundColor:_Colorhex(0xefeff4)];
    
    requestGroup = dispatch_group_create();
    
    self.curPage = 1;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[EnterpriseTableViewCell class] forCellReuseIdentifier:@"EnterpriseTableViewCell"];
    
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakself = self;
    [self.tableView addHeaderWithCallback:^{
        [weakself loadEnterprise];
    }];
    
    [self.tableView addFooterWithCallback:^{
        [weakself loadMoreEnterprise];
    }];
    
    [self.tableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)refresh {
    
    [self.tableView headerBeginRefreshing];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 44.0f);
        _tableView.headerHidden = YES;
        _tableView.tableHeaderView.frame = CGRectZero;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;

    }
    
    return _tableView;
}

- (NSMutableArray *)enterpriseChannelList {
    
    if (!_enterpriseChannelList) {
        _enterpriseChannelList = [NSMutableArray array];
    }
    return _enterpriseChannelList;
}

// 获取企业频道数据
- (void)loadEnterprise {
    
    dispatch_group_enter(requestGroup);
    
    self.curPage = 1;
    NSString *page = [NSString stringWithFormat:@"%ld", self.curPage];
    NSString *row = [NSString stringWithFormat:@"%d", ROW_COUNT];
    NSDictionary *dic = @{
                          @"page" : page,
                          @"row" : row,
                          };
    
    __weak typeof(self)weakself = self;
//    [self vs_showLoading];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-enterprise-list/version/1.5.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        NSArray *enterpriseList = [dic mutableArrayValueForKey:@"enterpriseList"];
        [self.enterpriseChannelList removeAllObjects];
        for (NSInteger i=0; i<enterpriseList.count; ++i) {
            NSDictionary *enterpriseDic = [enterpriseList objectAtIndex:i];
            if (enterpriseDic) {
                EnterpriseModel *model = [[EnterpriseModel alloc] initWithDic:enterpriseDic];
                [weakself.enterpriseChannelList addObject:model];
            }
        }
        
        NSString *nextPage = [dic objectForKey:@"nextPage"];
        if ([nextPage isEqualToString:@"N"]) {
            [weakself.tableView removeFooter];
        }
        else {
            [weakself.tableView addFooterWithCallback:^{
                [weakself loadMoreEnterprise];
            }];
        }
        [weakself.tableView reloadData];
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        
        weakself.curPage ++;
        
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[callBackData domain]];
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadMoreEnterprise {
    
    dispatch_group_enter(requestGroup);
    
    NSString *page = [NSString stringWithFormat:@"%ld", self.curPage];
    NSString *row = [NSString stringWithFormat:@"%d", ROW_COUNT];
    NSDictionary *dic = @{
                          @"page" : page,
                          @"row" : row,
                          };
    
    __weak typeof(self)weakself = self;
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.policy/get-enterprise-list/version/1.5.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        NSArray *enterpriseList = [dic mutableArrayValueForKey:@"enterpriseList"];
        for (NSInteger i=0; i<enterpriseList.count; ++i) {
            NSDictionary *enterpriseDic = [enterpriseList objectAtIndex:i];
            if (enterpriseDic) {
                EnterpriseModel *model = [[EnterpriseModel alloc] initWithDic:enterpriseDic];
                [weakself.enterpriseChannelList addObject:model];
            }
        }
        
        NSString *nextPage = [dic objectForKey:@"nextPage"];
        if ([nextPage isEqualToString:@"Y"]) {
            [weakself.tableView removeFooter];
        }
        else {
            [weakself.tableView addFooterWithCallback:^{
                [weakself loadMoreEnterprise];
            }];
        }
        [weakself.tableView reloadData];
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        [self.view showTipsView:[callBackData domain]];
        dispatch_group_leave(requestGroup);
    }];
}

#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.enterpriseChannelList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EnterpriseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnterpriseTableViewCell" forIndexPath:indexPath];
    
    EnterpriseModel *model = [self.enterpriseChannelList objectAtIndex:indexPath.section];
    [cell setModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return Get750Width(476.0f + 48.0f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return Get750Width(20.0f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EnterpriseModel *model = [self.enterpriseChannelList objectAtIndex:indexPath.section];
    EnterpriceInfoViewController *webVC = [[EnterpriceInfoViewController alloc] initWithUrl:[NSURL URLWithString:model.enterpriseDetail]];
    webVC.barColorStr = model.themeColor;
    [webVC hideFlow];
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
