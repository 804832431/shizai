//
//  MECircleView.m
//  Zhyq
//
//  Created by zhangtie on 14-8-29.
//  Copyright (c) 2014年 zhangtie. All rights reserved.
//

#import "MECircleView.h"

@implementation MECircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.cpercent = 1.0;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    CGFloat lineWidth = 2.0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 26.0/255.0, 78.0/255.0, 149.0/255.0f,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, lineWidth);//线的宽度
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, rect.size.width/2, rect.size.height/2, MIN(rect.size.width/2, rect.size.height/2) - lineWidth, -1 * M_PI_2, (2*M_PI * self.cpercent - M_PI_2), 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
    CGContextSetRGBStrokeColor(context, 244.0/255.0, 244.0/255.0, 244.0/255.0f,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, lineWidth);//线的宽度
    CGContextAddArc(context, rect.size.width/2, rect.size.height/2, MIN(rect.size.width/2, rect.size.height/2) - lineWidth, (2*M_PI * self.cpercent - M_PI_2), 2*M_PI - M_PI_2, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
//    //填充圆，无边框
//    CGContextAddArc(context, 150, 30, 30, 0, 2*M_PI, 0); //添加一个圆
//    CGContextDrawPath(context, kCGPathFill);//绘制填充
//    
//    //画大圆并填充颜
//    UIColor*aColor = [UIColor colorWithRed:1 green:0.0 blue:0 alpha:1];
//    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
//    CGContextSetLineWidth(context, 3.0);//线的宽度
//    CGContextAddArc(context, 250, 40, 40, 0, 2*M_PI, 0); //添加一个圆
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
//    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充

}

- (void)setCpercent:(CGFloat)cpercent
{
    if(_cpercent != cpercent)
    {
        _cpercent = cpercent;
        [self setNeedsDisplay];
    }
}

@end
