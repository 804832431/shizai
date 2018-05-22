//
//  UIView+ShowTips.m
//  beautify
//
//  Created by user on 14/12/19.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import "UIView+ShowTips.h"

@implementation UIView (ShowTips)

- (MBProgressHUD*)showTipsCustomView:(UIView*)tipsView
                          afterDelay:(NSTimeInterval)delay
                       completeBlock:(MBProgressHUDCompletionBlock)completeBlock
{
    return [self showTipsCustomView:tipsView afterDelay:delay raduis:2 completeBlock:completeBlock];
}

- (MBProgressHUD*)showTipsCustomView:(UIView*)tipsView
                          afterDelay:(NSTimeInterval)delay
                              raduis:(CGFloat)raduis
                       completeBlock:(MBProgressHUDCompletionBlock)completeBlock
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.completionBlock = completeBlock;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = tipsView;
    hud.margin = 10.f;
    hud.yOffset = 0.0;
    hud.cornerRadius = raduis;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:delay];
    
    return hud;
}

- (MBProgressHUD*)showTipsView:(NSString *)tips
{
    return [self showTipsView:tips afterDelay:1.5];
}

- (MBProgressHUD*)showTipsView:(NSString *)tips
                    afterDelay:(NSTimeInterval)delay
{
    return [self showTipsView:tips afterDelay:delay completeBlock:nil];
}

- (MBProgressHUD*)showTipsView:(NSString *)tips
                    afterDelay:(NSTimeInterval)delay
                 completeBlock:(MBProgressHUDCompletionBlock)completeBlock
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.completionBlock = completeBlock;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = tips;
    hud.margin = 10.f;
    hud.yOffset = 0.0;
    hud.cornerRadius = 2;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:delay];
    
    return hud;
}

- (void)hideAllTipsForView
{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}

@end
