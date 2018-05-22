//
//  GreatActivityListViewController.m
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "GreatActivityListViewController.h"
#import "NewActivityDetailViewController.h"
#import "NewActivityCell.h"
#import "NewActivityModel.h"
#import "ActivityModel.h"
#import "NewActivitiesManager.h"
#import "VSUserLoginViewController.h"
#import "CenterViewController.h"
#import "NewActivityListModel.h"
#import "ActivityListModel.h"
#import "MessageViewController.h"
#import "VSWebViewController.h"
#import "HomeBTabbarViewController.h"
#import "VSJsWebViewController.h"
//1.5.0
#import "BCNetWorkTool.h"
#import "BannerDTO.h"
#import "MJExtension.h"
#import "AdsTableViewCell.h"
#import "CompeleteActivityTableViewCell.h"
#import "ActivityCoorperationViewController.h"

@interface GreatActivityListViewController () {
    NewActivitiesManager *newManager;
    int page;
    int row;
    dispatch_group_t requestGroup;
}

@property (nonatomic,strong)NewActivityListModel *listModel;

@property (nonatomic,strong)NewActivityListModel *completeListModel;

@property (nonatomic,strong) NSArray *adList;

@end

@implementation GreatActivityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = 0;
    
    self.shouldShowOneKeyConsign = YES;
    self.shouldShouContactCustomService  = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self vs_setTitleText:@"活动"];
    
    [self vs_showRightButton:YES];
    [self.vm_rightButton setFrame:_CGR(0, 0, 70, 28)];
    [self.vm_rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.vm_rightButton setTitle:@"我要合作" forState:UIControlStateNormal];

    page = 1;
    row = 20;
    newManager = [[NewActivitiesManager alloc] init];
    _datalist = [NSMutableArray array];
    _completeDatalist = [NSMutableArray array];
    requestGroup = dispatch_group_create();
    
    [self.view addSubview:self.tableView];
    
    [self.tableView headerBeginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.ifNeedRefresh) {
        self.ifNeedRefresh = NO;
        [self.tableView headerBeginRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- request

- (void)loadAdList{
    /**
     
     banner-type	Banner类型：1：全局首页，2：应用，3：项目
     object-id	Banner类型对应对象id，类型是全局object-id传空
     
     
     */
    
    dispatch_group_enter(requestGroup);
    
    NSDictionary *dic = @{
                          @"bannerType":@"2",
                          @"objectId":@"activity"
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.banner/get-banner-info/version/1.2.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        self.adList = [BannerDTO mj_objectArrayWithKeyValuesArray:dic[@"advertisementList"]];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

- (void)refresh {
    page = 1;
//    [self vs_showLoading];
    [self loadAdList];
    [self requestGreatActivityList];
    [self requestCompleteGreatActivityList];
    
    __weak typeof(self) weakSelf = self;
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        [self vs_hideLoadingWithCompleteBlock:nil];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [self refreshTableView];
        
        if (self.datalist.count % 10 > 0) {
            [_tableView removeFooter];
        }else{
            [self.tableView addFooterWithCallback:^{
                [weakSelf getmore];
            }];
        }
    });
    
}

- (void)getmore {
    //    page ++;
    page = (int)self.datalist.count / 10 + 1;
//    [self vs_showLoading];
    [self requestGreatActivityList];
    [self requestCompleteGreatActivityList];
    
    __weak typeof(self) weakSelf = self;
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        [self vs_hideLoadingWithCompleteBlock:nil];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        
        if (self.datalist.count % 10 > 0) {
            [_tableView removeFooter];
        }else{
            [self.tableView addFooterWithCallback:^{
                [weakSelf getmore];
            }];
        }
        
        [self refreshTableView];
    });
    
}

//活动列表,开始和未开始
- (void)requestGreatActivityList {
    
    [self startRequest];
    
    [newManager onRequestActivityList:[NSString stringWithFormat:@"%d",page] row:[NSString stringWithFormat:@"%d",row] partyId:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"" status:@"STARTED,NOT_START" success:^(NSDictionary *responseObj) {
        NSError *err;
        _listModel = [[NewActivityListModel alloc] initWithDictionary:responseObj error:&err];
        NSArray *list = [NewActivityModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"activityList"] error:nil];
        
        if (list && [list isKindOfClass:[NSArray class]] && list.count > 0) {
            if (page == 1) {
                _datalist = [NSMutableArray arrayWithArray:list];
            }else {
                [_datalist addObjectsFromArray:list];
            }
        }
        [self endRequest];
    } failure:^(NSError *error) {
        [self endRequest];
        
        [self.view showTipsView:[error domain]];
    }];
}

