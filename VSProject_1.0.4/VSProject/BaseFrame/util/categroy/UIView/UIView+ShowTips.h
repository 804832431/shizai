//
//  UIView+ShowTips.h
//  beautify
//  ********************************************************************************
//                          tips提示扩展
//  使用示例:
//  [view showTipsView:@"提示语" afterDelay:kTipsSuccessInterval completeBlock:^{
//       NSLog(@"隐藏回调");
//  }]
//  ********************************************************************************
//  
//  Created by user on 14/12/19.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

#define kTipsSuccessInterval            1.5f

#define kTipsFailedInterval             1.5f

@interface UIView (ShowTips)

- (MBProgressHUD*)showTipsCustomView:(UIView*)tipsView
                          afterDelay:(NSTimeInterval)delay
                       completeBlock:(MBProgressHUDCompletionBlock)completeBlock;

- (MBProgressHUD*)showTipsCustomView:(UIView*)tipsView
                          afterDelay:(NSTimeInterval)delay
                              raduis:(CGFloat)raduis
                       completeBlock:(MBProgressHUDCompletionBlock)completeBlock;

- (MBProgressHUD*)showTipsView:(NSString *)tips;

- (MBProgressHUD*)showTipsView:(NSString *)tips
                    afterDelay:(NSTimeInterval)delay;

- (MBProgressHUD*)showTipsView:(NSString *)tips
                    afterDelay:(NSTimeInterval)delay
                 completeBlock:(MBProgressHUDCompletionBlock)completeBlock;

- (void)hideAllTipsForView;

@end
