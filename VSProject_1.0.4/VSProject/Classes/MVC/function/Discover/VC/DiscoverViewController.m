//
//  DiscoverViewController.m
//  VSProject
//
//  Created by pangchao on 16/12/27.
//  Copyright © 2016年 user. All rights reserved.
//

#import "DiscoverViewController.h"
#import "EnterpriseChannelViewController.h"
#import "SZShareViewController.h"
#import "MJExtension.h"
#import "JoinEntrepreneurClubViewController.h"
#import "newNearSelectedProjectViewController.h"
#import "NewShareWebViewController.h"

@interface DiscoverViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    dispatch_group_t requestGroup;
}

@property (nonatomic, strong) UIView *discoverTypeSegmentView; // 发现页签分类
@property (nonatomic, strong) UIView *discoverTypeSegmentBottomLine; // 页签分类下划线

@property (nonatomic, strong) NSMutableArray *childVCArray; // child vc

@property (nonatomic, strong) UIViewController *currentPageVC;

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *segmentViewTitles;

@property (nonatomic, strong) UIButton *flowButton;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shouldShowOneKeyConsign = YES;
    self.shouldShouContactCustomService  = YES;
    
    self.navigationController.navigationBarHidden = YES;
    
    requestGroup = dispatch_group_create();
    
    [self initDiscoverTypeSegmentView];
    
    // 默认选中第一个
    [self selectTabPageeWithIndex:1];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    [self addFlowButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
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
        _discoverTypeSegmentBottomLine.backgroundColor = _Colorhex(0xa5a5a6);
    }
    return _discoverTypeSegmentBottomLine;
}

- (NSArray *)segmentViewTitles {
    
    if (!_segmentViewTitles) {
        _segmentViewTitles = @[@"周边项目", @"时在分享", @"企业频道", @"企业家俱乐部"];
    }
    return _segmentViewTitles;
}

- (UIPageViewController *)pageViewController {
    
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey: UIPageViewControllerOptionSpineLocationKey];
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageViewController.view.frame = CGRectMake(0, 64.0f, MainWidth, MainHeight - 64.0f - 49.0f);
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
        // 周边项目
        newNearSelectedProjectViewController *nearVC = [[newNearSelectedProjectViewController alloc] init];
        nearVC.view.frame = CGRectMake(0, 64.0f, MainWidth, MainHeight - 64.0f - 44.0f - 7.5f);
        [_childVCArray insertObject:nearVC atIndex:DISCOVER_NEARBY];
        
        // 时在分享
        SZShareViewController *shareVC = [[SZShareViewController alloc] init];
        shareVC.view.frame = CGRectMake(0, 64.0f, MainWidth, MainHeight - 64.0f - 44.0f - 7.5f);
        [_childVCArray insertObject:shareVC atIndex:DICOVER_SHARE];
        
        // 企业频道
        EnterpriseChannelViewController *enterpriseChannel = [[EnterpriseChannelViewController alloc] init];
        enterpriseChannel.view.frame = CGRectMake(0, 64.0f, MainWidth, MainHeight - 64.0f - 44.0f - 7.5f);
        [_childVCArray insertObject:enterpriseChannel atIndex:DISCOVER_ENTERPRISE_CHANNEL];
        
        // 企业家俱乐部
        NSString *url = [SERVER_IP_H5 stringByAppendingString:@"/api/news/getNewsDetailForJlb.do?typeFirCate=newsEnterpriseClub"];
        NewShareWebViewController *webVC = [[NewShareWebViewController alloc] initWithUrl:[NSURL URLWithString:url]];
        webVC.view.frame = CGRectMake(0, 64.0f + 7.5f, MainWidth, MainHeight - 64.0f - 44.0f - 7.5f);
        [_childVCArray insertObject:webVC atIndex:DISCOVER_ENTERPENEUR_CLUB];
        
    }
    return _childVCArray;
}

- (void)initDiscoverTypeSegmentView {
    
    __weak typeof(self)weakself = self;

    [self.view addSubview:self.discoverTypeSegmentView];

    [self.discoverTypeSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(MainWidth);
        make.height.mas_equalTo(64.0f);
    }];
    
    [self.discoverTypeSegmentView addSubview:self.discoverTypeSegmentBottomLine];
    
    [self.discoverTypeSegmentBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakself.discoverTypeSegmentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    // 根据title长度计算button间距 button大小按照自适应大小 + button间距1/2
    CGFloat buttonWidth = 0.0f;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20],NSFontAttributeName, nil];
    for (NSInteger i=0; i<self.segmentViewTitles.count; ++i) {
        NSString *title = [self.segmentViewTitles objectAtIndex:i];
        CGSize buttonSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 18.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        buttonWidth += buttonSize.width;
    }
    
    // 宽度自适应，计算出间距
    CGFloat spaceWidth = (MainWidth - 12.0f*2 - buttonWidth)/(self.segmentViewTitles.count - 1);
    CGFloat offset = 12.0f;
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        offset = 0;
    }
    for (NSInteger i = 0; i < self.segmentViewTitles.count; i++) {
        
        NSString *title = self.segmentViewTitles[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(2.0f, 0, Get750Width(28.0f), 0)];
        [button setTitle:title forState:UIControlStateNormal];
//        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:_COLOR_HEX(0x212121) forState:UIControlStateNormal];
        [button setTitleColor:_COLOR_HEX(0x00c78c) forState:UIControlStateSelected];
        // 根据机型确定字体大小
        if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
            [button.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        }
        else {
            [button.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        }
        [button setBackgroundColor:[UIColor whiteColor]];
        button.tag = 100 + i;
        button.selected = NO;
        
        [self.discoverTypeSegmentView addSubview:button];
        [button addTarget:self action:@selector(segmentViewAction:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat width = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 18.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.width;
        if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
            width = MainWidth / 4;
            button.frame = CGRectMake(offset, 32.0f, width, 31.5f );
            offset += width;
        }
        else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(32.0f);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(31.5f);
                make.leading.equalTo(weakself.discoverTypeSegmentView).offset(offset);
            }];
            button.frame = CGRectMake(offset, 32.0f, width, 31.5f );
            offset += (width + spaceWidth);
        }
    }
}