//活动列表,已结束
- (void)requestCompleteGreatActivityList {
    
    [self startRequest];
    
    [newManager onRequestActivityList:[NSString stringWithFormat:@"%d",page] row:[NSString stringWithFormat:@"%d",row] partyId:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"" status:@"COMPLETED" success:^(NSDictionary *responseObj) {
        NSError *err;
        _completeListModel = [[NewActivityListModel alloc] initWithDictionary:responseObj error:&err];
        NSArray *list = [NewActivityModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"activityList"] error:nil];
        
        if (list && [list isKindOfClass:[NSArray class]] && list.count > 0) {
            if (page == 1) {
                _completeDatalist = [NSMutableArray arrayWithArray:list];
            }else {
                [_completeDatalist addObjectsFromArray:list];
            }
        }
        [self endRequest];
    } failure:^(NSError *error) {
        [self endRequest];
        
        [self.view showTipsView:[error domain]];
    }];
}

- (void)startRequest {
    
    dispatch_group_enter(requestGroup);
    
}
- (void)endRequest {
    
    dispatch_group_leave(requestGroup);
    
}
- (void)refreshTableView {
    
    [self.tableView reloadData];
    
}

//重写右侧按钮点击事件
- (void)vs_rightButtonAction:(id)sender
{
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        [self refresh];
        //去我要合作
        ActivityCoorperationViewController *vc = [[ActivityCoorperationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } cancel:^{
        
    }];
    
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1) {
        self.ifNeedRefresh = YES;
        [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
            NewActivityDetailViewController *vcontroller = [[NewActivityDetailViewController alloc]init];
            vcontroller.a_model = [_datalist objectAtIndex:indexPath.row];
            vcontroller.webUrl = [NSURL URLWithString:vcontroller.a_model.activityDetail];
            [self.navigationController pushViewController:vcontroller animated:YES];
        } cancel:^{
            
        }];
    } else {
        [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
            NewActivityDetailViewController *vcontroller = [[NewActivityDetailViewController alloc]init];
            vcontroller.a_model = [_completeDatalist objectAtIndex:indexPath.row];
            vcontroller.webUrl = [NSURL URLWithString:vcontroller.a_model.activityDetail];
            [self.navigationController pushViewController:vcontroller animated:YES];
        } cancel:^{
            
        }];
    }
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_completeDatalist.count > 0) {
        return 3;
    } else {
        return 2;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return _datalist.count;
    } else {
        return _completeDatalist.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        return 0;
    } else if (section == 2) {
        return 37;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *headerview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 37)];
    headerview.backgroundColor = _COLOR_HEX(0xf1f1f1);
    
    UILabel *header = [[UILabel alloc]initWithFrame:CGRectMake(17, 0, MainWidth-17, 37)];
    header.backgroundColor = [UIColor clearColor];
    header.textAlignment = NSTextAlignmentLeft;
    header.font = [UIFont systemFontOfSize:15.];
    header.textColor = _COLOR_HEX(666666);
    [headerview addSubview:header];
    
    if (section == 0) {
        return nil;
    } else if (section == 1) {
        return nil;
    } else if (section == 2) {
        header.text = @"活动回顾";
        return headerview;
    }
    return headerview;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 320/750.0 * [UIScreen mainScreen].bounds.size.width + 10;
    } else if(indexPath.section == 1) {
        return __SCREEN_WIDTH__ * 205 / 320;
    } else {
        return 370/750.0 * [UIScreen mainScreen].bounds.size.width;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        AdsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AdsTableViewCell class])];
        
        cell.ads = self.adList;
        
        
        __weak typeof(self) weakself = self;
        [cell setAdsClickBlock:^(id data) {
            
            
            if ([data isKindOfClass:[BannerDTO class]]) {
                BannerDTO *dto = (BannerDTO *)data;
                
                if ([dto.bannerDetail.uppercaseString hasPrefix:@"HTTP"]) {
                    
                    NSLog(@"%@",dto.bannerDetail);
                    
                    NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:dto.bannerDetail]];
                    [weakself.navigationController pushViewController:vc animated:YES];
                    
                }
            }
            
        }];
        
        return cell;
    } else if (indexPath.section == 1) {
        static NSString *identifier = @"cell";
        NewActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"NewActivityCell" owner:nil options:nil] lastObject];
        }
        if (indexPath.row != _datalist.count-1 && _datalist.count != 1) {

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NewActivityModel *a_model = [_datalist objectAtIndex:indexPath.row];
        [cell setDataSource:a_model];
        return cell;
    } else {
        static NSString *identifier = @"CompeleteActivityTableViewCell";
        CompeleteActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CompeleteActivityTableViewCell" owner:nil options:nil] lastObject];
        }
        if (indexPath.row != _completeDatalist.count-1 && _completeDatalist.count != 1) {
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NewActivityModel *a_model = [_completeDatalist objectAtIndex:indexPath.row];
        [cell setDataSource:a_model];
        return cell;
    }
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GetWidth(self.view), GetHeight(self.view)- 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = _COLOR_HEX(0xf1f1f1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = (id<UITableViewDelegate>)self;
        _tableView.dataSource = (id<UITableViewDataSource>)self;
        
        [_tableView registerClass:[AdsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AdsTableViewCell class])];
        
        __weak typeof(self)weakself = self;
        [_tableView addHeaderWithCallback:^{
            [weakself refresh];
        }];
        [_tableView addFooterWithCallback:^{
            [weakself getmore];
        }];
    }
    return _tableView;
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
