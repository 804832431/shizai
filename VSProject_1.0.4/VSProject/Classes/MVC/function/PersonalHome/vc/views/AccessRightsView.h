//
//  AccessRightsView.h
//  VSProject
//
//  Created by certus on 15/11/26.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSView.h"
@interface AccessRightsView : UIView

//_PROPERTY_NONATOMIC_STRONG(UIView, baseView)
_PROPERTY_NONATOMIC_STRONG(UIButton, cancelButton)
_PROPERTY_NONATOMIC_STRONG(UILabel, titleLabel)
_PROPERTY_NONATOMIC_STRONG(UILabel, subTitleLabel)
_PROPERTY_NONATOMIC_STRONG(UIImageView, mainImageView)

- (void)show;
- (void)hide;

@end
