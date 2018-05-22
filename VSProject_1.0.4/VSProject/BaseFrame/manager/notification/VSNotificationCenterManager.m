//
//  VSNotificationCenter.m
//  VSProject
//
//  Created by tiezhang on 15/2/16.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSNotificationCenterManager.h"

@interface VSNotificationCenterManager ()

_PROPERTY_NONATOMIC_STRONG(NSNotificationCenter, vm_defaultNotificationCenter);

@end

@implementation VSNotificationCenterManager

DECLARE_SINGLETON(VSNotificationCenterManager)

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
    [self.vm_defaultNotificationCenter addObserver:observer selector:aSelector name:aName object:anObject];
}

//- (void)postNotification:(NSNotification *)notification;
- (void)postNotificationName:(NSString *)aName object:(id)anObject
{
    [self.vm_defaultNotificationCenter postNotificationName:anObject object:anObject];
}

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo
{
    [self.vm_defaultNotificationCenter postNotificationName:anObject object:anObject userInfo:aUserInfo];
}

- (void)removeObserver:(id)observer
{
    [self.vm_defaultNotificationCenter removeObserver:observer];
}

- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject
{
    [self.vm_defaultNotificationCenter removeObserver:observer name:aName object:anObject];
}

#pragma mark -- getter
_GETTER_BEGIN(NSNotificationCenter, vm_defaultNotificationCenter)
{
    _vm_defaultNotificationCenter = [NSNotificationCenter defaultCenter];
}
_GETTER_END(vm_defaultNotificationCenter)

@end
