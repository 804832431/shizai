//
//  BidListViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidListViewController.h"
#import "AdsTableViewCell.h"
#import "ManagementManger.h"
#import "HomeBCollectionViewCell.h"
#import "RTXCAppModel.h"
#import "HomeCCollectionViewCell.h"
#import "MJRefresh.h"
#import "BCNetWorkTool.h"
#import "NearNewProductCell.h"
#import "VSJsWebViewController.h"
#import "NewShareWebViewController.h"
#import "newNearSelectedProjectViewController.h"
#import "BidListTableViewCell.h"
#import "BidWebViewController.h"
#import "BannerDTO.h"
#import "MJExtension.h"
#import "BidProject.h"
#import "BidProxyViewController.h"
#import "VSAdsView.h"
#import "NSObject+MJKeyValue.h"
#import "BidderManager.h"
#import "AuthEnterpriseViewController.h"
#import "AuthStatusUnReslovedViewController.h"

@interface BidListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel* titleLabel;
    
    dispatch_group_t requestGorup;
}

@property (nonatomic,strong) NSArray *adList;

_PROPERTY_NONATOMIC_STRONG(UIView, emptyView);

_PROPERTY_NONATOMIC_STRONG(UIView, segmentBar);

_PROPERTY_NONATOMIC_STRONG(UIView, bottomViewInBid);

_PROPERTY_NONATOMIC_STRONG(UIButton, inBidButton);

_PROPERTY_NONATOMIC_STRONG(UIView, bottomViewComplete);

_PROPERTY_NONATOMIC_STRONG(UIButton, completeButton);

_PROPERTY_NONATOMIC_STRONG(VSAdsView, vSAdsView);

@property (nonatomic,strong) NSArray *contentTaleViews;

@property (nonatomic,strong) NSArray *dataSources;

@property (nonatomic,strong) UIScrollView *contentScrollView;

@property (nonatomic,assign) NSInteger index;//选中segmentView index



@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *bidList;

@end

@implementation BidListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.shouldShowOneKeyConsign = YES;
    self.shouldShouContactCustomService  = YES;
    
    [self vs_setTitleText:@"招投标"];
    [self.view setBackgroundColor:ColorWithHex(0xeeeeee, 1.0)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.vSAdsView];
    
    [self vs_showRightButton:YES];
    [self.vm_rightButton setFrame:_CGR(0, 0, 80, 28)];
    [self.vm_rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.vm_rightButton setTitle:@"招投标代理" forState:UIControlStateNormal];
    
    requestGorup = dispatch_group_create();
    [self loadAdData];
    
    [self _initTableViews];
    
    [self _initContentScrollView];
    
    [self.view addSubview:self.segmentBar];
    
    [self performSelector:@selector(changeSegmentView) withObject:nil afterDelay:0.3];
}

#pragma mark - views 

- (NSArray *)dataSources{
    
    if (_dataSources == nil) {
        
        _dataSources = @[[NSMutableArray array],[NSMutableArray array]];
    }
    
    return _dataSources;
    
}

- (VSAdsView *)vSAdsView {
    if (!_vSAdsView) {
        _vSAdsView = [[VSAdsView alloc] init];
        [_vSAdsView setFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_WIDTH__ * 406 / 1126)];
        __weak typeof(self) weakself = self;
        [_vSAdsView setAdsClickBlock:^(id data) {
            if ([data isKindOfClass:[BannerDTO class]]) {
                BannerDTO *dto = (BannerDTO *)data;
                
                if ([dto.bannerDetail.uppercaseString hasPrefix:@"HTTP"]) {
                    
                    NSLog(@"%@",dto.bannerDetail);
                    
                    NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:dto.bannerDetail]];
                    [weakself.navigationController pushViewController:vc animated:YES];
                    
                }
            }
        }];
    }
    return _vSAdsView;
}


- (NSArray *)contentTaleViews{
    
    if (_contentTaleViews == nil) {
        _contentTaleViews  = @[[UITableView new],[UITableView new]];
    }
    
    return _contentTaleViews;
}

- (UIScrollView *)contentScrollView{
    
    if (_contentScrollView == nil) {
        _contentScrollView = [UIScrollView new];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.scrollEnabled = NO;
    }
    
    return _contentScrollView;
}

