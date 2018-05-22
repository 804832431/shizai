//
//  EditNameView.h
//  VSProject
//
//  Created by certus on 15/11/4.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSView.h"

@class EditNameView;
@protocol EditNameDelegate <NSObject>

- (void)EditNameView:(EditNameView *)editNameView sureEditName:(NSString *)name;

@end

@interface EditNameView : VSView

_PROPERTY_NONATOMIC_STRONG(UIView, baseView)
_PROPERTY_NONATOMIC_STRONG(UITextField, textField)
_PROPERTY_NONATOMIC_STRONG(UIButton, cancelButton)
_PROPERTY_NONATOMIC_STRONG(UIButton, sureButton)
_PROPERTY_NONATOMIC_STRONG(UILabel, titleLabel)
@property (nonatomic,assign)id<EditNameDelegate> delegate;

- (void)show;
- (void)hide;

@end
