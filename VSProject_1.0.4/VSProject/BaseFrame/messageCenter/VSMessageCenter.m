//
//  MessageCenter.m
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSMessageCenter.h"
#import "VSHandleMessageCenterFactory.h"
#import "VSBasePacket.h"

@implementation VSMessageCenter

DECLARE_SINGLETON(VSMessageCenter)

- (void)vs_sendPacket:(VSBasePacket *)packet
{
    //根据消息类型生产对应的处理句柄
    VSBaseHandleMessageCenter *baseHandleMessageCenter = [[VSHandleMessageCenterFactory class] createHandleMessageCenterByType:packet.packetType];
    
    //根据对应的处理句柄执行
    [baseHandleMessageCenter sendPacketHandle:packet];
    
}

@end
