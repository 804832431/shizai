//
//  HomeViewController.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BHomeViewController.h"
#import <Masonry/Masonry.h>
#import "AdsTableViewCell.h"
#import "ManagementManger.h"
#import "NewPolicyManager.h"
#import "HomeManger.h"
#import "HomeBCollectionViewCell.h"
#import "RTXCAppModel.h"
#import "ActivitiesManager.h"
#import "PolicyModel.h"
#import "BPolicyCell.h"
#import "PolicyListViewController.h"
#import "VSWebViewController.h"
#import "MJRefresh.h"
#import "LDResisterManger.h"
#import "EnterpriseInfoViewController.h"
#import "EnterpriseJoinViewController.h"
#import "BCNetWorkTool.h"
#import "BannerDTO.h"
#import "MJExtension.h"
#import "VSJsWebViewController.h"
#import "BidListViewController.h"
#import "NewShareWebViewController.h"
#import "NewPolicyListModel.h"
#import "NewPolicyModel.h"
#import "NewPolicyListViewController.h"
#import "NewPolicyDetaileViewController.h"
#import "VSUserLoginViewController.h"
#import "SpaceModel.h"
#import "HomeHeaderView.h"
#import "HomeHeadLineView.h"
#import "HomeAppTableViewCell.h"
#import "HomeSpaceTableViewCell.h"
#import "HomeShareLineTableViewCell.h"
#import "ServiceModel.h"
#import "HomeRecommendTableViewCell.h"
#import "MessageManager.h"
#import "MessageViewController.h"
#import "SpaceListModel.h"

#define header_height  (MainWidth/4.9)

@interface BHomeViewController ()
{
    HomeManger *manger;
    
    ManagementManger *bmanger;
    
    ActivitiesManager *actManger;
    
    NewPolicyManager *newPolicyManager;
    
    MessageManager *messageManager;
    
    UILabel* titleLabel;
    
    NSArray *dataList;
    
    NSArray *policyList;
    
    dispatch_group_t requestGroup;
    
    CGFloat bannerHeight;
    
    BOOL showTopButton;
}

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic,strong) UIButton *topButton;
@property (nonatomic, strong)UIImageView *t_imageView;
@property (nonatomic, strong)UILabel *t_companyLabel;
@property (nonatomic, strong)UILabel *t_nameLabel;
@property (nonatomic, strong)UILabel *t_phoneLabel;
@property (nonatomic, strong)UILabel *line;
@property (nonatomic, strong)UIImageView *redPoint_imageView;

@property (nonatomic,strong) NSMutableArray *tableList;

//banner数组
@property (nonatomic,strong) NSArray *adList;
//时在头条数组
@property (nonatomic,strong) NSArray *headLineList;
//时在分享数组
@property (nonatomic,strong) NSArray *shareLineList;
//生意区、资金区数组
@property (nonatomic,strong) NSArray *businessList;
//空间区数组
@property (nonatomic,strong) NSArray *spaceList;
//空间区信息
@property (nonatomic,strong) RTXCAppModel *spaceInfo;
//为你推荐数组
@property (nonatomic,strong) NSArray *recommendList;

//头条view
@property (nonatomic,strong) HomeHeadLineView *homeHeadLineView;

@property (nonatomic,strong) UIButton *oneKeyConsignHomeButton;

@property (nonatomic,strong) UIButton *customServiceHomeButton;

@end

@implementation BHomeViewController

-  (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width /3, homeb_cellheight * 71/124.0);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = (id<UICollectionViewDelegate>)self;
        _collectionView.dataSource = (id<UICollectionViewDataSource>)self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[HomeBCollectionViewCell class] forCellWithReuseIdentifier:@"HomeBCollectionViewCell"];
        _collectionView.scrollEnabled = NO;
        
    }
    
    return _collectionView;
}

- (NSMutableArray *)tableList {
    if (!_tableList) {
        _tableList = [[NSMutableArray alloc] init];
    }
    return _tableList;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        [_tableView registerClass:[AdsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AdsTableViewCell class])];
