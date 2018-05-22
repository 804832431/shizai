//
//  VSBaseHttpPacket.h
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBasePacket.h"
#import "VSMessageCenterEnum.h"

@interface VSBaseHttpPacket : VSBasePacket

@property(nonatomic, assign)VS_HTTPMETHOD methodType;       //default VS_HTTPMETHOD_GET

@end
