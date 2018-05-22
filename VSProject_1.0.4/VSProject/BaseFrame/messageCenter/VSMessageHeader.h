//
//  VSMessageHeader.h
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

#define vs_messageheader_key_content_type       @"Content-Type"

#define vs_messageheader_default_content_type   @"application/x-www-form-urlencoded"
#define vs_messageheader_json_content_type      @"application/json"

@interface VSMessageHeader : NSObject

@property(nonatomic, readonly)NSDictionary *headers;

+ (VSMessageHeader*)shareInstance;

//设置header
- (void)setHeaderValue:(NSString*)value key:(NSString*)key;


@end
