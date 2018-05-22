//
//  VSJsonHelper.m
//  beautify
//
//  Created by user on 14/12/11.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import "VSJsonHelper.h"
#import <RegexKitLite.h>

@implementation VSJsonHelper

//将json文件读到一个对象中去
+ (id)connvertJSONFileToObj:(NSString *)fileName
{
    NSString *json_path      = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    return [self connvertJSONFilePathToObj:json_path];
}

//将json文件读到一个对象中去
+ (id)connvertJSONFilePathToObj:(NSString *)filePath
{
    if(filePath.length <= 0 ||
       [filePath Trim].length <= 0)
    {
        return nil;
    }
    
    NSData *data             = [NSData dataWithContentsOfFile:[filePath Trim]];
    NSError *error           = NULL;
    id JsonObject            = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&error];
    return JsonObject;
}

+ (id)convertJSONToDict:(NSString *)string
{
    NSData *data    = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (!data || data == nil)
    {
        return nil;
    }
    return [self convertDataToObj:data];
}

+ (id)convertDataToObj:(NSData *)data
{
    if(!data || ![data isKindOfClass:[NSData class]])
    {
        return nil;
    }
    
    else
    {
        NSError *error  = nil;
        id respDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        if (nil == error)
        {
            return respDict;
        }
        else
        {
            return nil;
        }
    }
}

+ (NSString *)convertObjectToJSON:(id)object except:(BOOL)bexcept;
{
    NSError *error  = nil;
    NSData  *data   = nil;
    if (object)
    {
        data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    }
    
    if (data == nil)
    {
        return nil;
    }
    
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if(bexcept)
    {
        jsonStr = [jsonStr stringByReplacingOccurrencesOfRegex:@"\\r*\\n*" withString:@""];
        return [jsonStr stringByReplacingOccurrencesOfRegex:@"\\+" withString:@"\\"];
    }
    else
    {
        return jsonStr;
    }
}

+ (NSString *)convertObjectToJSON:(id)object;
{
    return [self convertObjectToJSON:object except:YES];
}

+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict
{
    if(![dict isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    else
    {
        id obj = [dict objectForKey:key];
        if ([obj isKindOfClass:[NSString class]] && [obj isEqual:@""])
        {
            return nil; //空字符串
        }
        else if ([obj isKindOfClass:[NSNull class]])
        {
            return nil; //空类
        }
        else
        {
            return obj;
        }
    }
}

+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict forClass:(Class)forClass
{
    if(![dict isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    else
    {
        id obj = [dict objectForKey:key];
        if ([obj isKindOfClass:forClass])
        {
            if ([obj isKindOfClass:[NSString class]] && [obj isEqual:@""])
            {
                return nil;
            }
            else
            {
                return obj;
            }
        }
        return nil;
    }
}

+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict character:(NSCharacterSet*)character
{
    if(![dict isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    else
    {
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
}


@end
