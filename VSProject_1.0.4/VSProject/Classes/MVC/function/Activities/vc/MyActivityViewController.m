//
//  MyActivityViewController.m
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MyActivityViewController.h"
#import "GreatActivityDetailViewController.h"
#import "MyActivityCell.h"
#import "ActivityModel.h"
#import "MyActivityListModel.h"
#import "ActivitiesManager.h"

@interface MyActivityViewController (){
    
    ActivitiesManager *manger;
    int page;
    int row;
    
}

@end

@implementation MyActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self vs_setTitleText:@"我的活动"];
    
    page = 1;
    row = 10;
    manger = [[ActivitiesManager alloc]init];
    _datalist = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    [_tableView headerBeginRefreshing];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- request

- (void)refresh {
    page = 1;
    [self requestGreatActivityList];
    
}

- (void)getmore {
    //    page ++;
    page = page /row + 1;
    [self requestGreatActivityList];
    
}

//收货地址列表
- (void)requestGreatActivityList {
    
    [self vs_showLoading];
    NSDictionary *para = @{@"page":[NSNumber numberWithInt:page],@"row":[NSNumber numberWithInt:row]};
    [manger requestMytActivityList:para success:^(NSDictionary *responseObj) {
        //
        if (page == 1) {
            [_datalist removeAllObjects];
            [_tableView headerEndRefreshing];
        }else {
            [_tableView footerEndRefreshing];
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSError *err;
        //        listModel = [[MessageListModel alloc]initWithDictionary:responseObj error:&err];
        NSArray *list = [MyActivityListModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"myActivityList"] error:nil];
        NSLog(@"err--%@",err);
        
        if (list && [list isKindOfClass:[NSArray class]] && list.count > 0) {
            [_datalist addObjectsFromArray:list];
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.tableView reloadData];
        }
        
        if (self.datalist.count % row > 0) {
            [self.tableView removeFooter];
        }else{
            __weak typeof(self) weakSelf = self;
            [self.tableView addFooterWithCallback:^{
                [weakSelf getmore];
            }];
        }
        
        
    } failure:^(NSError *error) {
        //
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

#pragma mark -- Action

- (void)vs_back {
    
    if (_backwhere == BACK_ROOT) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)backHome {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)ActivityDetailView:(UIButton *)sender {
    
    NSUInteger index = sender.tag -100;
    
    MyActivityListModel *m_model = [_datalist objectAtIndex:index];
    GreatActivityDetailViewController *vcontroller = [[GreatActivityDetailViewController alloc]init];
    vcontroller.a_model = m_model.activity;
    [self.navigationController pushViewController:vcontroller animated:YES];
    
}
#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _datalist.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    MyActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyActivityCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ActivityModel *a_model = [_datalist objectAtIndex:indexPath.row];
    [cell vp_updateUIWithModel:a_model];
    [cell.topButton addTarget:self action:@selector(ActivityDetailView:) forControlEvents:UIControlEventTouchUpInside];
    cell.topButton.tag = 100+indexPath.row;
    
    return cell;
}

_GETTER_ALLOC_BEGIN(UITableView, tableView) {
    
    _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view));
    _tableView.backgroundColor = _COLOR_HEX(0xf1f1f1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>)self;
    __weak typeof(self)weakself = self;
    [_tableView addHeaderWithCallback:^{
        [weakself refresh];
    }];
    [_tableView addFooterWithCallback:^{
        [weakself getmore];
    }];
}
_GETTER_END(tableView)
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
