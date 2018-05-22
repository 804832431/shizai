//
//  HomeHeadLineView.m
//  VSProject
//
//  Created by apple on 12/27/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "HomeHeadLineView.h"


#define LabelFrameTop CGRectMake(12+74+12, -55, __SCREEN_WIDTH__-12-74-12-12, 55)

#define LabelFrameCenter CGRectMake(12+74+12, 0, __SCREEN_WIDTH__-12-74-12-12, 55)

#define LabelFrameBottom CGRectMake(12+74+12, 55, __SCREEN_WIDTH__-12-74-12-12, 55)


#define circleTime 5.0f


@interface HomeHeadLineView ()

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic, strong) UIButton *button2;

@property (nonatomic, strong) UIButton *cacheButton;

_PROPERTY_NONATOMIC_STRONG(NSArray, headLineList)

@property (nonatomic, assign) BOOL flagForTimer;

@property (nonatomic, assign) NSInteger currentShowTag;

@end

@implementation HomeHeadLineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setDataSource:(NSArray *)headLineList {
    self.headLineList = headLineList;
    [self setViews];
}

- (void)setViews {
    //刷新数据时先清空所有
    while (self.subviews.count)
    {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
    
    [self.layer setMasksToBounds:YES];
    [self setBackgroundColor:[UIColor whiteColor]];
    UIImageView *noticeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10.5, 74, 34)];
    [noticeImageView setContentMode:UIViewContentModeScaleToFill];
    [noticeImageView setImage:__IMAGENAMED__(@"new_img")];
    
    [self addSubview:noticeImageView];
    [self addSubview:self.button1];
    [self addSubview:self.button2];
    
    [self.button1 setTitle:((PolicyModel *)[self.headLineList objectAtIndex:0]).title forState:UIControlStateNormal];
    self.currentShowTag = 0;
    if ([self.headLineList count] > 1) {
        [self.button2 setTitle:((PolicyModel *)[self.headLineList objectAtIndex:1]).title forState:UIControlStateNormal];
        
        if (!self.flagForTimer) {
            self.flagForTimer = YES;
            [self startShow];
        }
    }
}

- (void)startShow {
    [NSTimer scheduledTimerWithTimeInterval:circleTime target:self selector:@selector(animateAction) userInfo:nil repeats:YES];
}

- (void)animateAction {
    [UIView animateWithDuration:0.35f animations:^{
        if (self.button1.frame.origin.y == 0) {
            [self.button1 setFrame:LabelFrameTop];
            [self.button2 setFrame:LabelFrameCenter];

            self.cacheButton = self.button1;
        } else if (self.button2.frame.origin.y == 0) {
            [self.button1 setFrame:LabelFrameCenter];
            [self.button2 setFrame:LabelFrameTop];

            self.cacheButton = self.button2;
        }
        
        if (self.currentShowTag >= [self.headLineList count] - 1) {
            self.currentShowTag = 0;
        } else {
            self.currentShowTag = self.currentShowTag + 1;
        }
        
        
    } completion:^(BOOL finished) {
        
        [self.cacheButton setFrame:LabelFrameBottom];

        if (self.currentShowTag >= [self.headLineList count] - 1) {
            [self.cacheButton setTitle:((PolicyModel *)[self.headLineList objectAtIndex:0]).title forState:UIControlStateNormal];
        } else {
            [self.cacheButton setTitle:((PolicyModel *)[self.headLineList objectAtIndex:self.currentShowTag + 1]).title forState:UIControlStateNormal];
        }
        //        NSLog(@"————————————————————————————————————————————————————");
        //        NSLog(@"%@",_button1.titleLabel.text);
        //        NSLog(@"%@",_button2.titleLabel.text);
        //        NSLog(@"%@",_button3.titleLabel.text);
        //        NSLog(@"%@",_button4.titleLabel.text);
    }];
}

- (void)clickNotice {
    if (_onClickHeadLineBlock) {
        _onClickHeadLineBlock([self.headLineList objectAtIndex:self.currentShowTag]);
    }
}

- (void)clickNotice2 {
    if (_onClickHeadLineBlock) {
        _onClickHeadLineBlock([self.headLineList objectAtIndex:self.currentShowTag]);
    }
}

- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [[UIButton alloc] initWithFrame:LabelFrameCenter];
        [_button1.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_button1.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [_button1 setTitleColor:_Colorhex(0x212121) forState:UIControlStateNormal];
        [_button1.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_button1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_button1 addTarget:self action:@selector(clickNotice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = [[UIButton alloc] initWithFrame:LabelFrameBottom];
        [_button2.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_button2.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [_button2 setTitleColor:_Colorhex(0x212121) forState:UIControlStateNormal];
        [_button2.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_button2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_button2 addTarget:self action:@selector(clickNotice2) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}

@end
