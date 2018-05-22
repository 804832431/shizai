//
//  RTXUbanDetailViewController.m
//  VSProject
//
//  Created by XuLiang on 16/1/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXUbanDetailViewController.h"

#import "RTXMyUbanDetailCell.h"
#import "RTXUbanManger.h"
#import "LookHomeModel.h"

@interface RTXUbanDetailViewController () {

    RTXUbanManger *manger;
    int page;
    int row;

}
@property(nonatomic,strong)NSMutableArray *datalist;

@end

@implementation RTXUbanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vs_setTitleText:@"我的房屋信息"];
    _datalist = [NSMutableArray array];
    manger = [[RTXUbanManger alloc]init];
    page = 1;
    row = 10;
    __weak typeof(self)weakself = self;
    [self.tableView addHeaderWithCallback:^{
        [weakself refresh];
    }];
    [self.tableView addFooterWithCallback:^{
        [weakself getmore];
    }];
    [self refresh];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- request

- (void)refresh {
    page = 1;
    [self getShowHistory];
    
}

- (void)getmore {
    page ++;
    [self getShowHistory];
    
}

- (void)getShowHistory {
    [self vs_showLoading];
    
    NSMutableDictionary *submitDic = [NSMutableDictionary dictionary];
    [submitDic setObject:_m_id?:@"" forKey:@"ubanRentalId"];
    [submitDic setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [submitDic setObject:[NSNumber numberWithInt:row] forKey:@"row"];
    
    [manger getShowHistory:submitDic success:^(NSDictionary *responseObj) {
        //
        if (page == 1) {
            [_datalist removeAllObjects];
            [self.tableView headerEndRefreshing];
        }else {
            [self.tableView footerEndRefreshing];
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSArray *list = [LookHomeModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"showHistory"] error:nil];
        
        if (list && [list isKindOfClass:[NSArray class]] && list.count > 0) {
            [_datalist addObjectsFromArray:list];
            [self.tableView reloadData];
        }
        [self refreshTableView];
        
    } failure:^(NSError *error) {        //
        [self refreshTableView];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

- (void)refreshTableView {
    
    self.dataSource = @[_datalist];
    [self.tableView reloadData];
}

#pragma mark -- getter
_GETTER_BEGIN(NSArray, cellNameClasses)
{
    _cellNameClasses = @[[RTXMyUbanDetailCell class]
                         ];
}
_GETTER_END(cellNameClasses)

@end
