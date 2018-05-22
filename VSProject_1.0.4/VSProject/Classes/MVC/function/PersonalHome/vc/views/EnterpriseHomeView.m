//
//  EnterpriseHomeView.m
//  VSProject
//
//  Created by 姚君 on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//
#define RADIUS 200.0
#define BTNWIDTH    36
#define PHOTONUM 20
#define TAGSTART 1000
#define TIME 2.5
#define SCALENUMBER 1.25
NSInteger array [PHOTONUM][PHOTONUM] = {
    {0,1,2,3,4},
    {4,0,1,2,3},
    {3,4,0,1,2},
    {2,3,4,0,1},
    {1,2,3,4,0}
};
CATransform3D rotationTransform1[PHOTONUM];

#import "EnterpriseHomeView.h"
#import "VSNavigationViewController.h"
#import "VSUserLoginViewController.h"
#import "EFItemView.h"

@interface EnterpriseHomeView()<EFItemViewDelegate>
{
    float radius;
}
@property (nonatomic, strong)UIView * AppsView;//放置apps
@property (nonatomic, strong)UIImageView * businessCircleImg;
@property (nonatomic, strong)UIImageView * businessImagebg;
@property (nonatomic, assign)NSInteger currentTag;
@property (nonatomic, strong)NSArray    *dataArray;
@end
@implementation EnterpriseHomeView
@synthesize dataArray;
- (void)vp_setInit {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.businessImagebg];//背景
    [self addSubview:self.businessCircleImg];//转圈View
    [self addSubview:self.AppsView];//appsView
//    [self addSubview:self.navigation];//navigation

}
- (void)vp_updateUIWithModel:(id)model{
    if ([model isKindOfClass:[RTXBapplicationsModel class]]) {
        for (UIView *tempview in self.AppsView.subviews) {
            [tempview removeFromSuperview];
        }
        //绘制B端
        RTXBapplicationsModel *dataModel = (RTXBapplicationsModel *)model;
        dataArray = dataModel.applications;
        //
//        dataArray = @[@"", @"", @"", @"", @"",@"", @"", @"", @""];
        
        CGFloat centery = CGRectGetMaxY(_businessCircleImg.frame)-26;
        CGFloat centerx = CGRectGetMaxX(_businessCircleImg.frame)-22;
        for (NSInteger i = 0;i < PHOTONUM;i++) {
            CGFloat tmpy =  centery + radius*cos(2.0*M_PI *i/PHOTONUM);
            CGFloat tmpx =	centerx - radius*sin(2.0*M_PI *i/PHOTONUM);
            //        CGFloat tmpy =  centery - RADIUS*cos(-2.0*M_PI *i/PHOTONUM);
            //        CGFloat tmpx =	centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
            NSString *appIcon = nil;
            NSString *appName = nil;
//            if ((dataArray.count > i) && [dataArray[i] isKindOfClass:[RTXBapplicationInfoModel class]]) {
                RTXBapplicationInfoModel *appInfo = (RTXBapplicationInfoModel *)dataArray[i%10];
                appIcon = appInfo.appIcon;
                appName = appInfo.appName;
//            }
            EFItemView *view = [[EFItemView alloc] initWithNormalImage:appIcon highlightedImage:nil tag:TAGSTART+i title:nil];
            
            view.frame = CGRectMake(0.0, 0.0,BTNWIDTH,BTNWIDTH);
            view.center = CGPointMake(tmpx,tmpy);
            view.delegate = self;
            rotationTransform1[i] = CATransform3DIdentity;
            
            CGFloat Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
            if (Scalenumber < 0.3) {
                Scalenumber = 0.4;
            }
            [self.AppsView addSubview:view];
        }
        self.currentTag = TAGSTART;
    }
}
#pragma mark - EFItemViewDelegate

- (void)didTapped:(NSInteger)index {
    
    if (self.currentTag  == index-3) {
        NSLog(@"自定义处理事件");
    NSUInteger tag = index - TAGSTART;
    if (tag > dataArray.count) {
        return;
    }
    if ((dataArray.count > tag) && [dataArray[tag] isKindOfClass:[RTXBapplicationInfoModel class]]) {
        RTXBapplicationInfoModel *appInfo = (RTXBapplicationInfoModel *)dataArray[tag];
        
        if (_delegate && [_delegate respondsToSelector:@selector(homeB:didTappApp:)]) {
            [_delegate homeB:self didTappApp:appInfo];
        }
    }
        return;
    }
    
    NSInteger t = [self getIemViewTag:index];
    
    for (NSInteger i = 0;i<PHOTONUM;i++ ) {
        
        UIView *view = [self viewWithTag:TAGSTART+i];
        //旋转动画
        [view.layer addAnimation:[self moveanimation:TAGSTART+i number:t] forKey:@"position"];
    }
    self.currentTag  = index;
}
- (CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num {
    // CALayer
    UIView *view = [self viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,view.layer.position.x,view.layer.position.y);
    
    NSInteger p =  [self getIemViewTag:tag];
    CGFloat f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
    CGFloat h = f + 2.0*M_PI *num/PHOTONUM;
    CGFloat centery = CGRectGetMaxY(_businessCircleImg.frame)-26;
    CGFloat centerx = CGRectGetMaxX(_businessCircleImg.frame)-22;
    CGFloat tmpy =  centery + radius*cos(h);
    CGFloat tmpx =	centerx - radius*sin(h);
    //    CGFloat tmpy =  centery - RADIUS*cos(-2.0*M_PI *p/PHOTONUM);
    //    CGFloat tmpx =	centerx - RADIUS*sin(2.0*M_PI *p/PHOTONUM);
    view.center = CGPointMake(tmpx,tmpy);
    
    CGPathAddArc(path,nil,centerx, centery,radius,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);
    animation.path = path;
    CGPathRelease(path);
    animation.duration = TIME;
    animation.repeatCount = 1;
    animation.calculationMode = kCAAnimationCubicPaced;
    return animation;
}

- (NSInteger)getIemViewTag:(NSInteger)tag {
    
    if (self.currentTag >tag){
        return self.currentTag  - tag;
    } else {
        return PHOTONUM  - tag + self.currentTag ;
    }
}


#pragma mark -- getter


_GETTER_ALLOC_BEGIN(UIImageView, businessCircleImg) {
    _businessCircleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BHome_circle"]];
    CGFloat imgwidth = CGRectGetWidth(_businessCircleImg.frame);
    CGFloat imgheight = CGRectGetHeight(_businessCircleImg.frame);
    CGFloat imgnewWidth = CGRectGetWidth(self.frame)-50;
    radius = imgnewWidth - BTNWIDTH -22-30;
    CGFloat imgnewHeight = imgnewWidth *imgheight/imgwidth;
    _businessCircleImg.frame = CGRectMake(CGRectGetWidth(self.frame) - imgnewWidth, CGRectGetHeight(self.frame) - imgnewHeight, imgnewWidth, imgnewHeight);
}
_GETTER_END(businessCircleImg)

_GETTER_ALLOC_BEGIN(UIImageView, businessImagebg) {
    _businessImagebg.image = [UIImage imageNamed:@"BHome_bg"];
    _businessImagebg.frame = self.bounds;
}
_GETTER_END(businessImagebg)

_GETTER_ALLOC_BEGIN(UIView, AppsView) {
    _AppsView.backgroundColor = kColor_Clear;
    _AppsView.frame = self.bounds;
}
_GETTER_END(AppsView)

@end
