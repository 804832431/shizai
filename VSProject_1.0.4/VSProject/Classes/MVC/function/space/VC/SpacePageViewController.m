//
//  SpacePageViewController.m
//  VSProject
//
//  Created by pangchao on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpacePageViewController.h"
#import "AdsTableViewCell.h"
#import "HomeManger.h"
#import "BCNetWorkTool.h"
#import "BannerDTO.h"
#import "MJExtension.h"
#import "NewShareWebViewController.h"
#import "SpaceLeaseViewController.h"
#import "CooperateViewController.h"
#import "SpaceModel.h"

@interface SpacePageViewController () <UITableViewDelegate, UITableViewDataSource, UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    HomeManger *manger;
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView; // 标签
@property (nonatomic, strong) UIView *headBottomLine;

@property (nonatomic, strong) NSMutableArray *adList; // 广告数据源

@property (nonatomic, strong) NSMutableArray *childVCArray; // child vc

@property (nonatomic, strong) SpaceLeaseViewController *currentPageVC;

@property (nonatomic, strong) NSMutableArray *segmentViewTitles;

@property (nonatomic, strong) NSArray *spaceList;

@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation SpacePageViewController

- (id)init {
    
    self = [super init];
    if (self) {
        self.spaceType = CONFERENCE_ROOM_TYPE;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = 0;
    
    self.shouldShowOneKeyConsign = YES;
    self.shouldShouContactCustomService  = YES;
    
    requestGroup = dispatch_group_create();
    
    manger = [[HomeManger alloc] init];
    
    self.view.backgroundColor = _COLOR_HEX(0xf3f3f3);
    
    [self vs_setTitleText:@"空间"];
    
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView addHeaderWithCallback:^{
        [weakSelf requestData];
    }];
    
    [self recoverRightButton];
    
    [self.tableView headerBeginRefreshing];
}

- (void)recoverRightButton {
    
    self.navigationItem.rightBarButtonItem = nil;
    [self vs_showRightButton:YES];
    
    [self vs_showRightButton:YES];
    [self.vm_rightButton setFrame:_CGR(0, 0, 70, 28)];
    self.vm_rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.vm_rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.vm_rightButton setTitle:@"  我要合作" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)vs_rightButtonAction:(id)sender
{
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        CooperateViewController *controller = [[CooperateViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } cancel:^{
        
    }];
}

- (void)requestData {
    
//    [self vs_showLoading];
    
    [self loadAdData];
    
    [self loadSpaceData];
    
    __weak typeof(self)weakself = self;
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        [weakself.tableView headerEndRefreshing];
        [weakself.tableView footerEndRefreshing];
        [weakself.tableView reloadData];
        [weakself convertTypeToClassId];
        [weakself initHeadView];
        [weakself initChildVC];
        [weakself changeTableWithClassId:weakself.classId];
        
    });
}

- (void)convertTypeToClassId {
    
    switch (self.spaceType) {
        case SPACE_LEASE_TYPE:
            self.classId = @"spaceLeaseNew";
            break;
        case CONFERENCE_ROOM_TYPE:
            self.classId = @"conferenceRoom";
            break;
        case MOBILE_STATION_TYPE:
            self.classId = @"mobileStation";
            break;
        case SPACE_ACQUISITION:
            self.classId = @"spaceAcquisition";
            break;
            
        default:
            break;
    }
}

- (void)changeTableWithClassId:(NSString *)classId {
    
    NSInteger index = 0;
    for (NSInteger i=0; i<self.spaceList.count; ++i) {
        SpaceModel *model = [self.spaceList objectAtIndex:i];
        if ([classId isEqualToString:model.classId]) {
            index = i;
            break;
        }
    }
    
    for (UIView *view in self.headView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            view.backgroundColor = [UIColor whiteColor];
            UIButton *button = (UIButton *)view;
            if (button.tag == index + 100) {
                
                [self segmentViewAction:button];
                return;
            }
        }
    }
}

- (void)loadSpaceData {
    
    dispatch_group_enter(requestGroup);
    
    __weak typeof(self)weakself = self;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.space/get-space-area/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:nil andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        NSDictionary *dic = (NSDictionary *)callBackData;
        NSMutableArray *spaceList = [NSMutableArray array];
        NSMutableArray *tmpSpaceList = [SpaceModel mj_objectArrayWithKeyValuesArray:dic[@"spaceClassList"]];
        for (SpaceModel *model in tmpSpaceList) {
            if ([model.classId hasPrefix:@"spaceLease"]) {
                continue;
            }
            [spaceList addObject:model];
        }
        weakself.spaceList = spaceList;
        [weakself.segmentViewTitles removeAllObjects];
        for (NSInteger i=0; i<weakself.spaceList.count; ++i) {
            SpaceModel *model = [weakself.spaceList objectAtIndex:i];
            if ([model.classId hasPrefix:@"spaceLease"]) {
                continue;
            }
            [weakself.segmentViewTitles addObject:model.name];
        }
        dispatch_group_leave(requestGroup);
    } orFail:^(id callBackData) {
        dispatch_group_leave(requestGroup);
    }];
}

