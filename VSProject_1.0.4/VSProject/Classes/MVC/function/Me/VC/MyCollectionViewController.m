//
//  MyCollectionViewController.m
//  VSProject
//
//  Created by 张海东 on 2017/1/8.
//  Copyright © 2017年 user. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectedActivityViewController.h"   // 活动收藏
#import "MyBidCollectionViewController.h"       // 招标收藏
#import "MyCollectedPolicyViewController.h"     // 政策收藏
#import "MySpaceCollecteViewController.h"       // 控件收藏


@interface MyCollectionViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIView *discoverTypeSegmentView; // 发现页签分类
@property (nonatomic, strong) UIView *discoverTypeSegmentBottomLine; // 页签分类下划线

@property (nonatomic, strong) NSMutableArray *childVCArray; // child vc

@property (nonatomic, strong) UIViewController *currentPageVC;

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *segmentViewTitles;

@property (nonatomic, strong) UIView *headBottomLine; // 头部下划线

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self vs_setTitleText:@"我的收藏"];
    
    requestGroup = dispatch_group_create();
    
    [self initDiscoverTypeSegmentView];
    
    // 默认选中第一个
    [self selectTabPageeWithIndex:0];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIPageViewController *)pageViewController {
    
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageViewController.view.frame = CGRectMake(0, 45.0f, MainWidth, MainHeight - 45.0f - 7.5f);
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        [_pageViewController setViewControllers:@[[self.childVCArray objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    
    return _pageViewController;
}

- (NSMutableArray *)childVCArray {
    
    if (!_childVCArray) {
        _childVCArray = [NSMutableArray array];
        
        // 初始化child vc
        // 活动
        MyCollectedActivityViewController *activityVC = [[MyCollectedActivityViewController alloc] init];
        activityVC.view.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 45.0f - 7.5f);
        [_childVCArray insertObject:activityVC atIndex:ACTIVITY_COLLECTION_TYPE];
        
        // 招标收藏
        MyBidCollectionViewController *bidVC = [[MyBidCollectionViewController alloc] init];
        bidVC.view.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 45.0f - 7.5f);
        [_childVCArray insertObject:bidVC atIndex:BID_COLLECTION_TYPE];
        
        // 政策收藏
        MyCollectedPolicyViewController *policyVC = [[MyCollectedPolicyViewController alloc] init];
        policyVC.view.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 45.0f - 7.5f);
        [_childVCArray insertObject:policyVC atIndex:POLICY_COLLECTION_TYPE];
        
        // 空间收藏
        MySpaceCollecteViewController *spaceVC = [[MySpaceCollecteViewController alloc] init];
        spaceVC.view.frame = CGRectMake(0, 0, MainWidth, MainHeight - 64.0f - 45.0f - 7.5f);
        [_childVCArray insertObject:spaceVC atIndex:SPACE_COLLECTION_TYPE];
    }
    return _childVCArray;
}

- (NSArray *)segmentViewTitles {
    
    if (!_segmentViewTitles) {
        _segmentViewTitles = @[@"活动", @"投招标", @"政策", @"空间"];
    }
    return _segmentViewTitles;
}

- (UIView *)headBottomLine {
    
    if (!_headBottomLine) {
        _headBottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _headBottomLine.backgroundColor = _COLOR_HEX(0x5bddb1);
        _headBottomLine.hidden = YES;
    }
    return _headBottomLine;
}
    
// 得到相应的VC对象
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    return [self.childVCArray objectAtIndex:index];
}

// 根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewController {

    if ([viewController isKindOfClass:[MyCollectedActivityViewController class]])
    {
        return ACTIVITY_COLLECTION_TYPE;
    }
    else if ([viewController isKindOfClass:[MyBidCollectionViewController class]]) {
        return BID_COLLECTION_TYPE;
    }
    else if ([viewController isKindOfClass:[MyCollectedPolicyViewController class]]) {
        return POLICY_COLLECTION_TYPE;
    }
    else if ([viewController isKindOfClass:[MySpaceCollecteViewController class]]) {
        return SPACE_COLLECTION_TYPE;
    }
    else {
        return 0;
    }
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
        UIViewController *childVC = [[pageViewController viewControllers] objectAtIndex:0];
        NSInteger index = [self indexOfViewController:childVC];
        [self changeHeadTitle:index];
    }
}

