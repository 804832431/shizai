//
//  VSFindItemData.m
//  VSProject
//
//  Created by tiezhang on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSFindItemData.h"

@implementation VSFindItemData

- (instancetype)initWithIconName:(NSString*)iconName title:(NSString*)title desc:(NSString*)desc
{
    self = [super init];
    
    if(self)
    {
        self.vm_desc = desc;
        self.vm_title = title;
        self.vm_iconName = iconName;
    }
    
    return self;
}

@end
