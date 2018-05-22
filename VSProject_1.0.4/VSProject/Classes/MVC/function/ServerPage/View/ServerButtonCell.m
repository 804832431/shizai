//
//  ServerButtonCell.m
//  VSProject
//
//  Created by pangchao on 17/6/25.
//  Copyright © 2017年 user. All rights reserved.
//

#import "ServerButtonCell.h"
#import "TAPageControl.h"
#import "ServerButtonView.h"

#define PAGE_NUM    8

@interface ServerButtonCell ()<UIScrollViewDelegate, ServerButtonViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic,strong) TAPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *viewArray;

@end

@implementation ServerButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.contentView addSubview:self.scrollView];
        
        for (NSInteger index=0; index<self.viewArray.count; index++) {
            
            ServerButtonView *buttonView = [self.viewArray objectAtIndex:index];
            [self.scrollView addSubview:buttonView];
        }
        
        [self.contentView addSubview:self.pageControl];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainWidth, [ServerButtonView getHeighWithIconCount:self.dataList.count]);
    
    CGFloat offset = 0;
    for (ServerButtonView *view in self.viewArray) {
        view.frame = CGRectMake(offset, 0, MainWidth, [ServerButtonView getHeighWithIconCount:self.dataList.count]);
        offset += MainWidth;
    }
    
    CGFloat width = (self.pageControl.dotSize.width + 8) * self.viewArray.count;
    self.pageControl.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - width) / 2, Get750Width(390.0f - 30.0f - 14.0f), width, 14.0f);
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.viewArray.count;
    if (self.viewArray.count <= 1) {
        self.pageControl.hidden = YES;
    }
    else {
        self.pageControl.hidden = NO;
    }
}

- (void)setDataSource:(NSArray *)dataList {
    
    self.dataList = dataList;
    
    [self.viewArray removeAllObjects];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger index=0; index<self.dataList.count; index++) {
        
        CGFloat offset = 0;
        if (arr.count == 8) {
            ServerButtonView *buttonView = [[ServerButtonView alloc] initWithFrame:CGRectZero];
            [buttonView setDataSource:arr];
            buttonView.clickedDelegate = self;
            buttonView.frame = CGRectMake(offset, 0, MainWidth, Get750Width(360));
            [self.viewArray addObject:buttonView];
            
            [arr removeAllObjects];
        }
        
        [arr addObject:[self.dataList objectAtIndex:index]];
    }
    if (arr.count > 0) {
        ServerButtonView *buttonView = [[ServerButtonView alloc] initWithFrame:CGRectZero];
        [buttonView setDataSource:arr];
        buttonView.clickedDelegate = self;
        [self.viewArray addObject:buttonView];
        
        [arr removeAllObjects];
    }
    
    while (self.scrollView.subviews.count) {
        UIView* child = self.scrollView.subviews.lastObject;
        [child removeFromSuperview];
    }
    for (NSInteger index=0; index<self.viewArray.count; index++) {
        
        ServerButtonView *buttonView = [self.viewArray objectAtIndex:index];
        buttonView.frame = CGRectMake(self.viewArray.count * MainWidth, 0, MainWidth, Get750Width(360));
        [self.scrollView addSubview:buttonView];
    }
    
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.viewArray.count, 0);
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.pageControl.currentPage = 0;
}

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

- (NSMutableArray *)viewArray {
    
    if (!_viewArray) {
        
        _viewArray = [NSMutableArray array];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger index=0; index<self.dataList.count; index++) {
            
            if (index == PAGE_NUM-1) {
                ServerButtonView *buttonView = [[ServerButtonView alloc] initWithFrame:CGRectZero];
                buttonView.clickedDelegate = self;
                buttonView.dataList = [NSArray arrayWithArray:arr];
                [_viewArray addObject:buttonView];
                
                [arr removeAllObjects];
            }
        }
    }
    
    return _viewArray;
}

#pragma mark - UIScrollView delegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width) ;
    
    self.pageControl.currentPage = index;
}

+ (CGFloat)getHeightWithIconCount:(NSInteger)iconCount {
    
    CGFloat height = 0.0f;
    
    if (iconCount == 0) {
        height = 0.0f;
    }
    else if (iconCount > 0 && iconCount <= 4) {
        height = Get750Width(188.0f);
    }
    else if (iconCount > 4 && iconCount <= 8) {
        height = Get750Width(350.0f);
    }
    else {
        height = Get750Width(390.0f);
    }
    
    return height;
}

#pragma mark --ServerButtonViewDelegate

- (void)clickedButtonAction:(RTXBapplicationInfoModel *)model {
    
    if (self.delegate) {
        [self.delegate clickedButtonAction:model];
    }
}

@end
