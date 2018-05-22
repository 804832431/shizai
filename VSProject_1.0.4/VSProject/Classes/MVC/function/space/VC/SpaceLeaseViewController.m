//
//  SpaceLeaseViewController.m
//  VSProject
//
//  Created by pangchao on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpaceLeaseViewController.h"
#import "BCNetWorkTool.h"
#import "SpaceListModel.h"
#import "SpaceLeaseTableViewCell.h"
#import "SpacePurchaseTableViewCell.h"
#import "SpaceDetailWebViewController.h"

#define ROW_COUNT 10

@interface SpaceLeaseViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, strong) NSMutableArray *spaceLeaseList;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SpaceLeaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"空间租赁"];
    
    self.navigationController.navigationBarHidden = YES;
    
    requestGroup = dispatch_group_create();
    
    self.curPage = 1;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[SpaceLeaseTableViewCell class] forCellReuseIdentifier:@"SpaceLeaseTableViewCell"];
    [self.tableView registerClass:[SpacePurchaseTableViewCell class] forCellReuseIdentifier:@"SpacePurchaseTableViewCell"];
    
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakself = self;
    [self.tableView addHeaderWithCallback:^{
        [weakself requestData];
    }];
    
    [self.tableView addFooterWithCallback:^{
        [weakself requestMoreData];
    }];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)refresh {
    
    [self requestData];
}

- (CGFloat)getViewHeight {
    
    if ([self.classId isEqualToString:@"spaceAcquisition"]) {
        return 185.0f * self.spaceLeaseList.count;
    }
    else {
        return 107.5f * self.spaceLeaseList.count;
    }
}

- (void)requestData {
    
    dispatch_group_enter(requestGroup);
    
    self.curPage = -1;
    NSString *classId = self.classId;
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *page = [NSString stringWithFormat:@"%ld", self.curPage];
    NSString *row = [NSString stringWithFormat:@"%ld", ROW_COUNT];
    NSDictionary *dic = @{
                          @"classId" : classId,
                          @"partyId" : partyId,
                          @"page" : page,
                          @"row" : @"-1",
                          };
    
    __weak typeof(self)weakself = self;
//    [self vs_showLoading];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.space/get-space-list/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        NSArray *SpaceList = [dic mutableArrayValueForKey:@"spaceList"];
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
        
        weakself.tableView.frame = CGRectMake(0, 0, MainWidth, [weakself getViewHeight] + 20.0f);
        [weakself.tableView reloadData];
        weakself.loadDataSuccessBolck();
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
    
    NSString *classId = self.classId;
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    NSString *page = [NSString stringWithFormat:@"%ld", self.curPage];
    NSString *row = [NSString stringWithFormat:@"%d", ROW_COUNT];
    NSDictionary *dic = @{
                          @"classId" : classId,
                          @"partyId" : partyId,
                          @"page" : page,
                          @"row" : row,
                          };
    
    __weak typeof(self)weakself = self;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.space/get-space-list/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        NSArray *spaceList = [dic mutableArrayValueForKey:@"spaceList"];
        for (NSInteger i=0; i<spaceList.count; ++i) {
            NSDictionary *spaceDic = [spaceList objectAtIndex:i];
            if (spaceDic) {
                SpaceListModel *model = [[SpaceListModel alloc] initWithDic:spaceDic];
                [weakself.spaceLeaseList addObject:model];
            }
        }
        
        NSString *nextPage = [dic objectForKey:@"nextPage"];
        if ([nextPage isEqualToString:@"Y"]) {
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
        _tableView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 44.0f);
        _tableView.headerHidden = YES;
        _tableView.tableHeaderView.frame = CGRectZero;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setScrollEnabled:NO];
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
    
    return self.spaceLeaseList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.classId isEqualToString:@"spaceAcquisition"]) {
        SpacePurchaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpacePurchaseTableViewCell" forIndexPath:indexPath];
        
        SpaceListModel *model = [self.spaceLeaseList objectAtIndex:indexPath.row];
        [cell setModel:model];
        return cell;
    }
    else {
        SpaceLeaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpaceLeaseTableViewCell" forIndexPath:indexPath];
        
        SpaceListModel *model = [self.spaceLeaseList objectAtIndex:indexPath.row];
        [cell setModel:model];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.classId isEqualToString:@"spaceAcquisition"]) {
        return 185.0f;
    }
    else {
        return 107.5f;
    }
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
