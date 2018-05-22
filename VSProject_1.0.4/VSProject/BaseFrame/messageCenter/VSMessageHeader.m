//
//  VSMessageHeader.m
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSMessageHeader.h"

@interface VSMessageHeader ()

@property(nonatomic, strong)NSMutableDictionary *headerMap;

@end

@implementation VSMessageHeader

DECLARE_SINGLETON(VSMessageHeader)

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setHeaderValue:vs_messageheader_default_content_type key:vs_messageheader_key_content_type];
    }
    return self;
}

- (void)setHeaderValue:(NSString*)value key:(NSString*)key
{
    if(value && key)
    {
        [self.headerMap setObject:value forKey:key];
    }
}

#pragma mark -- getter
- (NSMutableDictionary*)headerMap
{
    if(!_headerMap)
    {
        _headerMap = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    
    return _headerMap;
}

- (NSDictionary*)headers
{
    return self.headerMap;
}

@end
