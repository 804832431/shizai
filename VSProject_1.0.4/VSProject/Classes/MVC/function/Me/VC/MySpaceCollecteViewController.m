//
//  MySpaceCollecteViewController.m
//  VSProject
//
//  Created by 张海东 on 2017/1/8.
//  Copyright © 2017年 user. All rights reserved.
//

#import "MySpaceCollecteViewController.h"
#import "SpaceLeaseTableViewCell.h"
#import "BCNetWorkTool.h"
#import "SpaceListModel.h"
#import "SpaceDetailWebViewController.h"
#import "MeEmptyDataView.h"

#define ROW_COUNT 10

@interface MySpaceCollecteViewController () <UITableViewDelegate, UITableViewDataSource>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, strong) NSMutableArray *spaceLeaseList;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MySpaceCollecteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    requestGroup = dispatch_group_create();
    
    self.curPage = 1;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[SpaceLeaseTableViewCell class] forCellReuseIdentifier:@"SpaceLeaseTableViewCell"];
    
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakself = self;
    [self.tableView addHeaderWithCallback:^{
        [weakself requestData];
    }];
    
    [self.tableView addFooterWithCallback:^{
        [weakself requestMoreData];
    }];
    
    [self.tableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView headerBeginRefreshing];
}

- (void)requestData {
    
    dispatch_group_enter(requestGroup);
    
    self.curPage = 1;
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *page = [NSString stringWithFormat:@"%ld", self.curPage];
    NSString *row = [NSString stringWithFormat:@"%d", ROW_COUNT];
    NSDictionary *dic = @{
                          @"objectType" : @"space",
                          @"partyId" : partyId,
                          @"page" : page,
                          @"row" : row,
                          };
    
    __weak typeof(self)weakself = self;
//    [self vs_showLoading];
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.collect/my-collect/version/1.5.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        NSArray *SpaceList = [dic mutableArrayValueForKey:@"collectList"];
        [self.spaceLeaseList removeAllObjects];
        for (NSInteger i=0; i<SpaceList.count; ++i) {
            NSDictionary *SpaceDic = [SpaceList objectAtIndex:i];
            if (SpaceDic) {
                SpaceListModel *model = [[SpaceListModel alloc] initWithDic:SpaceDic];
                [weakself.spaceLeaseList addObject:model];
            }
        }
        
        NSString *nextPage = [dic objectForKey:@"nextPage"];
        if ([nextPage isEqualToString:@"N"]) {
            [weakself.tableView removeFooter];
        }
        else {
            [weakself.tableView addFooterWithCallback:^{
                [weakself requestMoreData];
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

- (void)requestMoreData {
    
    dispatch_group_enter(requestGroup);
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *page = [NSString stringWithFormat:@"%ld", self.curPage];
    NSString *row = [NSString stringWithFormat:@"%d", ROW_COUNT];
    NSDictionary *dic = @{
                          @"objectType" : @"space",
                          @"partyId" : partyId,
                          @"page" : page,
                          @"row" : row,
                          };
    
    __weak typeof(self)weakself = self;
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.collect/my-collect/version/1.5.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        NSArray *SpaceList = [dic mutableArrayValueForKey:@"collectList"];
        for (NSInteger i=0; i<SpaceList.count; ++i) {
            NSDictionary *SpaceDic = [SpaceList objectAtIndex:i];
            if (SpaceDic) {
                SpaceListModel *model = [[SpaceListModel alloc] initWithDic:SpaceDic];
                [weakself.spaceLeaseList addObject:model];
            }
        }
        
        NSString *nextPage = [dic objectForKey:@"nextPage"];
        if ([nextPage isEqualToString:@"N"]) {
            [weakself.tableView removeFooter];
        }
        else {
            [weakself.tableView addFooterWithCallback:^{
                [weakself requestMoreData];
            }];
        }
        [weakself.tableView reloadData];
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        
        self.curPage ++;
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        [self.view showTipsView:[callBackData domain]];
        dispatch_group_leave(requestGroup);
    }];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), MainHeight - 64.0f - 7.5f);
        _tableView.headerHidden = YES;
        _tableView.tableHeaderView.frame = CGRectZero;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    
    return _tableView;
}

- (NSMutableArray *)spaceLeaseList {
    
    if (!_spaceLeaseList) {
        _spaceLeaseList = [NSMutableArray array];
    }
    return _spaceLeaseList;
}

#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.spaceLeaseList.count <= 0) {
        MeEmptyDataView *noDataView = [tableView viewWithTag:1011];
        if (noDataView == nil) {
            noDataView = [[MeEmptyDataView alloc] init];
        }
        
        [tableView addSubview:noDataView];
        noDataView.tag = 1011;
        noDataView.frame = self.tableView.frame;
    }
    else {
        MeEmptyDataView *noDataView = [tableView viewWithTag:1011];
        if (noDataView) {
            [noDataView removeFromSuperview];
        }
    }
    
    return self.spaceLeaseList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SpaceLeaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpaceLeaseTableViewCell" forIndexPath:indexPath];
    
    SpaceListModel *model = [self.spaceLeaseList objectAtIndex:indexPath.row];
    [cell setModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 107.5f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 7.5f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SpaceListModel *model = [self.spaceLeaseList objectAtIndex:indexPath.row];
    SpaceDetailWebViewController *webVC = [[SpaceDetailWebViewController alloc] initWithUrl:[NSURL URLWithString:model.spaceDetail]];
    webVC.model = model;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
