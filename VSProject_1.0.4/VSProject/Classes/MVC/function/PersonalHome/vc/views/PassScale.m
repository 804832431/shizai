//
//  PassScale.m
//  safekeeping
//
//  Created by Minr on 14-11-25.
//  Copyright (c) 2014年 Minr. All rights reserved.
//

#import "PassScale.h"
#import "ApplicationBView.h"

// 控件原始大小
#define kWidth 475

// 遮挡距离大小
#define kMaskLen 50

@implementation PassScale
{
    UIImageView *_scaleView;  // 轮盘视图
    CGPoint _oldPoint;  // 初始化点
    CGFloat _angle;  // 当前角度
    int _scale; // 轮盘刻度
    NSMutableArray *appViewArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        appViewArray = [NSMutableArray array];
        
    }
    return self;
}

#pragma mark -初始化UI

- (void)buildApplications {
    
    for (int i=0; i < _dataList.count; i++) {
    RTXBapplicationInfoModel *model = [_dataList objectAtIndex:i];
        
        ApplicationBView *appView = [[ApplicationBView alloc]initWithFrame:CGRectMake(160, 160, APPRADIUS*0.14, APPRADIUS*0.14)];
        appView.center = [self calcCircleCoordinateWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) andWithAngle:(360*(i+1)/_dataList.count+90) andWithRadius:APPRADIUS-APPRADIUS*0.33];
        appView.backgroundColor = [UIColor clearColor];
        [self addSubview:appView];
        CGFloat radiangle = [self getRadian:(360*(i+1)/_dataList.count)];
        CGAffineTransform startAngleForm = CGAffineTransformMakeRotation(-radiangle);
        appView.appBgImageView.transform = startAngleForm;

        [appViewArray addObject:appView];
        
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",model.appIcon,@"_ios_unfocus.png"];
        [appView.appBgImageView sd_setImageWithString:imagePath placeholderImage:[UIImage imageNamed:@"syjz_ios_l"]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionGridItem:)];
        tap.numberOfTapsRequired = 1;
        appView.tag = i;
        [appView addGestureRecognizer:tap];
        
    }
    [self setAppHightlight];
}

-(CGPoint)calcCircleCoordinateWithCenter:(CGPoint)center andWithAngle:(CGFloat)angle andWithRadius:(CGFloat)radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}
#pragma mark -手势处理
// 触碰开始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];

        _oldPoint = point;

}

// 移动手势
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch * touch = [touches anyObject];
    
    // 设置相对坐标系
    CGPoint pNew = [touch locationInView:self];

    CGFloat angle = [self degreeWithPoint:_oldPoint withNew:pNew withCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];

    _oldPoint = pNew;
    [self setAngle:angle+_angle];
    
    // 旋转刻度盘
    [self round:_angle view:_scaleView];
    [self setAppHightlight];
    
}

- (void)setAppHightlight {
    CGPoint center = [self calcCircleCoordinateWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) andWithAngle:(360/_dataList.count+90) andWithRadius:APPRADIUS-APPRADIUS*0.4];
    CGRect rect = CGRectMake(center.x-APPRADIUS*0.15, center.y-APPRADIUS*0.15, APPRADIUS*0.15, APPRADIUS*0.15);
    
    for (int i=0; i < _dataList.count; i++) {
        
        ApplicationBView *appview = [appViewArray objectAtIndex:i];
        RTXBapplicationInfoModel *model = [_dataList objectAtIndex:i];
        if (CGRectIntersectsRect(rect, appview.frame)) {
            NSString *imagePath = [NSString stringWithFormat:@"%@%@",model.appIcon,@"_ios_focus.png"];
            [appview.appBgImageView sd_setImageWithString:imagePath placeholderImage:[UIImage imageNamed:@"syjz_ios_l"]];
            
            if (_delegate && [_delegate respondsToSelector:@selector(setAppHightlight:index:)]) {
                [_delegate setAppHightlight:model index:i];
            }
        }else {
            NSString *imagePath = [NSString stringWithFormat:@"%@%@",model.appIcon,@"_ios_unfocus.png"];
            [appview.appBgImageView sd_setImageWithString:imagePath placeholderImage:[UIImage imageNamed:@"syjz_ios_l"]];
        }
    }
}

- (void)actionGridItem:(UIGestureRecognizer *)ges {
    NSUInteger index = ges.view.tag;
    RTXBapplicationInfoModel *model = [_dataList objectAtIndex:index];

    if (_delegate && [_delegate respondsToSelector:@selector(didSelectApp:index:)]) {
        [_delegate didSelectApp:model index:index];
    }
}
#pragma mark -工具函数

// 设置当前角度
- (void)setAngle:(CGFloat)angle{
    
    _angle = angle;
    
    // 获得0～360间准确角度
    if (_angle >= 360) {
        _angle -= 360;
    }else if (_angle <= 0)
    {
        _angle += 360;
    }

}

// 任意角度循环旋转函数
- (void)round:(CGFloat)angle view:(UIView *)view {
    
    // 得到旋转角度的弧度
    CGFloat radiangle = [self getRadian:angle];
    CGAffineTransform startAngleForm = CGAffineTransformMakeRotation(radiangle);
    
    for (ApplicationBView *appBView in appViewArray) {
        [self correctAnchorPointForView:appBView];
        appBView.transform = startAngleForm;
    }

}

- (void)correctAnchorPointForView:(UIView *)view
{
    CGPoint anchorPoint = CGPointZero;
    CGPoint superviewCenter = view.superview.center;
    //   superviewCenter是view的superview 的 center 在view.superview.superview中的坐标。
    CGPoint viewPoint = [view convertPoint:superviewCenter fromView:view.superview.superview];
    //   转换坐标，得到superviewCenter 在 view中的坐标
    anchorPoint.x = (viewPoint.x) / view.bounds.size.width;
    anchorPoint.y = (viewPoint.y) / view.bounds.size.height;
    
    [self setAnchorPoint:anchorPoint forView:view];
}
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

// 通过角度获得弧度
- (CGFloat)getRadian:(float)angle{
    return angle*M_PI/180;
}

// 通过三点确定角度
- (CGFloat)degreeWithPoint:(CGPoint)pOld withNew:(CGPoint)pNew withCenter:(CGPoint)pCen{
    
    CGFloat kO = (pOld.y - pCen.y)/(pOld.x - pCen.x);
    CGFloat kN = (pNew.y - pCen.y)/(pNew.x - pCen.x);
    
    CGFloat tanAngle = (kN - kO) / (1 + kN*kO);
    
    // 斜率为0判断
    if(isnan(tanAngle))
    {
        tanAngle = 0;
    }

    // 在此处我们仅在90度内精准，
    CGFloat angle = atanf(tanAngle) / M_PI * 180;
    
    return angle;
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
