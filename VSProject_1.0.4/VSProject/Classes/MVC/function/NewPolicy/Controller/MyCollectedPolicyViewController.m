//
//  MyCollectedPolicyViewController.m
//  VSProject
//
//  Created by apple on 11/7/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "MyCollectedPolicyViewController.h"
#import "NewPolicyManager.h"
#import "NewPolicyCell.h"
#import "NewPolicyDetaileViewController.h"
#import "MeEmptyDataView.h"

@interface MyCollectedPolicyViewController ()
{
    NewPolicyManager *manger;
    int page;
    int row;
    dispatch_group_t requestGroup;
}

_PROPERTY_NONATOMIC_STRONG(UIView, emptyView)

@end

@implementation MyCollectedPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self vs_setTitleText:@"我的收藏"];
    
    requestGroup = dispatch_group_create();
    
    page = 1;
    row = 10;
    manger = [[NewPolicyManager alloc] init];
    _datalist = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    [_tableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 64)];
        [_emptyView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((__SCREEN_WIDTH__ - 60)/2, 53, 60, 55)];
        [imageView setImage:__IMAGENAMED__(@"bg_img_nothing")];
        [_emptyView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 53 + 55 +14, __SCREEN_WIDTH__, 21)];
        [label setText:@"您当前没有收藏的政策"];
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setTextColor:ColorWithHex(0x5c5c5c, 1.0)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [_emptyView addSubview:label];
    }
    return _emptyView;
}

#pragma mark -- request

- (void)refresh {
    page = 1;
    [self requestCollectedActivityList];
    
}

- (void)getmore {
    //    page ++;
    page = page /row + 1;
    [self requestCollectedActivityList];
    
}

//活动列表
- (void)requestCollectedActivityList {
    
//    [self vs_showLoading];
    [self startRequest];
    
    [manger onRequestCollectedPolicyList:[NSString stringWithFormat:@"%d",page] row:[NSString stringWithFormat:@"%d",row] partyId:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"" success:^(NSDictionary *responseObj) {
        NSError *err;
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSArray *list = [NewPolicyModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"policyList"] error:&err];
        
        if (list && [list isKindOfClass:[NSArray class]] && list.count > 0) {
            if (page == 1) {
                _datalist = [NSMutableArray arrayWithArray:list];
                [_tableView headerEndRefreshing];
            }else {
                [_datalist addObjectsFromArray:list];
                [_tableView footerEndRefreshing];
            }
        }
        
        if (self.datalist.count % row > 0) {
            [self.tableView removeFooter];
        }else{
            __weak typeof(self) weakSelf = self;
            [self.tableView addFooterWithCallback:^{
                [weakSelf getmore];
            }];
        }
        
        if ([self.datalist count] == 0) {
//            [self.view addSubview:self.emptyView];
            [_tableView headerEndRefreshing];
        }
        
        [_tableView reloadData];
        [self endRequest];
    } failure:^(NSError *error) {
        [self endRequest];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [self vs_hideLoadingWithCompleteBlock:nil];
        [self.view showTipsView:[error domain]];
    }];
}

- (void)startRequest {
    
    dispatch_group_enter(requestGroup);
    
}
- (void)endRequest {
    
    dispatch_group_leave(requestGroup);
    
}

#pragma mark -- Action

- (void)backHome {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)ActivityDetailView:(UIButton *)sender {
    
    NSUInteger index = sender.tag -100;
    
    NewPolicyModel *p_model = [_datalist objectAtIndex:index];
    NewPolicyDetaileViewController *vcontroller = [[NewPolicyDetaileViewController alloc]init];
    vcontroller.p_model = p_model;
    [self.navigationController pushViewController:vcontroller animated:YES];
    
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewPolicyModel *p_model = [_datalist objectAtIndex:indexPath.row];
    NewPolicyDetaileViewController *vcontroller = [[NewPolicyDetaileViewController alloc]init];
    vcontroller.p_model = p_model;
    vcontroller.webUrl = [NSURL URLWithString:vcontroller.p_model.policyDetail];
    [self.navigationController pushViewController:vcontroller animated:YES];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_datalist.count <= 0) {
        MeEmptyDataView *noDataView = [tableView viewWithTag:1011];
        if (noDataView == nil) {
            noDataView = [[MeEmptyDataView alloc] init];
        }
        
        [tableView addSubview:noDataView];
        noDataView.tag = 1011;
        noDataView.frame = self.view.bounds;
    }
    else {
        MeEmptyDataView *noDataView = [tableView viewWithTag:1011];
        if (noDataView) {
            [noDataView removeFromSuperview];
        }
    }
    return _datalist.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewPolicyModel *p_model = [_datalist objectAtIndex:indexPath.row];
    
    CGSize titleSize = [p_model.policyName boundingRectWithSize:CGSizeMake(__SCREEN_WIDTH__ - 19, MAXFLOAT)
                                                        options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}
                                                        context:nil].size;
    
    CGFloat height = titleSize.height;
    
//    return height + 83;
    return 120;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"NewPolicyCell";
    NewPolicyCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NewPolicyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NewPolicyCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewPolicyModel *p_model = [_datalist objectAtIndex:indexPath.row];
    [cell setDataSource:p_model];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setFrame:CGRectMake(12, 5, __SCREEN_WIDTH__ - 24, 100)];
    
    return cell;
}

_GETTER_ALLOC_BEGIN(UITableView, tableView) {
    
    _tableView.frame = CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view));
    _tableView.backgroundColor = _COLOR_HEX(0xeeeeee);
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

@end
