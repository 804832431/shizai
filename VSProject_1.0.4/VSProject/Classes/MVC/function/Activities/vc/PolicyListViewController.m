//
//  PolicyListViewController.m
//  VSProject
//
//  Created by certus on 16/4/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import "PolicyListViewController.h"
#import "PolicyCell.h"
#import "VSWebViewController.h"
#import "ActivitiesManager.h"
#import "PolicyModel.h"
#import "HomeBTabbarViewController.h"
#import "VSJsWebViewController.h"

@interface PolicyListViewController () {
    
    ActivitiesManager *manger;
    int page;
    int row;
    
}

@end

@implementation PolicyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self vs_setTitleText:@"政策指引"];
    [self vs_showRightButton:YES];
    [self.vm_rightButton setImage:[UIImage imageNamed:@"home_icon"] forState:0];
    
    page = 1;
    row = 10;
    manger = [[ActivitiesManager alloc]init];
    _datalist = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- action

//重写右侧按钮点击事件
- (void)vs_rightButtonAction:(id)sender
{
    //    NSArray *titles = @[@"企业首页"];
    //    NSArray *images = @[@"home_icon"];
    //
    //    PopoverView *tmppopoverView = [[PopoverView alloc] initWithPoint:CGPointMake(MainWidth - self.vm_rightButton.frame.size.width, self.navigationController.navigationBar.frame.origin.y + self.vm_rightButton.frame.origin.y + self.vm_rightButton.frame.size.height - 1.0f) titles:titles images:images];
    //    tmppopoverView.selectRowAtIndex = ^(NSInteger index){
    //        if (index == 0) {
    HomeBTabbarViewController *homeB = [HomeBTabbarViewController shareInstance];
    homeB.tb.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
    //        }
    //    };
    //    [tmppopoverView show];
    
}
#pragma mark -- request

- (void)refresh {
    page = 1;
    [self requestPolicyList];
    
}

- (void)getmore {
    page ++;
    [self requestPolicyList];
    
}

//活动列表
- (void)requestPolicyList {
    
    [self vs_showLoading];
    NSString *organizationId = [VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.organizationId?:@"";
    NSDictionary *para = @{@"page":[NSNumber numberWithInt:page],@"row":[NSNumber numberWithInt:row],@"organizationId":organizationId};
    [manger requestPolicyList:para success:^(NSDictionary *responseObj) {
        //
        if (page == 1) {
            [_datalist removeAllObjects];
            [_tableView headerEndRefreshing];
        }else {
            [_tableView footerEndRefreshing];
        }
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSArray *list = [PolicyModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"policyList"] error:nil];
        
        if (list && [list isKindOfClass:[NSArray class]] && list.count > 0) {
            [_datalist addObjectsFromArray:list];
            [self.tableView reloadData];
        }
        [self refreshTableView];
    } failure:^(NSError *error) {
        //
        [self refreshTableView];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}


- (void)refreshTableView {
    
    [self.tableView reloadData];
    
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PolicyModel *p_model = _datalist[indexPath.row];
    NSString *urlString = p_model.visitURL;
    VSJsWebViewController *vc = [[VSJsWebViewController alloc]init];
    vc.webUrl = [NSURL URLWithString:urlString];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _datalist.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"PolicyCell";
    PolicyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PolicyCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PolicyModel *p_model = _datalist[indexPath.row];
    cell.p_titleLabel.text = p_model.title;
    cell.p_detaile.text = p_model.introduction;
    
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
