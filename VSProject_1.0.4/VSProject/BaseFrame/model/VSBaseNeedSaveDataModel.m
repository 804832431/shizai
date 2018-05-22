//
//  VSBaseNeedSaveDataModel.m
//  VSProject
//
//  Created by tiezhang on 15/2/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"
#import <objc/runtime.h>

@implementation VSBaseNeedSaveDataModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [self vs_handleProperyEnCoder:aCoder];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self vs_handleProperyDeCoder:aDecoder];
    }
    return self;
}

#pragma mark -- default action

//runtime处理属性encoder
- (void)vs_handleProperyEnCoder:(NSCoder *)aCoder
{
    //    [aCoder encodeObject:self.userLoginAccountInfo forKey:@"userLoginAccountInfo"];
    unsigned int outCount, i;
    objc_property_t *properties     = class_copyPropertyList([self class], &outCount);
    for (i=0; i<outCount; i++)
    {
        objc_property_t property    = properties[i];
        NSString * propertyName     = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        
        id propertyValue            = [self valueForKey:propertyName];
        if(propertyValue)
        {
            const char * attributes = property_getAttributes(property);
            NSString * attributeString = [NSString stringWithUTF8String:attributes];
            NSArray * attributesArray = [attributeString componentsSeparatedByString:@","];
            if ([attributesArray containsObject:@"R"])
            {
                
            }
            else
            {
                [aCoder encodeObject:propertyValue forKey:[self vs_codeKeyFromPropertyName:propertyName]];
            }
        }
    }
}

//runtime处理属性decoder
- (void)vs_handleProperyDeCoder:(NSCoder *)aDecoder
{
    //        self.userLoginAccountInfo = [aDecoder decodeObjectForKey:@"userLoginAccountInfo"];
    unsigned int outCount, i;
    objc_property_t *properties     = class_copyPropertyList([self class], &outCount);
    for (i=0; i<outCount; i++)
    {
        objc_property_t property    = properties[i];
        NSString * propertyName     = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        
        id decoderValue             = [aDecoder decodeObjectForKey:[self vs_codeKeyFromPropertyName:propertyName]];
        if(decoderValue)
        {
            const char * attributes = property_getAttributes(property);
            NSString * attributeString = [NSString stringWithUTF8String:attributes];
            NSArray * attributesArray = [attributeString componentsSeparatedByString:@","];
            if ([attributesArray containsObject:@"R"])
            {
                //只读属性暂不读取
            }
            else
            {
                [self setValue:decoderValue forKey:propertyName];
            }
        }
    }
}

//对象持久化时属性名转化成持久化key的方法 default 相同
- (NSString*)vs_codeKeyFromPropertyName:(NSString*)propertyName
{
    return propertyName;
}

#pragma mark -- VSBaseDataModelProtocol
//持久化到本地
- (void)vp_saveToLocal
{
    NSData * infoData = [NSKeyedArchiver archivedDataWithRootObject:self];
    if (infoData)
    {
        [[VSUserDefaultManager shareInstance] vs_setObject:infoData forKey:NSStringFromClass([self class])];
    }
    
}

//加载本地存储数据
+ (instancetype)vp_loadLocal
{
    id  info = nil;
    @try {
        NSData  *infoData = [[VSUserDefaultManager shareInstance] vs_objectForKey:NSStringFromClass([self class])];
        if (infoData)
        {
            info = [NSKeyedUnarchiver unarchiveObjectWithData:infoData];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@", exception);
    }
    @finally {
        
    }
    
    return info;
}


//清除缓存
- (void)vp_clear
{
    [[VSUserDefaultManager shareInstance] vs_removeObjectForKey:NSStringFromClass([self class])];
}

@end