//        [_tableView registerClass:[HomeSpaceTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeSpaceTableViewCell class])];
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, 15)];
        [footer setBackgroundColor:[UIColor whiteColor]];
        [_tableView setTableFooterView:footer];
    }
    
    return _tableView;
}

- (UIButton *)customServiceHomeButton {
    if (!_customServiceHomeButton) {
        _customServiceHomeButton = [[UIButton alloc] initWithFrame:CGRectMake(__SCREEN_WIDTH__ - 64, self.view.frame.size.height - 49 - 49 - 70, 56, 60)];
        [_customServiceHomeButton setImage:__IMAGENAMED__(@"btn_400_n") forState:UIControlStateNormal];
        [_customServiceHomeButton setImage:__IMAGENAMED__(@"btn_400_h") forState:UIControlStateHighlighted];
        [_customServiceHomeButton addTarget:self action:@selector(contactCustomService) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customServiceHomeButton;
}

- (void)contactCustomService {
    [[OneKeyConsignManager sharedOneKeyConsignManager] showCustomServiceView];
}

- (UIButton *)oneKeyConsignHomeButton {
    if (!_oneKeyConsignHomeButton) {
        _oneKeyConsignHomeButton = [[UIButton alloc] initWithFrame:CGRectMake(6.0f, self.view.frame.size.height - 49.0f - 49.0f -5.0f, __SCREEN_WIDTH__ - 12.0f, 49.0f)];
        [_oneKeyConsignHomeButton.layer setCornerRadius:5.0f];
        [_oneKeyConsignHomeButton setTitle:@"一键提交委托 坐等电话回访" forState:UIControlStateNormal];
        [_oneKeyConsignHomeButton setImage:__IMAGENAMED__(@"btn_yijianweituo_n") forState:UIControlStateNormal];
        [_oneKeyConsignHomeButton setImage:__IMAGENAMED__(@"btn_yijianweituo_h") forState:UIControlStateHighlighted];
//        [_oneKeyConsignButton setBackgroundColor:_RGB_A(64, 184, 148, 0.8)];
        [_oneKeyConsignHomeButton addTarget:self action:@selector(oneKeyConsign) forControlEvents:UIControlEventTouchUpInside];
    }
    return _oneKeyConsignHomeButton;
}

- (void)oneKeyConsign {
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        [[OneKeyConsignManager sharedOneKeyConsignManager] showConsignView];
    } cancel:^{
        
    }];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    requestGroup = dispatch_group_create();
    
    manger = [[HomeManger alloc]init];
    
    bmanger = [[ManagementManger alloc]init];
    
    actManger = [[ActivitiesManager alloc]init];
    
    newPolicyManager = [[NewPolicyManager alloc] init];
    
    messageManager = [[MessageManager alloc] init];
//    [self buildNavigationItem];
    
    [self vs_setTitleText:@"时在"];
    
    [self vs_setTitleColor:_COLOR_HEX(0x302f37)];
    
    [self vs_showRightButton:YES];
    
    [self.vm_rightButton setImage:__IMAGENAMED__(@"ic_notification_n") forState:UIControlStateNormal];
    
    [self.vm_rightButton setImage:__IMAGENAMED__(@"ic_notification_n") forState:UIControlStateHighlighted];
    
    self.view.backgroundColor = _COLOR_HEX(0xdedede);
    
    
    __weak typeof(self) weakSelf = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.equalTo(weakSelf.view);
    }];
    
    
    
    
    [self.tableView addHeaderWithCallback:^{
        [weakSelf requestData];
    }];
    
    
    [self.tableView headerBeginRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:VS_LOGIN_SUCCEED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:VS_LOGOUT_SUCCEED object:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    NSNumber *number = [[NSUserDefaults standardUserDefaults] valueForKey:@"hasUnreadMsg"];
    [self addRedPoint:[number boolValue]];
    

    [self.view addSubview:self.oneKeyConsignHomeButton];
    [self.view addSubview:self.customServiceHomeButton];
}

