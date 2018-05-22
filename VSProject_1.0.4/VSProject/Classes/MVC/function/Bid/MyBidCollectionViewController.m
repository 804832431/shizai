//
//  MyBidCollectionViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/23.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MyBidCollectionViewController.h"
#import "UIColor+TPCategory.h"
#import "BidCenterTableViewCell.h"
#import "BidNoDataView.h"
#import "BCNetWorkTool.h"
#import "BidProject.h"
#import "MJExtension.h"
#import "BidWebViewController.h"
#import "MeEmptyDataView.h"

@interface MyBidCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *data;

@end

@implementation MyBidCollectionViewController



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
    
    UINib *nib = [UINib nibWithNibName:@"BidCenterTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([BidCenterTableViewCell class])];
    
    [tableView addHeaderWithCallback:^{
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf vs_showLoading];
//        });
        
        NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
        
        NSDictionary *dic = @{@"page":@"1",@"row":@"10",@"partyId":partyId};
        
        
        [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-my-collect-project/version/1.2.0" withSuccess:^(id callBackData) {
            
            NSDictionary *dic = (NSDictionary *)callBackData;
            
            weakSelf.data = [BidProject mj_objectArrayWithKeyValuesArray:dic[@"bidProjectList"]];
            
            
            [weakSelf.tableView headerEndRefreshing];
            [weakSelf.tableView footerEndRefreshing];
            
            [weakSelf.tableView reloadData];
            
            if ([dic[@"nextPage"] isEqualToString:@"Y"]) {
                [weakSelf.tableView setFooterHidden:NO];
            }else{
                [weakSelf.tableView setFooterHidden:YES];
            }
            
            [weakSelf vs_hideLoadingWithCompleteBlock:nil];
            
            if (weakSelf.data.count <= 0) {
                MeEmptyDataView *noDataView = [weakSelf.tableView viewWithTag:1011];
                if (noDataView == nil) {
                    noDataView = [[MeEmptyDataView alloc] init];
                }
                
                [weakSelf.tableView addSubview:noDataView];
                noDataView.tag = 1011;
                noDataView.frame = self.view.bounds;
            }
            else {
                MeEmptyDataView *noDataView = [weakSelf.tableView viewWithTag:1011];
                if (noDataView) {
                    [noDataView removeFromSuperview];
                }
            }
            
            
        } orFail:^(id callBackData) {
            
            [weakSelf.view showTipsView:[callBackData domain]];
            
            [weakSelf.tableView headerEndRefreshing];
            [weakSelf.tableView footerEndRefreshing];
            
            [weakSelf vs_hideLoadingWithCompleteBlock:nil];
        }];
        
    }];
    
    
    
    
    [tableView addFooterWithCallback:^{
        [weakSelf vs_showLoading];
        
        NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
        
        NSInteger page = weakSelf.data.count / 10 + 1;
        
        NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%zi",page],@"row":@"10",@"partyId":partyId};
        
        
        [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-my-collect-project/version/1.2.0" withSuccess:^(id callBackData) {
            
            NSDictionary *dic = (NSDictionary *)callBackData;
            
            NSArray *tmp = [BidProject mj_objectArrayWithKeyValuesArray:dic[@"bidProjectList"]];
            
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
    
    [self vs_setTitleText:@"我的收藏"];
    
    [self _initTableViews];
    
    [self.tableView headerBeginRefreshing];
}


#pragma mark -


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.data.count == 0) {
        MeEmptyDataView *noDataView = [tableView viewWithTag:1011];
        if (noDataView == nil) {
            noDataView = [[MeEmptyDataView alloc] init];
        }
        
        [tableView addSubview:noDataView];
        noDataView.tag = 1011;
        noDataView.frame = self.view.bounds;
        
    }else{
        
        MeEmptyDataView *noDataView = [tableView viewWithTag:1011];
        if (noDataView) {
            [noDataView removeFromSuperview];
        }
    }
    
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BidCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BidCenterTableViewCell class])];
    
    
    BidProject *data = [self.data objectAtIndex:indexPath.row];
    
    cell.dto = data;
    
    return cell;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorFromHexRGB:@"f0eff5"];
    
    return view;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 10;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BidProject *dto = [self.data objectAtIndex:indexPath.row];
    
    if (![dto.projectUrl isEmptyString]) {
        
        BidWebViewController *vc = [[BidWebViewController alloc] initWithUrl:[NSURL URLWithString:dto.projectUrl]];
        
        vc.isCollectionList = YES;
        
        vc.dto = dto;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
