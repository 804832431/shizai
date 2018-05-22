//
//  VSBaseHttpPacket.m
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseHttpPacket.h"

@implementation VSBaseHttpPacket

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.methodType = VS_HTTPMETHOD_GET;
    }
    return self;
}

@end
