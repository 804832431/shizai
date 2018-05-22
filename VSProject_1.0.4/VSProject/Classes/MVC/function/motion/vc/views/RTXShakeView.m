//
//  RTXShakeView.m
//  VSProject
//
//  Created by XuLiang on 15/11/14.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXShakeView.h"
#import "RTXRandomProductInfoModel.h"
#import "RTXMotionCouponView.h"

#define TOMIDDISTANCE     57
@interface RTXShakeView()
{
    BOOL isShake;
    NSString *detailUrlStr;
}
@property (nonatomic, strong) UIView      *m_midView;
@property (nonatomic, strong) UIImageView *m_giftView;
@property (nonatomic, strong) UIImageView *m_endBg;//摇一摇成功后背景
@property (nonatomic, strong) UIImageView *m_topBg;
@property (nonatomic, strong) UIImageView *m_bottomBg;
@property (nonatomic, strong) UIImageView *m_topPhone;
@property (nonatomic, strong) UIImageView *m_bottomPhone;
@property (nonatomic, strong) UIImageView *m_tipview;

@property (nonatomic, strong)RTXMotionCouponView *m_couponView;

@end
@implementation RTXShakeView
@synthesize m_delegate;

+ (CGFloat)vp_height{

    return  100.0f;
}

- (void)vp_setInit{
    [super vp_setInit];
    [self m_giftView];
    [self m_midView];
    [self m_endBg];
    [self m_topBg];
    [self m_bottomBg];
    [self setBackgroundColor:kColor_b2b2b2];
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 80, 50)];
//    [btn setTitle:@"摇一摇" forState:UIControlStateNormal];
//    [btn setBackgroundColor:[UIColor brownColor]];
//    [btn addTarget:self action:@selector(shakeTest) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btn];
}

- (void)vp_updateUIWithModel:(id)model{
    //切换秒杀
    if ([model isKindOfClass:[RTXRandomProductInfoModel class]]) {
        RTXRandomProductInfoModel *infoModel = (RTXRandomProductInfoModel *)model;
        detailUrlStr = infoModel.detailUrl;
        [self setViewWithState:0];
        [self m_couponView];
        _m_couponView.hidden = NO;
        [_m_couponView vp_updateUIWithModel:model];
    }else{
        _m_couponView.hidden = YES;
        [self setViewWithState:1];
    }
    
    
}
- (void)setViewWithState:(NSInteger)tag{
    if (tag == 0) {
        //摇到了
        self.m_topBg.hidden = YES;
        self.m_bottomBg.hidden = YES;
        self.m_endBg.hidden = NO;
    }else{
        self.m_topBg.hidden = NO;
        self.m_bottomBg.hidden = NO;
        self.m_endBg.hidden = YES;
    }
}
#pragma mark --publlic
-(void)openShake{
    self.rtxShakeViewBlock(self);
    _m_couponView.hidden = YES;
    self.m_topBg.hidden = NO;
    self.m_bottomBg.hidden = NO;
    self.m_endBg.hidden = YES;
    CGFloat duration = 0.4;
    [UIView animateWithDuration:duration animations:^{
        [_m_topBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(-TOMIDDISTANCE));
        }];
        [_m_bottomBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(TOMIDDISTANCE));

        }];
    }];
    
}
-(void)closeShake{
    CGFloat duration = 0.4;
    
    [UIView animateWithDuration:duration animations:^{
        _m_couponView.hidden = NO;
        [_m_topBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
        }];
        [_m_bottomBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(0));
            
        }];
    }];
    
}

#pragma mark --
-(void)shakeTest{
    [self openShake];
}



#pragma mark -- getter

_GETTER_ALLOC_BEGIN(UIView, m_midView)
{
    [self addSubview:_m_midView];
    _m_midView.layer.borderWidth = 1.5f;
    _m_midView.layer.borderColor = kColor_717171.CGColor;
    [_m_midView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(@(0));
        make.centerX.equalTo(@(0));
        make.height.equalTo(@(TOMIDDISTANCE * 2));
        make.leading.equalTo(@(-2));
        make.trailing.equalTo(@(2));
        
    }];
}
_GETTER_END(m_midView)

_GETTER_ALLOC_BEGIN(UIImageView, m_giftView)
{
    self.m_giftView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake_gift"]];
    [self addSubview:_m_giftView];
    CGFloat imgWidth = CGRectGetWidth(self.m_giftView.frame);
    CGFloat imgHeight = CGRectGetHeight(self.m_giftView.frame);
    [_m_giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(@(0));
        make.centerX.equalTo(@(0));
        make.height.equalTo(@(imgHeight));
        make.width.equalTo(@(imgWidth));
        
    }];
}
_GETTER_END(m_giftView)