- (void)addRedPoint:(BOOL)hasUnread {
    if (hasUnread) {
        [self.vm_rightButton addSubview:self.redPoint_imageView];
    } else {
        [self.redPoint_imageView removeFromSuperview];
    }
}

- (void)vs_rightButtonAction:(id)sender {
    //顶部右边按钮事件
    //判断是否登录
//    if ([self isUserlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES]) {
//        MessageViewController *controller = [[MessageViewController alloc]init];
//        [self.navigationController pushViewController:controller animated:YES];
//    }
    
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        MessageViewController *controller = [[MessageViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    } cancel:^{
        
    }];
}






- (void)requestData{
//    [self vs_showLoading];
    
    //拉消息数据
    [self loadMessage];
    
    //获取banner数据
    [self loadAdData];
    
    //Version_1.6.0 去掉头条数据获取
    //获取头条数据
    //[self loadHeadLineData];
    
    //Version_1.6.0 合并资金区生意区为 企业服务
    //获取生意区数据
    [self loadBussinessData];
    //获取资金区数据
//    [self loadCapitalData];
    
    //获取空间区数据
    [self loadSpaceData];
    
    //获取时在分享数据
    [self loadShareLineData];
    
    //获取为您推荐数据
    [self loadRecommendData];
    
    
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        [self vs_hideLoadingWithCompleteBlock:nil];
        
        [self formTableList];
        
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
        [_collectionView reloadData];
        [_tableView reloadData];
    });
}

- (void)formTableList {
    [self.tableList removeAllObjects];
    
    if (self.adList.count > 0) {
        [self.tableList addObject:self.adList];
    }
    
    if (self.headLineList.count > 0) {
        [self.tableList addObject:self.headLineList];
        [self.homeHeadLineView setDataSource:self.headLineList];
    }
    
    if (self.businessList.count > 0) {
        [self.tableList addObject:self.businessList];
    }
    
    if (self.spaceList.count > 0) {
        [self.tableList addObject:self.spaceList];
    }
    
    if (self.shareLineList.count > 0) {
        [self.tableList addObject:self.shareLineList];
    }
    
    if (self.recommendList.count > 0) {
        [self.tableList addObject:self.recommendList];
    }
}

- (void)buildNavigationItem {
    
    //    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (MainWidth-84)/2, 64)];
    //    titleButton .backgroundColor = [UIColor clearColor];
    //    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((titleButton.bounds.size.width - 80) /2, 12, 80, 40)];
    //    
    //    [self resetTitle];
    //    titleLabel.textAlignment = NSTextAlignmentCenter;
    //    titleLabel.textColor = [UIColor whiteColor];
    //    [titleButton addSubview:titleLabel];
    //    self.navigationItem.titleView = titleButton;
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (MainWidth-84)/2, 64)];
    titleButton .backgroundColor = [UIColor clearColor];
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((titleButton.bounds.size.width - 80)/2, 12, 80, 40)];
    
    UIButton* locateView = [[UIButton alloc]initWithFrame:CGRectMake((titleButton.bounds.size.width - 80)/2 - 35, 12, 40, 40)];
    [locateView setImage:[UIImage imageNamed:@"location"] forState:0];
    [titleButton addSubview:locateView];
    
    [self resetTitle];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleButton addSubview:titleLabel];
    
    titleButton.hidden = YES;
    
    self.navigationItem.titleView = titleButton;
    
}

- (void)resetTitle{
    
    NSString *name = [VSUserLogicManager shareInstance].userDataInfo.vm_projectInfo.cityName;
    if (name) {
        titleLabel.superview.hidden = NO;
        titleLabel.text = name;
    }else{
        titleLabel.superview.hidden = YES;
    }
}


