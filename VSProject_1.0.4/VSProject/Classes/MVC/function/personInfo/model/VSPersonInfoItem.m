//
//  VSPersonInfoItem.m
//  VSProject
//
//  Created by tiezhang on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSPersonInfoItem.h"

@implementation VSPersonInfoItem

- (instancetype)initWithTitle:(NSString*)title value:(NSString*)value
{
    self = [super init];
    if(self)
    {
        self.vm_title = title;
        self.vm_value = value;
        
        self.vm_hasValue = YES;
    }
    
    return self;
}

@end
