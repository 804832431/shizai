//
//  VSFindItemData.h
//  VSProject
//
//  Created by tiezhang on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface VSFindItemData : VSBaseDataModel

_PROPERTY_NONATOMIC_STRONG(NSString, vm_iconName);

_PROPERTY_NONATOMIC_STRONG(NSString, vm_title);

_PROPERTY_NONATOMIC_STRONG(NSString, vm_desc);

- (instancetype)initWithIconName:(NSString*)iconName title:(NSString*)title desc:(NSString*)desc;

@end
