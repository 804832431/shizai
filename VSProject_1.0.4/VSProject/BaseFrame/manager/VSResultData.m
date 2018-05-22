//
//  VSResultData.m
//  VSProject
//
//  Created by tiezhang on 15/1/12.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSResultData.h"

@implementation VSResultData

+ (VSResultData*)createResultDataMessage:(NSString*)message resultCode:(NSString*)code
{
    VSResultData *resultData = [[[self class] alloc]init];
    resultData.message       = message;
    resultData.resultCode    = code;
    
    return resultData;
}

- (BOOL)bsuccess
{
    return [self.resultCode isEqualToString:@"1"];
}

- (NSString*)message
{
    if(_message.length > 0)
    {
        return _message;
    }
    else
    {
        return @"网络异常";
    }
}

@end
