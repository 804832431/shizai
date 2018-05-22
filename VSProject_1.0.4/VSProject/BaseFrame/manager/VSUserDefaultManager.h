//
//  VSUserDefaultManager.h
//  VSProject
//
//  ****************************************************************************
//                      此manager用于管理项目的userdefault
//  ****************************************************************************
//
//  Created by user on 15/1/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseManager.h"

@interface VSUserDefaultManager : VSBaseManager

#pragma mark -- property
//demo
@property(nonatomic, strong)NSString *vsm_strTest;


#pragma mark -- action
- (id)vs_objectForKey:(NSString*)akey;

- (void)vs_setObject:(id)obj forKey:(NSString*)aKey;

- (void)vs_removeObjectForKey:(NSString*)aKey;

@end
