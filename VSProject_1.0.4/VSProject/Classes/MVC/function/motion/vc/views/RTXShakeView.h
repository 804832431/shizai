//
//  RTXShakeView.h
//  VSProject
//
//  Created by XuLiang on 15/11/14.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSView.h"
@protocol RTXShakeViewDelegate <NSObject>
//To商品详情页
- (void)toProductDetail:(NSString *)str;

@end
@interface RTXShakeView : VSView

@property (copy) void (^rtxShakeViewBlock)(RTXShakeView *shakeview);
@property (nonatomic, weak) id <RTXShakeViewDelegate> m_delegate;

-(void)openShake;
-(void)closeShake;
@end
