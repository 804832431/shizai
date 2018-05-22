//
//  UIButton+NMCategory.m
//  DragButtonDemo
//
//  Created by Aster0id on 14-5-16.
//
//

#import "UIButton+NMCategory.h"
#import <objc/runtime.h>
#define PADDING     5
static void *DragEnableKey = &DragEnableKey;
static void *AdsorbEnableKey = &AdsorbEnableKey;

@implementation UIButton (NMCategory)


-(void)setDragEnable:(BOOL)dragEnable
{
    objc_setAssociatedObject(self, DragEnableKey,@(dragEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isDragEnable
{
    return [objc_getAssociatedObject(self, DragEnableKey) boolValue];
}

-(void)setAdsorbEnable:(BOOL)adsorbEnable
{
    objc_setAssociatedObject(self, AdsorbEnableKey,@(adsorbEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isAdsorbEnable
{
    return [objc_getAssociatedObject(self, AdsorbEnableKey) boolValue];
}

CGPoint beginPoint;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = YES;
    if (![objc_getAssociatedObject(self, DragEnableKey) boolValue]) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    
    beginPoint = [touch locationInView:self];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
    if (![objc_getAssociatedObject(self, DragEnableKey) boolValue]) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint nowPoint = [touch locationInView:self];
    
    float offsetX = nowPoint.x - beginPoint.x;
    float offsetY = nowPoint.y - beginPoint.y;
    
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.highlighted) {
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
        self.highlighted = NO;
    }
    
    if (self.superview && [objc_getAssociatedObject(self,AdsorbEnableKey) boolValue] && self.superview.tag == 10001) {
        
        [self topButtondidEndMove:self];
        
    }else if (self.superview && [objc_getAssociatedObject(self,AdsorbEnableKey) boolValue] && self.superview.tag == 10002) {
    
        [self bottomButtondidEndMove];
    }
}

- (void)topButtondidEndMove:(UIButton *)movedButton {//上部分button移动结束

    CGPoint centerPoint = movedButton.center;//计算位置
    if (centerPoint.x < GirdItemPadLeft1+GirdItemWidth/2) {
        centerPoint.x = GirdItemPadLeft1;
    }else {
        centerPoint.x = GirdItemPadLeft2;
    }
    int index = (int)(centerPoint.y-PageTop) / PointGap;
    if ((index%2 == FirstLeft && centerPoint.x == GirdItemPadLeft2)||(index%2 == !FirstLeft && centerPoint.x == GirdItemPadLeft1)) {
        index ++;
    }else if (index < 0) {
        index = 0;
    }else if (index > 23) {
        index = 23;
    }
    centerPoint.y = PointGap*index+PageTop;
    [UIView animateWithDuration:0.125 animations:^(void){
        movedButton.center = centerPoint;
    }];
    for (UIButton *btton in movedButton.superview.subviews) {//位置重复，之前的按钮去掉
        if (btton.center.x == centerPoint.x && btton.center.y == centerPoint.y && ![btton isEqual:movedButton]) {
            float multiply = 1+btton.center.y/movedButton.superview.frame.size.height;//放大
            btton.frame = CGRectMake(0, 0, GirdItemWidth*multiply, GirdItemWidth*multiply);
            btton.center = centerPoint;
            [UIView animateWithDuration:multiply*0.3 animations:^(void){
                btton.frame = CGRectMake(MainWidth/2, 0, 0, 0);
            }completion:^(BOOL finished) {
                [btton removeFromSuperview];
            }];
        }
    }

}

- (void)bottomButtondidEndMove {
    
    if (self.center.y < 0) {
        for (UIView *scroll in self.superview.superview.superview.subviews) {
            if (scroll.tag == 10001) {//复制button到上方区域
                UIButton *gridItem = [[UIButton alloc] initWithFrame:CGRectMake(5, 100,GirdItemWidth, GirdItemWidth)];
                gridItem.backgroundColor = [UIColor whiteColor];
                gridItem.layer.cornerRadius = GirdItemRadius;
                [gridItem setDragEnable:YES];
                [gridItem setAdsorbEnable:YES];
                gridItem.center = CGPointMake(self.center.x+ScrollPadLeft, self.center.y+ScrollPadTop-60);//转换坐标徐
                gridItem.tag = self.tag;
                [scroll addSubview:gridItem];
                [self topButtondidEndMove:gridItem];
                
                NSLog(@"view");
            }
        }
    }
    
    CGPoint centerPoint = self.center;//底下button归位
    centerPoint.y = 50;
    centerPoint.x = (BottomGirdItemWidth+BottomGirdItemGap/2)*(self.tag-100)+BottomGirdItemWidth/2;
    [UIView animateWithDuration:0.125 animations:^(void){
        self.center = centerPoint;
    }];

}
@end
