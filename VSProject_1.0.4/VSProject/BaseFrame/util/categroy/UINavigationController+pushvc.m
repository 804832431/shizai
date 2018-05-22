//
//  UINavigationController+pushvc.m
//  beautify
//
//  Created by user on 14/12/26.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import "UINavigationController+pushvc.h"

@implementation UINavigationController (pushvc)

- (UIViewController*)vs_pushToDesVCExcept:(UIViewController*)desVC
{
    if([self.topViewController isKindOfClass:[desVC class]])
    {
        return self.topViewController;
    }
    
    NSArray *vcs = self.viewControllers;
    for (UIViewController *vc in vcs)
    {
        if([vc isKindOfClass:[desVC class]])
        {
            [self popToViewController:vc animated:YES];
            
            return vc;
        }
    }
    
    [self pushViewController:desVC animated:YES];
    
    return desVC;
}

@end
