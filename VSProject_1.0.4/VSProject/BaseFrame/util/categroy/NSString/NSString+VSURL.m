//
//  NSString+VSURL.m
//  VSProject
//
//  Created by user on 15/2/5.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "NSString+VSURL.h"

@implementation NSString (VSURL)

+ (NSDictionary*)dictionaryFromQuery:(NSString*)query
{
    return [self dictionaryFromQuery:query usingEncoding:NSUTF8StringEncoding];
}

+ (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding
{
    if(query.length <= 0)
    {
        return nil;
    }
    else
    {
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
        NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
        NSScanner* scanner = [[NSScanner alloc] initWithString:query];
        while (![scanner isAtEnd])
        {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            
            if(kvPair.count > 0)
            {
                if(kvPair.count == 1)
                {
                    NSString* key   = [[kvPair objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:encoding];
                    [pairs setObject:@"" forKey:key];
                }
                else if (kvPair.count == 2)
                {
                    NSString* key   = [[kvPair objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:encoding];
                    NSString* value = [[kvPair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:encoding];
                    [pairs setObject:value forKey:key];
                }
                else
                {
                    //Invalid
                }
            }
        }
        
        return [NSDictionary dictionaryWithDictionary:pairs];
    }
}

@end