- (UIImageView *)t_imageView {
    
    if (!_t_imageView) {
        _t_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _t_imageView.contentMode = UIViewContentModeScaleAspectFit;
        _t_imageView.layer.cornerRadius = 10.f;
        _t_imageView.layer.borderWidth = 1.f;
        _t_imageView.layer.borderColor = _COLOR_HEX(0x8ebdee).CGColor;
    }
    return _t_imageView;
}

- (UIImageView *)redPoint_imageView {
    if (!_redPoint_imageView) {
        _redPoint_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Get750Width(40.0f + 20.0f) , -3.5, 7, 7)];
        [_redPoint_imageView setImage:__IMAGENAMED__(@"hongdian")];
    }
    return _redPoint_imageView;
}

- (UILabel *)t_companyLabel {
    
    if (!_t_companyLabel) {
        _t_companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _t_companyLabel.textColor = _COLOR_HEX(0x454545);
        _t_companyLabel.backgroundColor = [UIColor clearColor];
        _t_companyLabel.font = [UIFont systemFontOfSize:18];
    }
    return _t_companyLabel;
}

- (UILabel *)t_nameLabel {
    
    if (!_t_nameLabel) {
        _t_nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _t_nameLabel.numberOfLines = 0;
        _t_nameLabel.backgroundColor = [UIColor clearColor];
        _t_nameLabel.textColor = _COLOR_HEX(0x737171);
        _t_nameLabel.font = [UIFont systemFontOfSize:13];
    }
    return _t_nameLabel;
}

- (UILabel *)t_phoneLabel {
    
    if (!_t_phoneLabel) {
        _t_phoneLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _t_phoneLabel.numberOfLines = 0;
        _t_phoneLabel.backgroundColor = [UIColor clearColor];
        _t_phoneLabel.textColor = _COLOR_HEX(0x737171);
        _t_phoneLabel.font = [UIFont systemFontOfSize:13];
    }
    return _t_phoneLabel;
}

- (UILabel *)line {
    
    if (!_line) {
        _line= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _line.backgroundColor = _COLOR_HEX(0xd3d3d3);
    }
    return _line;
}

- (UIButton *)topButton {
    
    if (!_topButton) {
        _topButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 135.0/375 * [UIScreen mainScreen].bounds.size.width)];
        [_topButton addTarget:self action:@selector(topAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addTopButtonSubviews];
        
        _topButton.backgroundColor = [UIColor redColor];
    }
    return _topButton;
}

- (void)topAction:(UIButton *)sender {
    
    NSString *partyId =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId;
    
    if (partyId && ![partyId isEmptyString]) {
        NSDictionary *dic = @{@"partyId":partyId};
        LDResisterManger *roleManger = [[LDResisterManger alloc]init];
        [self vs_showLoading];
        [roleManger requestInviaterRole:dic success:^(NSDictionary *responseObj) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self judgeRole];
        } failure:^(NSError *error) {
            [self vs_hideLoadingWithCompleteBlock:nil];
            [self judgeRole];
        }];
    }else {
        [self judgeRole];
    }
    
}

