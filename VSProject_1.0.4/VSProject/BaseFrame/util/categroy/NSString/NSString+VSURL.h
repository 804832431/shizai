//
//  NSString+VSURL.h
//  VSProject
//
//  Created by user on 15/2/5.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VSURL)

+ (NSDictionary*)dictionaryFromQuery:(NSString*)query;  //default utf8

+ (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding;

@end
