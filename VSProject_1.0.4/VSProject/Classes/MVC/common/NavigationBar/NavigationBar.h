//
//  NavigationBar.h
//  VSProject
//
//  Created by certus on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBar : UIView

_PROPERTY_NONATOMIC_STRONG(UIButton, buttonLeft1)
_PROPERTY_NONATOMIC_STRONG(UIButton, buttonLeft2)
_PROPERTY_NONATOMIC_STRONG(UIButton, buttonRight1)
_PROPERTY_NONATOMIC_STRONG(UIButton, buttonRight2)
_PROPERTY_NONATOMIC_STRONG(UIButton, titleUIButton)

- (id)initWithNavigationTitle:(NSString *)title buttonLeft1:(NSString *)left1Name buttonLeft2:(NSString *)left2Name buttonRight1:(NSString *)right1Name buttonRight2:(NSString *)right2Name;

@end