- (HomeHeadLineView *)homeHeadLineView {
    if (!_homeHeadLineView) {
        __weak typeof(self) weakself = self;
        _homeHeadLineView = [[HomeHeadLineView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, 55)];
        [_homeHeadLineView setOnClickHeadLineBlock:^(PolicyModel *dto){
            //处理
            NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:dto.visitURL]];
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _homeHeadLineView;
}

#pragma mark - private

- (void)judgeRole {
    NSString *roleInCompany = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.roleInCompany;
    if (roleInCompany && [roleInCompany isEqualToString:@"admin"]) {
        EnterpriseInfoViewController *vc = [[EnterpriseInfoViewController alloc]init];
        vc.roleType = ROLE_admin;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (roleInCompany && [roleInCompany isEqualToString:@"employee"]) {
        EnterpriseInfoViewController *vc = [[EnterpriseInfoViewController alloc]init];
        vc.roleType = ROLE_employee;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
            EnterpriseJoinViewController *vc = [[EnterpriseJoinViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        } cancel:^{
            
        }];
    }
    
}

- (void)addTopButtonSubviews {
    
    [_topButton addSubview:self.t_imageView];
    
    [_topButton addSubview:self.t_companyLabel];
    
    [_topButton addSubview:self.t_nameLabel];
    
    [_topButton addSubview:self.t_phoneLabel];
    
    [_topButton addSubview:self.line];
    
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MainWidth-37, (_topButton.frame.size.height-30)/2, 30, 30)];
    arrow.image = [UIImage imageNamed:@"arrow_right"];
    arrow.backgroundColor = [UIColor clearColor];
    [_topButton addSubview:arrow];
    
    [self.t_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topButton.mas_left).offset(18);
        make.top.equalTo(_topButton.mas_top).offset(18);
        make.width.equalTo(@0);
        make.height.equalTo(@0);
    }];
    [self.t_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.t_imageView.mas_right).offset(17).priorityHigh();
        make.right.equalTo(_topButton.mas_right).offset(-40);
        make.top.equalTo(_topButton.mas_top).offset(18);
        make.height.equalTo(@20);
    }];
    [self.t_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.t_imageView.mas_right).offset(17);
        make.width.equalTo(@50);
        make.top.equalTo(_topButton.mas_top).offset(43);
    }];
    [self.t_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.t_nameLabel.mas_right).offset(15);
        make.right.equalTo(_topButton.mas_right).offset(-40);
        make.top.equalTo(_topButton.mas_top).offset(43);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topButton.mas_left);
        make.right.equalTo(_topButton.mas_right);
        make.bottom.equalTo(_topButton.mas_bottom).offset(-1);
        make.height.equalTo(@1);
    }];
}

#pragma mark － 获取网络数据

- (void)loadMessage {
    if (self.isUserLogin) {
        dispatch_group_enter(requestGroup);
        NSDictionary *para = @{@"page":[NSNumber numberWithInt:1],@"row":[NSNumber numberWithInt:10]};
        [messageManager requestMessages:para success:^(NSDictionary *responseObj) {
            //数据
            NSError *err;
            MessageListModel *listModel = [[MessageListModel alloc]initWithDictionary:responseObj error:&err];
            NSArray *list = [MessageModel arrayOfModelsFromDictionaries:[responseObj objectForKey:@"messageList"] error:nil];
            NSLog(@"err--%@",err);
            BOOL hasUnread = NO;
            for (MessageModel *msg in list) {
                if ([msg.isRead isEqualToString:@"N"]) {
                    hasUnread = YES;
                }
            }
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:hasUnread] forKey:@"hasUnreadMsg"];
            
            
            //展示小红点
            [self addRedPoint:hasUnread];
            
            
            dispatch_group_leave(requestGroup);
        } failure:^(NSError *error) {
            [self.view showTipsView:[error domain]];
            dispatch_group_leave(requestGroup);
        }];
    } else {
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:NO] forKey:@"hasUnreadMsg"];
        //展示小红点
        [self addRedPoint:NO];
    }
}

