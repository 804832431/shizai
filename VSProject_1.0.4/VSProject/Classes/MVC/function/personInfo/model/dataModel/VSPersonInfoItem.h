//
//  VSPersonInfoItem.h
//  VSProject
//
//  Created by tiezhang on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface VSPersonInfoItem : VSBaseDataModel

_PROPERTY_NONATOMIC_STRONG(NSString, vm_title);

_PROPERTY_NONATOMIC_STRONG(NSString, vm_value);

_PROPERTY_NONATOMIC_ASSIGN(BOOL, vm_hasValue);

- (instancetype)initWithTitle:(NSString*)title value:(NSString*)value;

@end
