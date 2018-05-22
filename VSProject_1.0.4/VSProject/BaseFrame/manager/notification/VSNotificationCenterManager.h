//
//  VSNotificationCenter.h
//  VSProject
//
//  Created by tiezhang on 15/2/16.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseManager.h"

@interface VSNotificationCenterManager : VSBaseManager

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

//- (void)postNotification:(NSNotification *)notification;
- (void)postNotificationName:(NSString *)aName object:(id)anObject;
- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject;

@end
