//
//  VSUserDefaultManager.m
//  VSProject
//
//  Created by user on 15/1/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSUserDefaultManager.h"

#define kvs_userdefault_test    @"test"

@interface VSUserDefaultManager ()

_PROPERTY_NONATOMIC_STRONG(NSUserDefaults, userDefault);

@end

@implementation VSUserDefaultManager

DECLARE_SINGLETON(VSUserDefaultManager)


#pragma mark -- property
- (NSString*)vsm_strTest
{
    return [self.userDefault objectForKey:kvs_userdefault_test];
}

- (void)setVsm_strTest:(NSString *)vsm_strTest
{
    [self vs_setObject:vsm_strTest forKey:kvs_userdefault_test];
}


- (void)vs_synchronize
{
    [self.userDefault synchronize];
}


#pragma mark -- action
- (id)vs_objectForKey:(NSString*)akey
{
    if(akey)
    {
        return [self.userDefault objectForKey:akey];
    }
    else
    {
        NSAssert(0, @"key为nil");
        return nil;
    }
}

- (void)vs_setObject:(id)obj forKey:(NSString*)aKey
{
    if(!obj)
    {
        NSAssert(0, @"obj不能为nil");
        if(!aKey)
        {
            NSAssert(0, @"key不能为nil");
        }

        [self.userDefault removeObjectForKey:aKey];
        [self vs_synchronize];
    }
    else
    {
        if(!aKey)
        {
            NSAssert(0, @"key不能为nil");
        }
        else
        {
            @try {
                [self.userDefault setObject:obj forKey:aKey];
                [self vs_synchronize];
            }
            @catch (NSException *exception) {
                DBLog(@"%@", exception);
            }
            @finally {
                DBLog(@"%@", @"aaaa");
            }

        }
    }
}

- (void)vs_removeObjectForKey:(NSString*)akey
{
    if(akey)
    {
        [self.userDefault removeObjectForKey:akey];
        [self vs_synchronize];
    }
    else
    {
        NSAssert(0, @"key为nil");
    }
}

#pragma mark -- getter
- (NSUserDefaults*)userDefault
{
    //    if(!_vs_userDefault)
    {
        _userDefault = [NSUserDefaults standardUserDefaults];
    }
    return _userDefault;
}


@end