- (void)segmentViewAction:(UIButton *)button {
    
    [self selectTabPageeWithIndex:(button.tag - 100 + 1)];
}

- (void)changeHeadTitle:(NSInteger)index {
    
    // 刷新tab页头状态
    for (UIView *view in self.discoverTypeSegmentView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            view.backgroundColor = [UIColor whiteColor];
            UIButton *button = (UIButton *)view;
            if (button.tag == index - 1 + 100) {
                button.selected = YES;
                // 根据机型确定字体大小
                if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
                    [button.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
                }
                else {
                    [button.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
                }
            }
            else {
                button.selected = NO;
                // 根据机型确定字体大小
                if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
                    [button.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
                }
                else {
                    [button.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
                }
            }
        }
    }
    
    UIViewController *childPageViewController = [self.childVCArray objectAtIndex:(index-1)];
    switch (index - 1) {
        case DISCOVER_ENTERPRISE_CHANNEL:
        {
//            [(EnterpriseChannelViewController *)childPageViewController refresh];
            self.flowButton.hidden = YES;
            break;
        }
        case DISCOVER_ENTERPENEUR_CLUB:
            [(VSJsWebViewController *)childPageViewController reloadWebView];
            self.flowButton.hidden = NO;
            [self.view bringSubviewToFront:self.flowButton];
            break;
        case DISCOVER_NEARBY:
        {
//            [(newNearSelectedProjectViewController *)childPageViewController refresh];
            self.flowButton.hidden = YES;
            break;
        }
        case DICOVER_SHARE:
//            [(SZShareViewController *)childPageViewController refresh];
            self.flowButton.hidden = YES;
            break;
            
        default:
            break;
    }
}

- (void)selectTabPageeWithIndex:(NSInteger)index {
    
    // 刷新tab页头状态
    [self changeHeadTitle:index];
    
    // 根据选中的订单状态展示不同页面
    if (self.childVCArray.count <= 0) { return; }
    
    [self.pageViewController setViewControllers:@[[self.childVCArray objectAtIndex:index-1]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    if (index == 4) {
        [self.customServiceButton setHidden:YES];
        [self.oneKeyConsignButton setHidden:YES];
    } else {
        [self.customServiceButton setHidden:NO];
        [self.oneKeyConsignButton setHidden:NO];
    }
}

- (void)addFlowButton {
    
    UIButton *flowButton = [[UIButton alloc]initWithFrame:CGRectMake(MainWidth - 76.0f, MainHeight - 44.0f - 10.0f - 75.0f, 75.0f, 75.0f)];
    flowButton.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 75.0f, 75.0f);
    imageView.image = [UIImage imageNamed:@"btn_round"];
    [flowButton addSubview:imageView];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.frame = CGRectMake(10.0f, 10.0f, 55.0f, 55.0f);
    textLabel.font = [UIFont systemFontOfSize:18.0f];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.numberOfLines = 0;
    textLabel.text = @"我要\n加入";
    [flowButton addSubview:textLabel];
    
    [flowButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    flowButton.hidden = YES;
    self.flowButton = flowButton;
    
    [self.view addSubview:flowButton];
    [self.view bringSubviewToFront:flowButton];
}

- (void)addAction:(UIButton *)button {
    [self userlogin:LOGIN_BACK_DEFAULT popVc:self animated:YES LoginSucceed:^{
        JoinEntrepreneurClubViewController *vc = [[JoinEntrepreneurClubViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } cancel:^{
        
    }];
}

// 得到相应的VC对象
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    return [self.childVCArray objectAtIndex:index];
}

// 根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[EnterpriseChannelViewController class]])
    {
        return DISCOVER_ENTERPRISE_CHANNEL;
    }
    else if ([viewController isKindOfClass:[VSJsWebViewController class]]) {
        return DISCOVER_ENTERPENEUR_CLUB;
    }
    else if ([viewController isKindOfClass:[newNearSelectedProjectViewController class]]) {
        return DISCOVER_NEARBY;
    }
    else if ([viewController isKindOfClass:[SZShareViewController class]]) {
        return DICOVER_SHARE;
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
        [self changeHeadTitle:index+1];
    }
}

@end