- (void)_initTableViews{
    
    for (UITableView *tableView in self.contentTaleViews) {
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        
        UINib *nib = [UINib nibWithNibName:@"BidListTableIViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([BidListTableViewCell class])];
        
        __weak typeof(&*self) weakSelf = self;
        __weak UITableView *weakTableView = tableView;
        
        [tableView addHeaderWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *status = nil;
            
            if (index == 0) {
                status = [NSString stringWithFormat:@"NOT_START,STARTED"];
            }else if(index == 1) {
                status = [NSString stringWithFormat:@"COMPLETED"];
            }
            
            [weakSelf refreshList:status  page:@"1" row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
        
        [tableView addFooterWithCallback:^{
            NSInteger index = [weakSelf.contentTaleViews indexOfObject:weakTableView];
            NSString *status = nil;
            
            if (index == 0) {
                status = [NSString stringWithFormat:@"NOT_START,STARTED"];
            }else if(index == 1) {
                status = [NSString stringWithFormat:@"COMPLETED"];
            }
            
            NSArray *data = weakSelf.dataSources[index];
            NSInteger page = data.count / 10 + 1;
            
            [weakSelf refreshList:status  page:[NSString stringWithFormat:@"%zi",page] row:@"10" dataSource:weakSelf.dataSources[index] tableView:weakTableView];
        }];
    }
}

- (void)_initContentScrollView{
    
    [self.view addSubview:self.contentScrollView];
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.contentScrollView setFrame:CGRectMake(0, 35 + (__SCREEN_WIDTH__ * 406 / 1126), __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 64 - 35 - (__SCREEN_WIDTH__ * 406 / 1126))];
    
    UIView *containerView = [UIView new];
    [self.contentScrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentScrollView);
        make.height.equalTo(weakSelf.contentScrollView);
        make.leading.trailing.equalTo(weakSelf.contentScrollView);
        
    }];
    
    UIView *preView = nil;
    for (NSInteger i =0 ; i < self.contentTaleViews.count ; i++) {
        
        [containerView addSubview:self.contentTaleViews[i]];
        
        [self.contentTaleViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(containerView);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            
            if (preView) {
                
                make.leading.equalTo(preView.mas_trailing);
                
            }else{
                
                make.leading.equalTo(containerView);
                
            }
        }];
        
        
        preView = self.contentTaleViews[i];
        
    }
    
    if (preView) {
        [preView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(containerView);
        }];
    }
    
}

- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_HEIGHT__ - 35 - (__SCREEN_WIDTH__ * 406 / 1126))];
        [_emptyView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((__SCREEN_WIDTH__ - 60)/2, 53, 60, 55)];
        [imageView setImage:__IMAGENAMED__(@"bg_img_nothing")];
        [_emptyView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 53 + 55 +14, __SCREEN_WIDTH__, 21)];
        [label setText:@"暂无信息"];
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setTextColor:ColorWithHex(0x5c5c5c, 1.0)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [_emptyView addSubview:label];
    }
    return _emptyView;
}

- (UIView *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [[UIView alloc] initWithFrame:CGRectMake(0, (__SCREEN_WIDTH__ * 406 / 1126), __SCREEN_WIDTH__, 35)];
        [_segmentBar setBackgroundColor:ColorWithHex(0xf7f7f7, 1.0)];
        [_segmentBar addSubview:self.inBidButton];
        [_segmentBar addSubview:self.completeButton];
        
        //1.5.1去掉分割线
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((__SCREEN_WIDTH__ / 2) - 0.5, 0, 1, 35)];
//        [lineView setBackgroundColor:ColorWithHex(0xd2d2d2, 1.0)];
//        [_segmentBar addSubview:lineView];
    }
    return _segmentBar;
}

- (UIButton *)inBidButton {
    if (!_inBidButton) {
        _inBidButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (__SCREEN_WIDTH__ / 2) - 0.5, 35)];
        [_inBidButton setTitle:@"招标中" forState:UIControlStateNormal];
        [_inBidButton setTitleColor:ColorWithHex(0x2f9f7e, 1.0) forState:UIControlStateNormal];
        [_inBidButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        
        [_inBidButton addTarget:self action:@selector(inBidAction) forControlEvents:UIControlEventTouchUpInside];
        
        if (!_bottomViewInBid) {
            _bottomViewInBid = [[UIView alloc] initWithFrame:CGRectMake(0, 32, (__SCREEN_WIDTH__ / 2) - 0.5, 3)];
            [_bottomViewInBid setBackgroundColor:ColorWithHex(0x00c88c, 1.0)];
        }
        [_inBidButton addSubview:_bottomViewInBid];
    }
    return _inBidButton;
}

- (void)inBidAction {
    [_inBidButton setTitleColor:ColorWithHex(0x2f9f7e, 1.0) forState:UIControlStateNormal];
    [_completeButton setTitleColor:ColorWithHex(0x888888, 1.0) forState:UIControlStateNormal];
    
    [_bottomViewComplete removeFromSuperview];
    [_inBidButton addSubview:_bottomViewInBid];
    
    self.index = 0;
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
    NSMutableArray *dataSource = self.dataSources[0];
    UITableView *tableView = [self.contentTaleViews  objectAtIndex:0];
    if (dataSource.count == 0) {
        [tableView headerBeginRefreshing];
    }
}

