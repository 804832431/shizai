//
//  HomeShareLineTableViewCell.m
//  VSProject
//
//  Created by apple on 12/28/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "HomeShareLineTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TAPageControl.h"
#import "Masonry.h"
#import "UIImage+Ellipse.h"
#import "PolicyModel.h"
#import "HomeShareLineView.h"

#define DefaultPic @"usercenter_defaultpic"

@interface HomeShareLineTableViewCell () <UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) NSArray *imageViews;

@property (nonatomic,strong) HomeShareLineView *centerView;

@property (nonatomic,strong) HomeShareLineView *rightView;

@property (nonatomic,strong) TAPageControl *pageControl;

@property (nonatomic,strong) NSTimer *timer;//定时器

@end

@implementation HomeShareLineTableViewCell

- (TAPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[TAPageControl alloc] init];
        _pageControl.currentDotImage = [UIImage imageNamed:@"round_green" ];
        _pageControl.dotImage = [UIImage imageNamed:@"round_grey"];
        _pageControl.dotSize = CGSizeMake(7, 7);
        _pageControl.spacingBetweenDots = 7;
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 5, __SCREEN_WIDTH__, (180.0/750.0)*__SCREEN_WIDTH__)];
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
            HomeShareLineView *imageView = [[HomeShareLineView alloc] init];
            
            imageView.frame = CGRectMake(__SCREEN_WIDTH__ * i , 0, __SCREEN_WIDTH__, (180.0/750.0) * __SCREEN_WIDTH__);
            
            imageView.shareImageView.contentMode = UIViewContentModeScaleToFill;
            
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
    if ([view isKindOfClass:[HomeShareLineView class]]) {
        NSInteger index = view.tag;
        id shareLine = self.shareLineList[index];
        if (self.shareLineClickBlock) {
            self.shareLineClickBlock(shareLine);
        }
    }
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    
    return self;
}

- (void)updateConstraintsForSubViews {
    
    __weak typeof(self) weakSelf = self;
    
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(weakSelf.contentView);
//    }];
    
    //    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(weakSelf.contentView);
    //        make.bottom.equalTo(weakSelf.contentView);
    //
    //    }];
    
//    for (NSInteger i = 0; i < 3; i++) {
//        HomeShareLineView *imageView = self.imageViews[i];
//        imageView.frame = CGRectMake(__SCREEN_WIDTH__ * i , 0, __SCREEN_WIDTH__, (250.0/750.0) * __SCREEN_WIDTH__);
//    }
    
    //    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    
}


- (void)setShareLineList:(NSArray *)shareLineList {
    _shareLineList = shareLineList;
    
    __weak typeof(self) weakSelf = self;
    
    [self.contentView addSubview:self.scrollView];
    
    for (HomeShareLineView *imageView in self.imageViews) {
        [self.scrollView addSubview:imageView];
    }
    
    [self.contentView addSubview:self.pageControl];
    CGFloat width = (weakSelf.pageControl.dotSize.width + 8) * shareLineList.count;
    self.pageControl.frame = CGRectMake(0, (254.0/750.0 * [UIScreen mainScreen].bounds.size.width) - 15 - 7, __SCREEN_WIDTH__, 7);
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = shareLineList.count;
    
    
    
    
    for (NSInteger i = 0 ; i < 3; i++ ) {
        NSInteger index = 0;
        
        if (i == 0) {
            index -= 1;
        }
        
        if (i == 2) {
            index +=1;
        }
        
        if (index < 0) {
            index = shareLineList.count - 1;
        }
        if (index > shareLineList.count - 1) {
            index = 0;
        }
        
        HomeShareLineView *imageView = self.imageViews[i];
        
        PolicyModel *ad = shareLineList[index];
        imageView.tag = index;

        [imageView.shareImageView sd_setImageWithURL:[NSURL URLWithString:ad.image] placeholderImage:[UIImage imageNamed:DefaultPic]];
        [imageView.shareImageView.layer setCornerRadius:2.0];
        [imageView.shareImageView setClipsToBounds:YES];
        [imageView.shareLabel setText:ad.title];
        [imageView.shareTextView setText:ad.title];
        [imageView onSetTime:ad.createTime];
    }
    [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    
    
    if (shareLineList.count > 1) {
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
    
    HomeShareLineView *imageView = self.imageViews[index];
    
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
            index = self.shareLineList.count - 1;
        }
        
        if (index > self.shareLineList.count - 1) {
            index = 0;
        }
        
        HomeShareLineView *imageView = [self.imageViews objectAtIndex:i];
        imageView.tag = index;
        
        PolicyModel *ad = self.shareLineList[index];
        
        [imageView.shareImageView sd_setImageWithURL:[NSURL URLWithString:ad.image] placeholderImage:[UIImage imageNamed:DefaultPic]];
        [imageView.shareLabel setText:ad.title];
        [imageView.shareTextView setText:ad.title];
        [imageView onSetTime:ad.createTime];
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
            index = self.shareLineList.count - 1;
        }
        
        if (index > self.shareLineList.count - 1) {
            index = 0;
        }
        
        HomeShareLineView *imageView = [self.imageViews objectAtIndex:i];
        imageView.tag = index;
        
        PolicyModel *ad = self.shareLineList[index];
        
        [imageView.shareImageView sd_setImageWithURL:[NSURL URLWithString:ad.image] placeholderImage:[UIImage imageNamed:DefaultPic]];
        [imageView.shareLabel setText:ad.title];
        [imageView.shareTextView setText:ad.title];
        [imageView onSetTime:ad.createTime];
        
    }
    
    [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    
}

@end
