//
//  LifeAdsTableViewCell.m
//  smallDay
//
//  Created by 陈 海涛 on 16/6/20.
//  Copyright © 2016年 陈 海涛. All rights reserved.
//

#import "AdsTableViewCell.h"

#import "UIImageView+WebCache.h"
#import "TAPageControl.h"
#import "Masonry.h"
#import "UIImage+Ellipse.h"
#import "BannerDTO.h"

#define DefaultPic @"usercenter_defaultpic"

@interface AdsTableViewCell ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) NSArray *imageViews;

@property (nonatomic,strong) UIImageView *centerView;

@property (nonatomic,strong) UIImageView *rightView;

@property (nonatomic,strong) TAPageControl *pageControl;

@property (nonatomic,strong) NSTimer *timer;//定时器

@end

@implementation AdsTableViewCell

- (TAPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[TAPageControl alloc] init];
        _pageControl.currentDotImage = [UIImage imageNamed:@"banner_icon_h" ];
        _pageControl.dotImage = [UIImage imageNamed:@"banner_icon_n"];
        _pageControl.dotSize = CGSizeMake(10, 10);
        _pageControl.spacingBetweenDots = 8;
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (NSArray *)imageViews {
    if (_imageViews == nil) {
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (NSInteger i = 0 ; i < 3 ; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.contentMode = UIViewContentModeScaleToFill;
            
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
            
            imageView.clipsToBounds = YES;
            
            [arr addObject:imageView];
        }
        
        _imageViews  = [NSArray arrayWithArray:arr];
    }
    return _imageViews;
}


- (void)tapAction:(UITapGestureRecognizer *)tapGesture {
    
    UIView *view = tapGesture.view;
    
    if ([view isKindOfClass:[UIImageView class]]) {
        NSInteger index = view.tag;
        id ad = self.ads[index];
        if (self.adsClickBlock) {
            self.adsClickBlock(ad);
        }
    }
    
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.scrollView];
        
        for (UIImageView *imageView in self.imageViews) {
            [self.scrollView addSubview:imageView];
        }
        
        [self.contentView addSubview:self.pageControl];
        
        [self updateConstraintsForSubViews];
        
        self.contentView.clipsToBounds = YES;
    }
    
    return self;
}

- (void)updateConstraintsForSubViews {
    
    __weak typeof(self) weakSelf = self;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView);
    }];
    
    //    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(weakSelf.contentView);
    //        make.bottom.equalTo(weakSelf.contentView);
    //        
    //    }];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = self.imageViews[i];
        imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * i , 0, [UIScreen mainScreen].bounds.size.width, 320/750.0 * [UIScreen mainScreen].bounds.size.width);
    }
    
    //    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    
}


- (void)setAds:(NSArray *)ads {
    _ads = ads;
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat width = (weakSelf.pageControl.dotSize.width + 8) * ads.count;
    
    self.pageControl.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - width) / 2, BannerHeight - 20, width, 20);
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = ads.count;
    
    
    
    
    for (NSInteger i = 0 ; i < 3; i++ ) {
        NSInteger index = 0;
        
        if (i == 0) {
            index -= 1;
        }
        
        if (i == 2) {
            index +=1;
        }
        
        if (index < 0) {
            index = ads.count - 1;
        }
        if (index > ads.count - 1) {
            index = 0;
        }
        
        UIImageView *imageView = self.imageViews[i];
        
        id ad = ads[index];
        imageView.tag = index;
        
        if ([ad isKindOfClass:[UIImage class]]) {
            imageView.image = ad;
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString:((BannerDTO *)ad).bannerPic] placeholderImage:[UIImage imageNamed:DefaultPic]];
        }
    }
    [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    
    
    if (ads.count > 1) {
        if (self.timer == nil) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self  selector:@selector(timerAction) userInfo:nil repeats:YES];
        }
        self.scrollView.scrollEnabled = YES;
    }else{
        [self.timer invalidate];
        self.timer = nil;
        self.scrollView.scrollEnabled = NO;
    }
    
    
    
    
    
}



- (void)timerAction {
    
    [UIView animateWithDuration:1 animations:^{
        [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * 2, 0) animated:NO];
        
    }completion:^(BOOL finished) {
        [self scrollViewDidEndScrollingAnimation:self.scrollView];
    }];
}


#pragma mark - UIScrollView delegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width) ;
    
    UIImageView *imageView = self.imageViews[index];
    
    self.pageControl.currentPage = imageView.tag;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    for (NSInteger i = 0; i < 3; i++) {
        
        NSInteger index = self.pageControl.currentPage;
        
        if (i == 0) {
            index -= 1;
        }
        
        if (i == 2) {
            index += 1;
        }
        
        if (index  < 0) {
            index = self.ads.count - 1;
        }
        
        if (index > self.ads.count - 1) {
            index = 0;
        }
        
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        imageView.tag = index;
        
        id ad = self.ads[index];
        
        if ([ad isKindOfClass:[UIImage class]]) {
            imageView.image = ad;
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString:[ad bannerPic]] placeholderImage:[UIImage imageNamed:DefaultPic]];
        }
        
        
        
    }
    
    [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    
    if (self.timer == nil) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self  selector:@selector(timerAction) userInfo:nil repeats:YES];
        
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    for (NSInteger i = 0; i < 3; i++) {
        
        NSInteger index = self.pageControl.currentPage;
        
        if (i == 0) {
            index -= 1;
        }
        
        if (i == 2) {
            index += 1;
        }
        
        if (index  < 0) {
            index = self.ads.count - 1;
        }
        
        if (index > self.ads.count - 1) {
            index = 0;
        }
        
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        imageView.tag = index;
        
        id ad = self.ads[index];
        
        if ([ad isKindOfClass:[UIImage class]]) {
            imageView.image = ad;
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString:[ad bannerPic]] placeholderImage:[UIImage imageNamed:DefaultPic]];
        }
        
    }
    
    [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    
}
@end
