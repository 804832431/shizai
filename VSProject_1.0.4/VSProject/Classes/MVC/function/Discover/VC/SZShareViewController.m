//
//  SZShareViewController.m
//  VSProject
//
//  Created by pangchao on 16/12/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SZShareViewController.h"
#import "SZShareTableViewCell.h"
#import "BCNetWorkTool.h"
#import "PolicyModel.h"
#import "MJExtension.h"
#import "EnterpriceInfoViewController.h"

#define ROW_COUNT 10

@interface SZShareViewController () <UITableViewDelegate, UITableViewDataSource>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, strong) NSMutableArray *shareList;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SZShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"时在分享"];
    
    self.navigationController.navigationBarHidden = YES;
    [self.view setBackgroundColor:_Colorhex(0xefeff4)];
    
    requestGroup = dispatch_group_create();
    
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakself = self;
    [self.tableView addHeaderWithCallback:^{
        [weakself loadShareData];
    }];
    
    [self.tableView addFooterWithCallback:^{
        [weakself loadMoreShareData];
    }];
    
    [self.tableView registerClass:[SZShareTableViewCell class] forCellReuseIdentifier:@"SZShareTableViewCell"];
    
    self.curPage = 1;
    [self.tableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 44.0f);
        _tableView.headerHidden = YES;
        _tableView.tableHeaderView.frame = CGRectZero;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (void)refresh {
    
    self.curPage = 1;
    [self.tableView headerBeginRefreshing];
}

// 获取实在分享
- (void)loadShareData {
    
    dispatch_group_enter(requestGroup);
    
    self.curPage = 1;
    NSString *page = [NSString stringWithFormat:@"%ld", self.curPage];
    NSString *row = [NSString stringWithFormat:@"%d", ROW_COUNT];
    NSDictionary *dic = @{
                          @"type" :@"newsShare",
                          @"page" : page,
                          @"row" : row,
                          };
    
    __weak typeof(self)weakself = self;
//    [self vs_showLoading];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.news/get-home-news/version/1.5.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        [weakself.shareList removeAllObjects];
        weakself.shareList = [PolicyModel mj_objectArrayWithKeyValuesArray:dic[@"policyList"]];
        
        NSString *count = [dic objectForKey:@"count"];
        if ([count integerValue] <= weakself.shareList.count) {
            [weakself.tableView removeFooter];
        }
        else {
            [weakself.tableView addFooterWithCallback:^{
                [weakself loadMoreShareData];
            }];
        }
        
        weakself.curPage ++;
        [weakself.tableView reloadData];
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        [self.view showTipsView:[callBackData domain]];
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadMoreShareData {
    
    dispatch_group_enter(requestGroup);
    
    NSString *page = [NSString stringWithFormat:@"%ld", self.curPage];
    NSString *row = [NSString stringWithFormat:@"%d", ROW_COUNT];
    NSDictionary *dic = @{
                          @"type" :@"newsShare",
                          @"page" : page,
                          @"row" : row,
                          };
    
    __weak typeof(self)weakself = self;
    [self vs_showLoading];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.news/get-home-news/version/1.5.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        NSArray *shreMoreList = [PolicyModel mj_objectArrayWithKeyValuesArray:dic[@"policyList"]];
        [weakself.shareList addObjectsFromArray:shreMoreList];
        
        NSString *count = [dic objectForKey:@"count"];
        if ([count integerValue] <= weakself.shareList.count) {
            [weakself.tableView removeFooter];
        }
        else {
            [weakself.tableView addFooterWithCallback:^{
                [weakself loadMoreShareData];
            }];
        }
        
        weakself.curPage ++;
        [weakself.tableView reloadData];
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
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

#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.shareList.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SZShareTableViewCell" forIndexPath:indexPath];
    
    PolicyModel *model = [self.shareList objectAtIndex:indexPath.section];
    [cell setModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return Get750Width(228.0f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return Get750Width(20.0f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.00001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PolicyModel *model = [self.shareList objectAtIndex:indexPath.section];
    EnterpriceInfoViewController *webVC = [[EnterpriceInfoViewController alloc] initWithUrl:[NSURL URLWithString:model.visitURL]];
    [webVC hideFlow];
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