- (void)loadAdData {
    
    dispatch_group_enter(requestGroup);
    
    NSDictionary *dic = @{
                          @"bannerType":@"2",
                          @"objectId" : @"space",
                          };
    __weak typeof(self)weakself = self;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *url = [NSString stringWithFormat:@"/RUI-CustomerJSONWebService-portlet.banner/get-banner-info/version/%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [BCNetWorkTool executeGETNetworkWithParameter:dic andUrlIdentifier:url withSuccess:^(id callBackData) {
        NSLog(@"%@",callBackData );
        
        NSDictionary *dic = (NSDictionary *)callBackData;
        
        weakself.adList = [BannerDTO mj_objectArrayWithKeyValuesArray:dic[@"advertisementList"]];
        
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        
        dispatch_group_leave(requestGroup);
        
    } orFail:^(id callBackData) {
        [weakself vs_hideLoadingWithCompleteBlock:nil];
        
        dispatch_group_leave(requestGroup);
    }];
}

#pragma mark -- 控件初始化

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        [_tableView registerClass:[AdsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AdsTableViewCell class])];
    }
    
    return _tableView;
}

- (UIView *)headView {
    
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.frame = CGRectMake(0, 0, MainWidth, 40.0f);
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

- (void)initHeadView {
    
    for (UIView *view in self.headView.subviews) {
        
        [view removeFromSuperview];
    }
    
    // 根据title长度计算button间距 button大小按照自适应大小 + button间距1/2
    CGFloat buttonWidth = MainWidth / self.segmentViewTitles.count;
    // 宽度自适应，计算出间距
    CGFloat spaceWidth = 0;
    CGFloat offset = 0;
    for (NSInteger i = 0; i < self.spaceList.count; i++) {
        
        
        SpaceModel *model = [self.spaceList objectAtIndex:i];
        if ([model.classId hasPrefix:@"spaceLease"]) {
            continue;
        }
        NSString *title = model.name;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:_COLOR_HEX(0x212121) forState:UIControlStateNormal];
        [button setTitleColor:_COLOR_HEX(0x00c78c) forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.tag = 100 + i;
        button.selected = NO;
        
        if ([model.classId isEqualToString:self.classId]) {
            self.headBottomLine.frame = CGRectMake(buttonWidth*i, 36.0f, buttonWidth, 4.0f);
        }
        
        [self.headView addSubview:button];
        [button addTarget:self action:@selector(segmentViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        __weak typeof(self)weakself = self;
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
//            make.width.mas_equalTo(buttonWidth);
//            make.height.mas_equalTo(36.0f);
//            make.leading.equalTo(weakself.headView).offset(offset);
//        }];
        button.frame = CGRectMake(offset, 0, buttonWidth, 36.0f);
        offset += (buttonWidth + spaceWidth);
    }
    
    [self.headView addSubview:self.headBottomLine];
}

- (UIView *)headBottomLine {
    
    if (!_headBottomLine) {
        _headBottomLine = [[UIView alloc] init];
        _headBottomLine.frame = CGRectMake(0, 36.0f, MainWidth / self.segmentViewTitles.count, 4.0f);
        _headBottomLine.backgroundColor = _COLOR_HEX(0x5bddb1);
    }
    return _headBottomLine;
}

- (void)initChildVC {
    
    [self.childVCArray removeAllObjects];
    for (NSInteger i=0; i<self.spaceList.count; i++) {
        
        SpaceLeaseViewController *spaceVC = [[SpaceLeaseViewController alloc] init];
        SpaceModel *model = [self.spaceList objectAtIndex:i];
        spaceVC.classId = model.classId;
        spaceVC.view.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 30.0f);
        [self.childVCArray insertObject:spaceVC atIndex:i];
        [spaceVC setLoadDataSuccessBolck:^() {
            [self changeTableWithClassId:self.classId];
        }];
    }
}

- (UIPageViewController *)pageViewController {
    
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageViewController.view.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 44.0f - 7.5f);
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
    }
    
    return _pageViewController;
}

- (void)segmentViewAction:(UIButton *)button {
    
    [self selectTabPageeWithIndex:(button.tag - 100)];
    SpaceModel *model = [self.spaceList objectAtIndex:button.tag - 100];
    if ([model.classId isEqualToString:@"spaceLeaseNew"]) {
        self.spaceType = SPACE_LEASE_TYPE;
    }
    else if ([model.classId isEqualToString:@"conferenceRoom"]) {
        self.spaceType = CONFERENCE_ROOM_TYPE;
    }
    else if ([model.classId isEqualToString:@"mobileStation"]) {
        self.spaceType = MOBILE_STATION_TYPE;
    }
    else if ([model.classId isEqualToString:@"spaceAcquisition"]) {
        self.spaceType = SPACE_ACQUISITION;
    }
    else {
        self.spaceType = 0;
    }
}

