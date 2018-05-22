//
//  HomeAppTableViewCell.m
//  VSProject
//
//  Created by apple on 12/28/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "HomeAppTableViewCell.h"
#import "HomeAppView.h"
#import "TAPageControl.h"

#define RatioForH_W 220/750

@interface HomeAppTableViewCell () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *appScrollView;

@property (nonatomic, strong) TAPageControl *pageControl;

@end

@implementation HomeAppTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIScrollView *)appScrollView {
    if (!_appScrollView) {
        _appScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_WIDTH__, __SCREEN_WIDTH__*RatioForH_W)];
        [_appScrollView setShowsHorizontalScrollIndicator:NO];
        _appScrollView.pagingEnabled = YES;
        _appScrollView.bounces = NO;
        _appScrollView.delegate = self;
    }
    return _appScrollView;
}

- (TAPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[TAPageControl alloc] init];
        [_pageControl setFrame:CGRectMake(0, __SCREEN_WIDTH__*RatioForH_W + 7, __SCREEN_WIDTH__, 7)];
        _pageControl.currentDotImage = [UIImage imageNamed:@"round_green" ];
        _pageControl.dotImage = [UIImage imageNamed:@"round_grey"];
        _pageControl.dotSize = CGSizeMake(7, 7);
        _pageControl.spacingBetweenDots = 8;
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

- (void)setDataSource:(NSArray *)appList {
    [self.contentView addSubview:self.appScrollView];
    
    float width = __SCREEN_WIDTH__/3.0;
    float heigh = __SCREEN_WIDTH__*RatioForH_W;
    
    NSInteger page = ceil(appList.count/3.0);
    
    if (page > 1) {
        [self.contentView addSubview:self.pageControl];
        [self.pageControl setNumberOfPages:page];
    }
    
    self.appScrollView.contentSize = CGSizeMake(__SCREEN_WIDTH__ * page, 0);
    
    //添加pageControl
    [self removeAllSubviews:self.appScrollView];
    for (NSInteger i = 0; i < [appList count]; i++) {
        RTXCAppModel *model = [appList objectAtIndex:i];
        HomeAppView *homeAppView = [[HomeAppView alloc] init];
        [homeAppView setFrame:CGRectMake(i * width, 0, width, heigh)];
        [homeAppView setDataSource:model];
        [self.appScrollView addSubview:homeAppView];
    }
}

- (void)removeAllSubviews:(UIScrollView *)scrollView {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (scrollView.subviews.count) {
        [scrollView.subviews.lastObject removeFromSuperview];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = floor((scrollView.contentOffset.x - __SCREEN_WIDTH__ / 2) / __SCREEN_WIDTH__) + 1;
    self.pageControl.currentPage = currentPage;
}

@end
