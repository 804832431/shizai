//
//  RTXLeaseListViewController.m
//  VSProject
//
//  Created by certus on 16/4/14.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXLeaseListViewController.h"
#import "LeaseListCell.h"
#import "RTXUbanManger.h"
#import "RentalModel.h"
#import "RTXSubmitUbanViewController.h"
#import "RTXUbanRentalDetailViewController.h"

@interface RTXLeaseListViewController () {
    
    RTXUbanManger *manger;
    int page;
    int row;
}

@property (strong, nonatomic) IBOutlet UIButton *leaseBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datalist;

@end

@implementation RTXLeaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

    self.leaseBtn.clipsToBounds = YES;
    self.leaseBtn.layer.cornerRadius = 5;
    [self.leaseBtn addTarget:self action:@selector(addRentalInfo) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- action

- (void)addRentalInfo {

    RTXSubmitUbanViewController *vc = [[RTXSubmitUbanViewController alloc]init];
    if (!self.navigationController) {
        [_nav pushViewController:vc animated:YES];
    }else {
        [self.navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark -- request

- (void)refresh {
    page = 1;
    [self getAllUbanRentalInfo];
    
}

- (void)getmore {
    page ++;
    [self getAllUbanRentalInfo];
    
}
- (void)getAllUbanRentalInfo {
    [self vs_showLoading];
    
    NSMutableDictionary *submitDic = [NSMutableDictionary dictionary];
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    [submitDic setObject:partyId forKey:@"partyId"];
    [submitDic setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [submitDic setObject:[NSNumber numberWithInt:row] forKey:@"row"];
    
    [manger getAllUbanRentalInfo:submitDic success:^(NSDictionary *responseObj) {
        //
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSError *err;
        NSArray *list = [RentalModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"myRental"] error:&err];
        
        if (list && [list isKindOfClass:[NSArray class]] && list.count > 0) {
            if (page == 1) {
                _datalist = [NSMutableArray arrayWithArray:list];
                [self.tableView headerEndRefreshing];
            }else {
                [_datalist addObjectsFromArray:list];
                [self.tableView footerEndRefreshing];
            }
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
    
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RTXUbanRentalDetailViewController *vc = [[RTXUbanRentalDetailViewController alloc]init];
    RentalModel *model = _datalist[indexPath.row];
    vc.m_id = model.id;
    if (!self.navigationController) {
        [_nav pushViewController:vc animated:YES];
    }else {
        [self.navigationController pushViewController:vc animated:YES];
    }

}


#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _datalist.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"LeaseListCell";
    LeaseListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LeaseListCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    RentalModel *model = _datalist[indexPath.row];
    [cell vp_updateUIWithModel:model];
    return cell;
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