- (UIButton *)completeButton {
    if (!_completeButton) {
        _completeButton = [[UIButton alloc] initWithFrame:CGRectMake((__SCREEN_WIDTH__ / 2) + 0.5, 0, (__SCREEN_WIDTH__ / 2) - 0.5, 35)];
        [_completeButton setTitle:@"已结束" forState:UIControlStateNormal];
        [_completeButton setTitleColor:ColorWithHex(0x888888, 1.0) forState:UIControlStateNormal];
        [_completeButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        
        [_completeButton addTarget:self action:@selector(completeAction) forControlEvents:UIControlEventTouchUpInside];
        
        if (!_bottomViewComplete) {
            _bottomViewComplete = [[UIView alloc] initWithFrame:CGRectMake(0, 32, (__SCREEN_WIDTH__ / 2) - 0.5, 3)];
            [_bottomViewComplete setBackgroundColor:ColorWithHex(0x00c88c, 1.0)];
        }
    }
    return _completeButton;
}

- (void)completeAction {
    [_inBidButton setTitleColor:ColorWithHex(0x888888, 1.0) forState:UIControlStateNormal];
    [_completeButton setTitleColor:ColorWithHex(0x2f9f7e, 1.0) forState:UIControlStateNormal];
    
    [_bottomViewInBid removeFromSuperview];
    [_completeButton addSubview:_bottomViewComplete];
    
    self.index = 1;
    self.contentScrollView.contentOffset = CGPointMake(__SCREEN_WIDTH__, 0);
    NSMutableArray *dataSource = self.dataSources[1];
    UITableView *tableView = [self.contentTaleViews  objectAtIndex:1];
    if (dataSource.count == 0) {
        [tableView headerBeginRefreshing];
    }
    
}

- (void) changeSegmentView{
    
    [self.contentTaleViews.firstObject headerBeginRefreshing];
    self.index = 0;
}

- (void)checkEnterpriseStatus {
    [self vs_showLoading];
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSDictionary *dic = @{
                          @"partyId" : partyId
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic  andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-authed-enterprise/version/1.2.0" withSuccess:^(id callBackData) {
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        [BidderManager shareInstance].authedEnterPrise = [AuthedEnterprise mj_objectWithKeyValues:callBackData];
        
        
        NSString *status = [BidderManager shareInstance].authedEnterPrise.authStatus;
        
        if ([status isEqualToString:@"UNAPPLY"]) {
            AuthEnterpriseViewController *vc = [AuthEnterpriseViewController new];
            [vc setDataSource:[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder];
            [self.navigationController pushViewController:vc animated:YES];
        }else if([status isEqualToString:@"UNRESOLVED"]){
            
            [self.view showTipsView:@"您的企业信息还在认证中，请耐心等待"];
            
        }else if([status isEqualToString:@"PASS"]){
            
            //去招投标代理
            BidProxyViewController *vc = [[BidProxyViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if([status isEqualToString:@"REJECT"]){
            AuthStatusUnReslovedViewController *vc = [[AuthStatusUnReslovedViewController alloc] initWithNibName:@"AuthStatusUnReslovedViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES ];
        }
    } orFail:^(id callBackData) {
        [self vs_hideLoadingWithCompleteBlock:nil];
    }];
}

//重写右侧按钮点击事件
- (void)vs_rightButtonAction:(id)sender
{
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{        
        [self checkEnterpriseStatus];
    } cancel:^{
        
    }];
}

- (void)loadAdData {
    /**
     
     banner-type	Banner类型：1：全局首页，2：应用，3：项目
     object-id	Banner类型对应对象id，类型是全局object-id传空
     
     
     */
    
    dispatch_group_enter(requestGorup);
    
    NSDictionary *dic = @{
                          @"bannerType":@"2",
                          @"objectId":@"ztb"
                          };
    
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.banner/get-banner-info/version/1.2.0" withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        self.adList = [BannerDTO mj_objectArrayWithKeyValuesArray:dic[@"advertisementList"]];
        
        [self.vSAdsView setAds:self.adList];
        
        dispatch_group_leave(requestGorup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGorup);
    }];
}

- (void)refreshList:(NSString *)status  page:(NSString *)page row:(NSString *)row dataSource:(NSMutableArray *)datasource tableView:(UITableView *)tableView{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self vs_showLoading];
//    });
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    dispatch_group_enter(requestGorup);
    
    NSDictionary *para = @{@"page":@"1",@"row":@"10",@"partyId":partyId,@"status":status};
    
    
    [BCNetWorkTool executeGETNetworkWithParameter:para andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-bid-project/version/1.2.0" withSuccess:^(id callBackData) {
        [self vs_hideLoadingWithCompleteBlock:nil];
        NSLog(@"%@",callBackData);
        
        NSArray *list = [BidProject mj_objectArrayWithKeyValuesArray:callBackData[@"bidProjectList"]];
        
        if (page.integerValue == 1) {
            [datasource removeAllObjects];
        }
        
        [datasource addObjectsFromArray:list];
        
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
        
        [tableView reloadData];
        
        if ([callBackData[@"nextPage"] isEqualToString:@"Y"]) {
            [tableView setFooterHidden:NO];
        }else{
            [tableView setFooterHidden:YES];
        }
        
        
        dispatch_group_leave(requestGorup);
        
    } orFail:^(id callBackData) {
        
        [self vs_hideLoadingWithCompleteBlock:nil];
        [tableView headerEndRefreshing];
        [tableView footerEndRefreshing];
        
        [self.view showTipsView:[callBackData domain]];
        
        dispatch_group_leave(requestGorup);
    }];
}



