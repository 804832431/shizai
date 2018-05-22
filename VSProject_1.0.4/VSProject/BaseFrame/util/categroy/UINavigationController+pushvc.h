//
//  UINavigationController+pushvc.h
//  beautify
//
//  Created by user on 14/12/26.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (pushvc)

- (UIViewController*)vs_pushToDesVCExcept:(UIViewController*)desVC;

@end
