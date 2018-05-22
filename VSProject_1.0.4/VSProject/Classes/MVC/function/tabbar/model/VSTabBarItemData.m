//
//  VSTabBarItemData.m
//  VSProject
//
//  Created by tiezhang on 15/2/25.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSTabBarItemData.h"

@implementation VSTabBarItemData

- (instancetype)initWithTitle:(NSString*)title
                  normalImage:(NSString*)normalImage
                selectedImage:(NSString*)selectedImage
               viewController:(VSBaseViewController*)viewController
{
    self = [super init];
    if(self)
    {
        self.tabItemTitle               = title;
        self.tabItemNormalImageName     = normalImage;
        self.tabItemSelectedImageName   = selectedImage;
        self.tabItemViewController      = viewController;
    }
    return self;
}

@end