- (void)loadData {
    
    dispatch_group_enter(requestGorup);
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSDictionary *para = @{@"page":@"1",@"row":@"5",@"partyId":partyId};
    
    
    [BCNetWorkTool executeGETNetworkWithParameter:para andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-bid-project/version/1.2.0" withSuccess:^(id callBackData) {
        
        NSLog(@"%@",callBackData);
        
        NSArray *arr = [BidProject mj_objectArrayWithKeyValuesArray:callBackData[@"bidProjectList"]];
        
        
        self.bidList = [NSMutableArray arrayWithArray:arr];
        
        
        dispatch_group_leave(requestGorup);
        
    } orFail:^(id callBackData) {
        
        [self.view showTipsView:[callBackData domain]];
        
        dispatch_group_leave(requestGorup);
    }];
}


- (void)loadMoreData {
    
    dispatch_group_enter(requestGorup);
    
    NSString *partyId=[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSInteger page = self.bidList.count / 5 + 1;
    
    NSDictionary *para = @{@"page":[NSString stringWithFormat:@"%li",page],@"row":@"5",@"partyId":partyId};
    
    [BCNetWorkTool executeGETNetworkWithParameter:para andUrlIdentifier:@"/RUI-CustomerJSONWebService-portlet.enterprise/get-bid-project/version/1.2.0" withSuccess:^(id callBackData) {
        
        
        NSArray *arr = [BidProject mj_objectArrayWithKeyValuesArray:callBackData[@"bidProjectList"]];
        
        self.bidList = [NSMutableArray arrayWithArray:[self.bidList arrayByAddingObjectsFromArray:arr]];
        
        dispatch_group_leave(requestGorup);
        
    } orFail:^(id callBackData) {
        
        [self.view showTipsView:[callBackData domain]];
        
        dispatch_group_leave(requestGorup);
    }];
}







#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    
    NSMutableArray * arr = self.dataSources[index];
    
    
    if (arr.count == 0) {
        [tableView addSubview:self.emptyView];
    }else{
        [self.emptyView removeFromSuperview];
    }
    
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"BidListTableIViewCell";
    BidListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BidListTableIViewCell" owner:nil options:nil] lastObject];
        cell.contentView.clipsToBounds = YES;
    }
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    
    BidProject *b_model = (BidProject *)[arr objectAtIndex:indexPath.row];
    [cell setDto:b_model];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setFrame:CGRectMake(12, 5, __SCREEN_WIDTH__ - 24, 100)];
    
    return cell;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    BidProject *dto = [arr objectAtIndex:indexPath.row];
    if ([dto.bidStatus isEqualToString:@"DELETED"] || [dto.bidStatus isEqualToString:@"COMPLETED"]) {
        return 25 + 150;
    } else if ([dto.bidStatus isEqualToString:@"NOT_START"]) {
        return 150;
    } else if ([dto.bidStatus isEqualToString:@"STARTED"]) {
        return 150;
    }
    return 150;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = [self.contentTaleViews indexOfObject:tableView];
    NSMutableArray * arr =(NSMutableArray *)self.dataSources[index];
    
    BidProject *dto = [arr objectAtIndex:indexPath.row];
    NSString *urlString = dto.projectUrl;
    
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        BidWebViewController *vc = [[BidWebViewController alloc]init];
        vc.isHomeList = YES;
        vc.webUrl = [NSURL URLWithString:urlString];
        vc.dto = dto;
        [self.navigationController pushViewController:vc animated:YES];
    } cancel:^{
        
    }];
}






@end
