//
//  VSUserDataInfo.m
//  VSProject
//
//  Created by tiezhang on 15/1/13.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSUserDataInfo.h"

@implementation VSUserDataInfo

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

//是否登录
- (BOOL)vs_isLogined
{
    return [self.vm_memberData isLogined];
}

//是否是会员
- (BOOL)vs_isVip
{
    return [self.vm_memberData isVip];
}


@end