- (void)changeHeadTitle:(NSInteger)index {
    
    // 刷新tab页头状态
    for (UIView *view in self.headView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            view.backgroundColor = [UIColor whiteColor];
            UIButton *button = (UIButton *)view;
            if (button.tag == index + 100) {
                button.selected = YES;
                self.headBottomLine.frame = CGRectMake(button.frame.origin.x, 36.0f, button.frame.size.width, 4.0f);
                self.headBottomLine.hidden = NO;
                [self.headView bringSubviewToFront:self.headBottomLine];
            }
            else {
                button.selected = NO;
            }
        }
    }
}

- (void)selectTabPageeWithIndex:(NSInteger)index {
    
    [self changeHeadTitle:index];
    
    // 根据选中的订单状态展示不同页面
    if (self.childVCArray.count <= 0) { return; }
    
    self.currentPageVC = [self.childVCArray objectAtIndex:index];
    [self.pageViewController setViewControllers:@[self.currentPageVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.tableView reloadData];
}

- (NSMutableArray *)childVCArray {
    
    if (!_childVCArray) {
        _childVCArray = [NSMutableArray array];
        
//        // 初始化child vc
//        // 空间租赁
//        SpaceLeaseViewController *leaseChannel = [[SpaceLeaseViewController alloc] init];
//        leaseChannel.classId = @"spaceLease";
//        leaseChannel.view.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 30.0f);
//        [_childVCArray insertObject:leaseChannel atIndex:0];
//        
//        // 会议室
//        SpaceLeaseViewController *officeChannel = [[SpaceLeaseViewController alloc] init];
//        officeChannel.classId = @"conferenceRoom";
//        officeChannel.view.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 30.0f);
//        [_childVCArray insertObject:officeChannel atIndex:1];
//        
//        // 移动工位
//        SpaceLeaseViewController *stationChannel = [[SpaceLeaseViewController alloc] init];
//        stationChannel.classId = @"mobileStation";
//        stationChannel.view.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 30.0f);
//        [_childVCArray insertObject:stationChannel atIndex:2];
//        
//        // 空间购置
//        SpaceLeaseViewController *purchaseChannel = [[SpaceLeaseViewController alloc] init];
//        purchaseChannel.classId = @"spaceAcquisition";
//        purchaseChannel.view.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 30.0f);
//        [_childVCArray insertObject:purchaseChannel atIndex:3];
    }
    return _childVCArray;
}

- (NSMutableArray *)segmentViewTitles {
    
    if (!_segmentViewTitles) {
//        _segmentViewTitles = @[@"空间租赁", @"会议室", @"移动工位", @"空间购置"];
        _segmentViewTitles = [NSMutableArray array];
    }
    return _segmentViewTitles;
}

#pragma mark -  tableView delegate and dataSource method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
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
        
        
    }else if(indexPath.section == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectionCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collectionCell"];
        }
        
//        [cell.contentView addSubview:self.spaceTypeView];
        
        if (self.pageViewController.view.superview) {
            [self.pageViewController.view removeFromSuperview];
        }
        
        [self addChildViewController:self.pageViewController];
        [cell.contentView addSubview:self.pageViewController.view];
        
        return cell;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 320/750.0 * [UIScreen mainScreen].bounds.size.width;
        
    }else if (indexPath.section == 1) {
        
//        return self.pageViewController.view.frame.size.height + 20;
        return [self.currentPageVC getViewHeight] + 20.0f;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return self.headView;
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return 40.0f;
    }
    else {
        return 0.0001f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.0001f;
}

// 得到相应的VC对象
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    return [self.childVCArray objectAtIndex:index];
}

// 根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    
    SpaceLeaseViewController *spaceVC = (SpaceLeaseViewController *)viewController;
    for (NSInteger i=0; i<self.spaceList.count; ++i) {
        SpaceModel *model = [self.spaceList objectAtIndex:i];
        if ([spaceVC.classId isEqualToString:model.classId]) {
            return i;
        }
    }
    
    return 0;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法，自动来维护次序。
    // 不用我们去操心每个ViewController的顺序问题。
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    // 计算当前 viewController 数据在数组中的下标
    NSUInteger index = [self indexOfViewController:viewController];
    
    // index为数组最末表示已经翻至最后页
    if (index == NSNotFound ||
        index == (self.segmentViewTitles.count - 1)) {
        return nil;
    }
    
    // 下标自增
    index ++;
    
    return [self viewControllerAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed == YES) {
        SpaceLeaseViewController *childVC = [[pageViewController viewControllers] objectAtIndex:0];
        NSInteger index = [self indexOfViewController:childVC];
        [self changeHeadTitle:index];
        self.currentPageVC = childVC;
        childVC.view.frame = CGRectMake(0, 0, MainWidth, [childVC getViewHeight] + 20.0f);
        [self.tableView reloadData];
    }
}

@end
