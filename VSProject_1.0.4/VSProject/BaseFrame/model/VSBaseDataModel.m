//
//  VSBaseDataMode.m
//  VSProject
//
//  Created by user on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"
#import <objc/runtime.h>

@implementation VSBaseDataModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
//    [super encodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (BOOL)vs_copyWithOther:(VSBaseDataModel *)other
{
    if([other isKindOfClass:[self class]])
    {
        unsigned int outCount, i;
        objc_property_t *properties     = class_copyPropertyList([self class], &outCount);
        for (i=0; i<outCount; i++)
        {
            objc_property_t property    = properties[i];
            NSString * propertyName     = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
            
            const char * attributes = property_getAttributes(property);
            NSString * attributeString = [NSString stringWithUTF8String:attributes];
            NSArray * attributesArray = [attributeString componentsSeparatedByString:@","];
            if ([attributesArray containsObject:@"R"])
            {
                //只读属性暂不读取
            }
            else
            {
                NSString *otherVal = [other valueForKey:propertyName];
                [self setValue:otherVal  forKey:propertyName];
            }

        }
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
