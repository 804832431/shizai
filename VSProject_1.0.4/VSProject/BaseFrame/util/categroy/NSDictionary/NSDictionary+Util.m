//
//  NSDictionary+Util.m
//  VSProject
//
//  Created by tiezhang on 15/4/19.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "NSDictionary+Util.h"

@implementation NSDictionary (Util)


- (id)vs_getElementForKey:(id)key fromDict:(NSDictionary *)dict
{
    if(![dict isKindOfClass:[NSDictionary class]])
        return nil;
    
    id obj = [dict objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] && [obj isEqual:@""]) {
        return nil; //空字符串
    } else if ([obj isKindOfClass:[NSNull class]]) {
        return nil; //空类
    }
    return obj;
}

- (id)vs_getElementForKey:(id)key fromDict:(NSDictionary *)dict forClass:(Class)forClass
{
    if(![dict isKindOfClass:[NSDictionary class]])
        return nil;
    
    id obj = [dict objectForKey:key];
    if ([obj isKindOfClass:forClass]) {
        if ([obj isKindOfClass:[NSString class]] && [obj isEqual:@""]) {
            return nil;
        } else {
            return obj;
        }
    }
    return nil;
}

- (id)vs_getElementForKey:(id)key fromDict:(NSDictionary *)dict character:(NSCharacterSet*)character
{
    if(![dict isKindOfClass:[NSDictionary class]])
        return nil;
    
    id obj = [dict objectForKey:key];
    if ([obj isKindOfClass:[NSString class]])
    {
        if (!obj || [obj isEqual:@""])
        {
            return nil;
        }
        else
        {
            if(character)
            {
                return [obj stringByTrimmingCharactersInSet:character];
            }
            return obj;
        }
    }
    else if ([obj isKindOfClass:[NSNull class]])
    {
        return nil; //空类
    }
    return obj;
}

//过滤字典中的空数据
- (id)vs_filterDictionary:(NSDictionary *)dictionary {
    
    NSMutableDictionary *filterDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    NSArray *allKeys = [dictionary allKeys];
    for (NSString *key in allKeys) {
        NSObject *obj = [dictionary objectForKey:key];
        if (![obj isEqual:[NSNull null]]) {
            [filterDictionary setObject:obj forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:filterDictionary];
}

- (NSInteger)intValue:(NSString*)path {
    return [self intValue:path default:0];
}

- (long)longValue:(NSString*)path
{
    return [self longValue:path default:0];
}

- (float)floatValue:(NSString*)path
{
    return [self floatValue:path default:0.0];
}

- (NSString*)strValue:(NSString*)path {
    return [self strValue:path default:@""];
}

- (NSInteger)intValue:(NSString*)path default:(NSInteger)defValue {
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj intValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj intValue];
    else
        return defValue;
}

- (long)longValue:(NSString*)path default:(long)defValue
{
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj longValue];
    else if ([obj isKindOfClass:[NSString class]])
        return (long)[(NSString*)obj longLongValue];
    else
        return defValue;
}

- (float)floatValue:(NSString*)path default:(float)defValue
{
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj floatValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj floatValue];
    else
        return defValue;
}

- (NSString*)strValue:(NSString*)path default:(NSString*)defValue {
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj stringValue];
    else if ([obj isKindOfClass:[NSString class]])
        return (NSString*)obj;
    else
        return defValue;
}

-(NSArray *) arrayValue :(NSString *) path
{
    NSObject* obj = [self valueForKeyPath:path];
    if(obj && [obj isKindOfClass:[NSArray class]])
    {
        return (NSArray *)obj;
    }
    return nil;
}

@end