- (UIView *)discoverTypeSegmentView {
    
    if (!_discoverTypeSegmentView) {
        _discoverTypeSegmentView = [[UIView alloc] init];
        _discoverTypeSegmentView.backgroundColor = [UIColor whiteColor];
    }
    return _discoverTypeSegmentView;
}

- (UIView *)discoverTypeSegmentBottomLine {
    
    if (!_discoverTypeSegmentBottomLine) {
        _discoverTypeSegmentBottomLine = [[UIView alloc] init];
        _discoverTypeSegmentBottomLine.backgroundColor = _COLOR_HEX(0xe5e5e5);
    }
    return _discoverTypeSegmentBottomLine;
}


- (void)initDiscoverTypeSegmentView {
    
    __weak typeof(self)weakself = self;
    
    [self.view addSubview:self.discoverTypeSegmentView];
    
    [self.discoverTypeSegmentView addSubview:self.discoverTypeSegmentBottomLine];
    [self.discoverTypeSegmentView addSubview:self.headBottomLine];
    
    [self.discoverTypeSegmentBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakself.discoverTypeSegmentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.discoverTypeSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(MainWidth);
        make.height.mas_equalTo(45.0f);
    }];
    
    [self.headBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(41);
        make.height.mas_equalTo(4.0f);
        make.width.mas_equalTo(MainWidth/4);
    }];
    
    // 根据title长度计算button间距 button大小按照自适应大小 + button间距1/2
    CGFloat buttonWidth = MainWidth / 4;
    
    // 宽度自适应，计算出间距
    CGFloat offset = 0;
    for (NSInteger i = 0; i < self.segmentViewTitles.count; i++) {
        
        NSString *title = self.segmentViewTitles[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:_COLOR_HEX(0x212121) forState:UIControlStateNormal];
//        [button setTitleColor:_COLOR_HEX(0x00c78c) forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.tag = 100 + i;
        button.selected = NO;
        
        [self.discoverTypeSegmentView addSubview:button];
        [button addTarget:self action:@selector(segmentViewAction:) forControlEvents:UIControlEventTouchUpInside];
    
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(41.0f);
            make.leading.equalTo(weakself.discoverTypeSegmentView).offset(offset);
        }];
        offset += buttonWidth;
    }
}

- (void)segmentViewAction:(UIButton *)button {
    
    [self selectTabPageeWithIndex:(button.tag - 100)];
    
    self.headBottomLine.hidden = NO;
    self.headBottomLine.frame = CGRectMake(button.frame.origin.x, 41.0f, MainWidth / 4, 4.0f);
    self.headBottomLine.backgroundColor = _COLOR_HEX(0x5bddb1);
}

- (void)changeHeadTitle:(NSInteger)index {
    
    // 刷新tab页头状态
    for (UIView *view in self.discoverTypeSegmentView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            view.backgroundColor = [UIColor whiteColor];
            UIButton *button = (UIButton *)view;
            if (button.tag == index + 100) {
                button.selected = YES;
                self.headBottomLine.hidden = NO;
                self.headBottomLine.frame = CGRectMake(button.frame.origin.x, 41.0f, MainWidth/4, 4.0f);
                self.headBottomLine.backgroundColor = _COLOR_HEX(0x5bddb1);
            }
            else {
                button.selected = NO;
            }
        }
    }
}

- (void)selectTabPageeWithIndex:(NSInteger)index {
    
    // 刷新tab页头状态
    [self changeHeadTitle:index];
    
    // 根据选中的订单状态展示不同页面
    if (self.childVCArray.count <= 0) { return; }
    
    [self.pageViewController setViewControllers:@[[self.childVCArray objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

@end
