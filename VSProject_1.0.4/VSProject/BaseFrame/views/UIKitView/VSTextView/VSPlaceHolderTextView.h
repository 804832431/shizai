//
//  VSPlaceHolderTextView.h
//  VSProject
//
//  Created by user on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSTextView.h"

@interface VSPlaceHolderTextView : VSTextView

_PROPERTY_NONATOMIC_STRONG(NSString, vm_placeHolderString);

_PROPERTY_NONATOMIC_STRONG(UIColor, vm_placeHolderColor);

@end
