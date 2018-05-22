//
//  RTXReadyPayAlertView.h
//  VSProject
//
//  Created by XuLiang on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTXReadyPayAlertViewDelegate <NSObject>

@end

@interface RTXReadyPayAlertView : UIView
{
    UIView *_coverView;
    UIView *_alertView;
    NSString *_title;
    NSString *_message;

}
@property (nonatomic, weak) id<RTXReadyPayAlertViewDelegate> delegate;
@property (copy) void (^cancelBlock)(RTXReadyPayAlertView *alertView);
@property (copy) void (^confirmBlock)(RTXReadyPayAlertView *alertView);
@property (nonatomic, strong) UIViewController *viewController;

- (instancetype)initWithTitle:(NSString *)title BaseController:(UIViewController *)viewController message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle;

- (void)show;
- (void)dismiss;
- (NSString *)getMoney;
@end
