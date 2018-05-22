//
//  UIAlertView+SimpleAlert.h
//  VSProject
//
//  Created by user on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (SimpleAlert)

+ (void)vs_simpleAlertTitle:(NSString*)title message:(NSString*)msg okAction:(void(^)(void))okBlock cancelAction:(void(^)(void))cancelBlock;

@end
