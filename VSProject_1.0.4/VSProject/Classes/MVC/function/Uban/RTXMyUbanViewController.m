//
//  RTXMyUbanViewController.m
//  VSProject
//
//  Created by XuLiang on 16/1/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXMyUbanViewController.h"
#import "RTXMyUbanAbstractCell.h"
#import "RTXUbanDetailViewController.h"
#import "RTXUbanManger.h"
#import "MyRentalModel.h"

@interface RTXMyUbanViewController ()<RTXMyUbanAbstractCellDelegate> {

    RTXUbanManger *manger;
    int page;
    int row;

}

@property(nonatomic,strong)NSMutableArray *datalist;

@end

@implementation RTXMyUbanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _datalist = [NSMutableArray array];
    self.tableView.frame = self.view.bounds;
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
    [self getMyUbanRentalInfo];
    
}

- (void)getmore {
    page ++;
    [self getMyUbanRentalInfo];
    
}
- (void)getMyUbanRentalInfo {
    [self vs_showLoading];
    
    NSMutableDictionary *submitDic = [NSMutableDictionary dictionary];
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    [submitDic setObject:partyId forKey:@"partyId"];
    [submitDic setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [submitDic setObject:[NSNumber numberWithInt:row] forKey:@"row"];

    [manger getMyUbanRentalInfo:submitDic success:^(NSDictionary *responseObj) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(refreshRedPoint)]) {
            [_delegate refreshRedPoint];
        }
        //
        if (page == 1) {
            [_datalist removeAllObjects];
            [self.tableView headerEndRefreshing];
        }else {
            [self.tableView footerEndRefreshing];
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSError *err;
//        _listModel = [[RentalModel alloc]initWithDictionary:responseObj error:&err];
        NSArray *list = [MyRentalModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"myRental"] error:&err];
        NSLog(@"err--%@",err);
        
        if (list && [list isKindOfClass:[NSArray class]] && list.count > 0) {
            [_datalist addObjectsFromArray:list];
        }
        [self refreshTableView];
    } failure:^(NSError *error) {
        //
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
    _cellNameClasses = @[[RTXMyUbanAbstractCell class]
                         ];
}
_GETTER_END(cellNameClasses)

#pragma mark --RTXMyUbanAbstractCellDelegate
- (void)ToOrderDetail:(id)model{
    NSLog(@"%@",model);
    RTXUbanDetailViewController *detail = [[RTXUbanDetailViewController alloc] init];
    detail.m_id = (NSString *)model;
    if (!self.navigationController) {
        [_nav pushViewController:detail animated:YES];
    }else {
        [self.navigationController pushViewController:detail animated:YES];
    }
}
@end