- (void)loadAdData{
    /**
     
     banner-type	Banner类型：1：全局首页，2：应用，3：项目
     object-id	Banner类型对应对象id，类型是全局object-id传空
     
     
     */
    
    dispatch_group_enter(requestGroup);
    
    NSDictionary *dic = @{
                          @"bannerType":@"1"
                          
                          };
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.banner/get-banner-info/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        self.adList = [BannerDTO mj_objectArrayWithKeyValuesArray:dic[@"advertisementList"]];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadHeadLineData {
    dispatch_group_enter(requestGroup);
    
    NSDictionary *dic = @{@"type":@"newsHead",
                          @"row":@"10",
                          @"page":@"1",
                          };
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.news/get-home-news/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        self.headLineList = [PolicyModel mj_objectArrayWithKeyValuesArray:dic[@"policyList"]];
        if (self.headLineList.count > 4) {
            self.headLineList = [self.headLineList subarrayWithRange:NSMakeRange(0, 3)];
        }
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadShareLineData {
    dispatch_group_enter(requestGroup);
    
    NSDictionary *dic = @{@"type":@"newsShare",
                          @"row":@"10",
                          @"page":@"1",
                          };
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.news/get-home-news/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        self.shareLineList = [PolicyModel mj_objectArrayWithKeyValuesArray:dic[@"policyList"]];
        if (self.shareLineList.count > 4) {
            self.shareLineList = [self.shareLineList subarrayWithRange:NSMakeRange(0, 4)];
        }
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadBussinessData {
    dispatch_group_enter(requestGroup);
    NSDictionary *dic = @{@"type":@"businessArea,capitalArea",
                          };
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.application/get-home-applicaton/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        self.businessList = [RTXCAppModel mj_objectArrayWithKeyValuesArray:dic[@"applications"]];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadSpaceData {
    dispatch_group_enter(requestGroup);
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.space/get-space-area/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:nil andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        self.spaceInfo = [RTXCAppModel mj_objectWithKeyValues:dic[@"spaceInfo"]];
        
        self.spaceList = [SpaceModel mj_objectArrayWithKeyValuesArray:dic[@"spaceClassList"]];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadRecommendData {
    dispatch_group_enter(requestGroup);
    NSDictionary *dic = @{@"partyId":[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"",
                          @"page":@"1",
                          @"row":@"10"
                          };
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.home/get-recommend-service/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        self.recommendList = [ServiceModel mj_objectArrayWithKeyValuesArray:dic[@"serviceList"]];
        
        for (NSInteger i = 0; i < self.recommendList.count; i++) {
            id service = [self.recommendList objectAtIndex:i];
            if ([service isKindOfClass:[ServiceModel class]]) {
                ((ServiceModel *)service).bidProject = [BidProject mj_objectWithKeyValues:((ServiceModel *)service).bidProject];
                ((ServiceModel *)service).policy = [NewPolicyModel mj_objectWithKeyValues:((ServiceModel *)service).policy];
                ((ServiceModel *)service).activity = [NewActivityModel mj_objectWithKeyValues:((ServiceModel *)service).activity];
                ((ServiceModel *)service).enterprise = [EnterpriseModel mj_objectWithKeyValues:((ServiceModel *)service).enterprise];
                ((ServiceModel *)service).space = [SpaceListModel mj_objectWithKeyValues:((ServiceModel *)service).space];
            }
        }
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        self.recommendList = @[];
        dispatch_group_leave(requestGroup);
    }];
}

- (void)reloadTopView:(NSDictionary *)companyInfo relationship:(NSDictionary *)relationship{
    
    if ([companyInfo isKindOfClass:[NSDictionary class]]) {
        self.t_companyLabel.text = [companyInfo objectForKey:@"name"];
        [self topButtonShouldShow:YES];
    }else {
        [self topButtonShouldShow:NO];
    }
    
    if ([relationship isKindOfClass:[NSDictionary class]]) {
        self.t_nameLabel.text = [relationship objectForKey:@"name"];
        self.t_phoneLabel.text = [relationship objectForKey:@"userLoginId"];
    }
}

- (void)topButtonShouldShow:(BOOL)inCpmpany {
    if (inCpmpany) {
        [self.t_companyLabel setHidden:NO];
        [self.t_nameLabel setHidden:NO];
        [self.t_phoneLabel setHidden:NO];
        [self.line setHidden:NO];
        [_topButton setImage:[UIImage imageNamed:@""] forState:0];
        [_topButton setImage:[UIImage imageNamed:@""] forState:1];
    }else {
        [self.t_companyLabel setHidden:YES];
        [self.t_nameLabel setHidden:YES];
        [self.t_phoneLabel setHidden:YES];
        [self.line setHidden:YES];
        _topButton.clipsToBounds = YES;
        
        [_topButton setBackgroundImage:[UIImage imageNamed:@"companyJoin"] forState:0];
        [_topButton setBackgroundImage:[UIImage imageNamed:@"companyJoin"] forState:1];
    }
    
}


#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.tableList count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = [self.tableList objectAtIndex:section];
    if ([array isEqualToArray:self.recommendList]) {
        return self.recommendList.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [self.tableList objectAtIndex:[indexPath section]];
    if ([array isEqualToArray:self.adList]) {
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
    } else if ([array isEqualToArray:self.headLineList]) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.contentView addSubview:self.homeHeadLineView];
        return cell;
    } else if ([array isEqualToArray:self.businessList]) {
        static NSString *identifier = @"HomeAppTableViewCellBusiness";
        HomeAppTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[HomeAppTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setDataSource:self.businessList];
        return cell;
    }
    //Version_1.6.0 合并资金区生意区为 企业服务
    /*else if ([array isEqualToArray:self.capitalList]) {
        static NSString *identifier = @"HomeAppTableViewCellCapital";
        HomeAppTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[HomeAppTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setDataSource:self.capitalList];
        return cell;
    }*/ else if ([array isEqualToArray:self.spaceList]) {
        static NSString *identifier = @"HomeSpaceTableViewCell";
        HomeSpaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeSpaceTableViewCell" owner:nil options:nil] lastObject];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setDataSource:self.spaceList];
        return cell;
    } else if ([array isEqualToArray:self.shareLineList]) {
        HomeShareLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeShareLineTableViewCell class])];
        if (!cell) {
            cell = [[HomeShareLineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomeShareLineTableViewCell class])];
        }
        cell.shareLineList = self.shareLineList;
        
        __weak typeof(self) weakself = self;
        [cell setShareLineClickBlock:^(id data) {
            if ([data isKindOfClass:[PolicyModel class]]) {
                PolicyModel *dto = (PolicyModel *)data;
                if ([dto.visitURL.uppercaseString hasPrefix:@"HTTP"]) {
                    NSLog(@"%@",dto.introduction);
                    NewShareWebViewController *vc = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:dto.visitURL]];
                    [weakself.navigationController pushViewController:vc animated:YES];
                }
            }
        }];
        
        return cell;
    } else if ([array isEqualToArray:self.recommendList]) {
        static NSString *identifier = @"HomeRecommendTableViewCell";
        HomeRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeRecommendTableViewCell" owner:nil options:nil] lastObject];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setDataSource:[self.recommendList objectAtIndex:[indexPath row]]];
        return cell;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = [self.tableList objectAtIndex:[indexPath section]];
    if ([array isEqualToArray:self.adList]) {
        return 320/750.0 * [UIScreen mainScreen].bounds.size.width;
    } else if ([array isEqualToArray:self.headLineList]) {
        return 55.0;
    } else if ([array isEqualToArray:self.businessList]) {
        NSInteger appcount = self.businessList.count;
        NSInteger page = ceil(appcount/3.0);
        if (page > 1) {
            return 220/750.0 * [UIScreen mainScreen].bounds.size.width + 29;
        } else {
            return 220/750.0 * [UIScreen mainScreen].bounds.size.width;
        }
    }
    //Version_1.6.0 合并资金区生意区为 企业服务
    /*else if ([array isEqualToArray:self.capitalList]) {
        return 220/750.0 * [UIScreen mainScreen].bounds.size.width;
    }*/ else if ([array isEqualToArray:self.spaceList]) {
        if (self.spaceList.count < 3) {
            return (232/750.0 * [UIScreen mainScreen].bounds.size.width) + 10;
        }
        return 442/750.0 * [UIScreen mainScreen].bounds.size.width + 10;
    } else if ([array isEqualToArray:self.shareLineList]) {
        return 254/750.0 * [UIScreen mainScreen].bounds.size.width;
    } else if ([array isEqualToArray:self.recommendList]) {
        return 418/750.0 * [UIScreen mainScreen].bounds.size.width;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *array = [self.tableList objectAtIndex:section];
    if ([array isEqualToArray:self.businessList]) {
        HomeHeaderView *homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, 38.5)];
        [homeHeaderView setTitle:@"企业服务" withMore:NO];
        return homeHeaderView;
    }
    //Version_1.6.0 合并资金区生意区为 企业服务
    /* else if ([array isEqualToArray:self.capitalList]) {
        HomeHeaderView *homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, 40)];
        [homeHeaderView setTitle:@"资金区" withMore:NO];
        return homeHeaderView;
    }*/ else if ([array isEqualToArray:self.spaceList]) {
        HomeHeaderView *homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, 38.5)];
        [homeHeaderView setTitle:@"空间服务" withMore:NO];
        return homeHeaderView;
    } else if ([array isEqualToArray:self.shareLineList]) {
        HomeHeaderView *homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, 38.5)];
        [homeHeaderView setTitle:@"时在分享" withMore:YES];
        [homeHeaderView setMoreActionBlock:^(){
            //more action
            [VSPageRoute routeToSZFX];
        }];
        return homeHeaderView;
    } else if ([array isEqualToArray:self.recommendList]) {
        HomeHeaderView *homeHeaderView = [[HomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, 38.5)];
        [homeHeaderView setTitle:@"为您推荐" withMore:NO];
        return homeHeaderView;
    }
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [self.tableList objectAtIndex:[indexPath section]];
    if ([array isEqualToArray:self.recommendList]) {
        ServiceModel *model = [self.recommendList objectAtIndex:[indexPath row]];
        [VSPageRoute routeToTarget:model];
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    NSArray *array = [self.tableList objectAtIndex:section];
    if ([array isEqualToArray:self.businessList]) {
        return 38.5;
    }
    //Version_1.6.0 合并资金区生意区为 企业服务
    /*else if ([array isEqualToArray:self.capitalList]) {
        return 38.5;
    }*/ else if ([array isEqualToArray:self.spaceList]) {
        return 38.5;
    } else if ([array isEqualToArray:self.shareLineList]) {
        return 38.5;
    } else if ([array isEqualToArray:self.businessList]) {
        return 38.5;
    } else if ([array isEqualToArray:self.recommendList]) {
        return 38.5;
    }
    
    return 0.00001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.3 animations:^{
        [self.oneKeyConsignHomeButton setAlpha:0.0f];
        [self.customServiceHomeButton setAlpha:0.0f];
        
        [self.oneKeyConsignHomeButton setFrame:CGRectMake(6.0f, self.view.frame.size.height - 49.0f - 49.0f -5.0f + 50.0f, __SCREEN_WIDTH__ - 12.0f, 49.0f)];
        [self.customServiceHomeButton setFrame:CGRectMake(__SCREEN_WIDTH__ - 64, self.view.frame.size.height - 49 - 49 - 70 + 50.0f, 56, 60)];
    }];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.oneKeyConsignHomeButton setAlpha:1.0f];
            [self.customServiceHomeButton setAlpha:1.0f];
            
            [self.oneKeyConsignHomeButton setFrame:CGRectMake(6.0f, self.view.frame.size.height - 49.0f - 49.0f -5.0f, __SCREEN_WIDTH__ - 12.0f, 49.0f)];
            [self.customServiceHomeButton setFrame:CGRectMake(__SCREEN_WIDTH__ - 64, self.view.frame.size.height - 49 - 49 - 70, 56, 60)];
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.3 animations:^{
        [self.oneKeyConsignHomeButton setAlpha:1.0f];
        [self.customServiceHomeButton setAlpha:1.0f];
        
        [self.oneKeyConsignHomeButton setFrame:CGRectMake(6.0f, self.view.frame.size.height - 49.0f - 49.0f -5.0f, __SCREEN_WIDTH__ - 12.0f, 49.0f)];
        [self.customServiceHomeButton setFrame:CGRectMake(__SCREEN_WIDTH__ - 64, self.view.frame.size.height - 49 - 49 - 70, 56, 60)];
    }];
}


@end