_GETTER_ALLOC_BEGIN(UIImageView, m_endBg)
{
    self.m_endBg= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake_middle"]];
    [self addSubview:_m_endBg];
    CGFloat imgWidth = CGRectGetWidth(self.m_endBg.frame);
    CGFloat imgHeight = CGRectGetHeight(self.m_endBg.frame);
    
    _m_endBg.hidden = YES;
    [_m_endBg mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = __SCREEN_HEIGHT__;
        CGFloat width = height * imgWidth/imgHeight;
        make.height.equalTo(@(height));
        make.width.equalTo(@(width));
        make.centerY.equalTo(@(64));
        make.centerX.equalTo(@(0));
        
    }];
}
_GETTER_END(m_endBg)

_GETTER_ALLOC_BEGIN(UIImageView, m_topBg)
{
    [self addSubview:_m_topBg];
    _m_topBg.image = [UIImage imageNamed:@"shake_topBg"];
    [_m_topBg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(@(0));
        CGFloat topBgheight = __SCREEN_HEIGHT__/2;
        make.height.equalTo(@(topBgheight));
        
    }];
    [self m_topPhone];
}
_GETTER_END(m_topBg)

_GETTER_ALLOC_BEGIN(UIImageView, m_bottomBg)
{
    [self addSubview:_m_bottomBg];
    _m_bottomBg.image = [UIImage imageNamed:@"shake_bottomBg"];
    [_m_bottomBg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        CGFloat topBgheight = __SCREEN_HEIGHT__/2;
        make.height.equalTo(@(topBgheight));
        
    }];
    [self m_bottomPhone];
    [self m_tipview];
}
_GETTER_END(m_bottomBg)

_GETTER_BEGIN(UIImageView, m_topPhone)
{
    self.m_topPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake_topPhone"]];
    CGFloat imgWidth = CGRectGetWidth(self.m_topPhone.frame);
    CGFloat imgHeight = CGRectGetHeight(self.m_topPhone.frame);
    [self.m_topBg addSubview:_m_topPhone];
    [_m_topPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(imgWidth));
        make.height.equalTo(@(imgHeight));
        make.centerX.equalTo(@(0));
        make.bottom.equalTo(@(0));
        
    }];
}
_GETTER_END(m_topPhone)

_GETTER_BEGIN(UIImageView, m_bottomPhone)
{
    self.m_bottomPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake_bottomPhone"]];
    CGFloat imgWidth = CGRectGetWidth(self.m_bottomPhone.frame);
    CGFloat imgHeight = CGRectGetHeight(self.m_bottomPhone.frame);
    [self.m_bottomBg addSubview:_m_bottomPhone];
    [_m_bottomPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(imgWidth));
        make.height.equalTo(@(imgHeight));
        make.centerX.equalTo(@(0));
        make.top.equalTo(@(0));
        
    }];
}
_GETTER_END(m_bottomPhone)

_GETTER_BEGIN(UIImageView, m_tipview)
{
    self.m_tipview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake_tip"]];
    CGFloat imgWidth = CGRectGetWidth(self.m_tipview.frame);
    CGFloat imgHeight = CGRectGetHeight(self.m_tipview.frame);
    [self.m_bottomBg addSubview:_m_tipview];
    [_m_tipview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(imgWidth));
        make.height.equalTo(@(imgHeight));
        make.centerX.equalTo(@(0));
        make.centerY.equalTo(@(0));
        
    }];
}
_GETTER_END(m_tipview)

_GETTER_BEGIN(RTXMotionCouponView, m_couponView)
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RTXMotionCouponView" owner:self options:nil];
    _m_couponView = [nib objectAtIndex:0];
    [self addSubview:_m_couponView];
    [_m_couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(10));
        make.trailing.equalTo(@(-10));
        make.height.equalTo(@(110));
        make.bottom.equalTo(@(-60));
        
    }];
    [self vs_addTapGuesture];
}
_GETTER_END(m_couponView)

#pragma mark -- gesture
- (UITapGestureRecognizer*)vs_addTapGuesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
    tap.numberOfTapsRequired    = 1;
    tap.cancelsTouchesInView    = NO;
    [_m_couponView addGestureRecognizer:tap];
    
    return tap;
}
- (void)doTap:(UITapGestureRecognizer*)sender
{
    //防暴力点击
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(jumpProductDetail) object:sender];
    [self performSelector:@selector(jumpProductDetail) withObject:sender afterDelay:0.5f];
    
}
-(void)jumpProductDetail{
    if([m_delegate respondsToSelector:@selector(toProductDetail:)]){
        [m_delegate toProductDetail:detailUrlStr];
    }
}
@end
