//
//  VSTextButton.h
//  VSProject
//
//  Created by bestjoy on 15/1/23.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSView.h"
#import "VSButton.h"
#import "VSLabel.h"
@class VSTextButton;
@protocol  VSTextButtonProtocol<NSObject>
@required
- (void)addWithSelector:(VSTextButton*)vsTextButton;
@end
@interface VSTextButton : VSView
_PROPERTY_NONATOMIC_WEAK(id<VSTextButtonProtocol>, delegate);
_PROPERTY_NONATOMIC_STRONG(VSButton, button);
_PROPERTY_NONATOMIC_STRONG(VSLabel, label);
_PROPERTY_NONATOMIC_STRONG(NSString, text);
_PROPERTY_NONATOMIC_STRONG(UIImage, image);
_PROPERTY_NONATOMIC_ASSIGN(NSInteger, index);
@end
