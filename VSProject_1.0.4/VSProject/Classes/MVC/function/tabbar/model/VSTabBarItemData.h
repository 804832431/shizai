//
//  VSTabBarItemData.h
//  VSProject
//
//  Created by tiezhang on 15/2/25.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@class VSBaseViewController;
@interface VSTabBarItemData : VSBaseDataModel

_PROPERTY_NONATOMIC_STRONG(NSString, tabItemTitle);
_PROPERTY_NONATOMIC_STRONG(NSString, tabItemNormalImageName);
_PROPERTY_NONATOMIC_STRONG(NSString, tabItemSelectedImageName);
_PROPERTY_NONATOMIC_STRONG(VSBaseViewController, tabItemViewController);

- (instancetype)initWithTitle:(NSString*)title
                  normalImage:(NSString*)normalImage
                selectedImage:(NSString*)selectedImage
               viewController:(VSBaseViewController*)viewController;

@end
