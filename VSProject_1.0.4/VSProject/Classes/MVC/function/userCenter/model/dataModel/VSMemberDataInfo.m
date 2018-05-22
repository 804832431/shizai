//
//  VSMemberDataInfo.m
//  VSProject
//
//  Created by tiezhang on 15/1/13.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSMemberDataInfo.h"

@interface VSMemberDataInfo ()

_PROPERTY_NONATOMIC_STRONG(NSString, vm_userToken); //访问api需要的token

@end

@implementation VSMemberDataInfo


- (BOOL)isLogined
{
    return YES;
}


//是否是会员
- (BOOL)isVip
{
    return (self.vm_vipType != VIP_TYPE_NONE);
}

@end
