//
//  VSHandleMessageCenterFactory.m
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSHandleMessageCenterFactory.h"

@implementation VSHandleMessageCenterFactory

+ (VSBaseHandleMessageCenter*)createHandleMessageCenterByType:(VS_PACKET_TYPE)packetType
{
    VSBaseHandleMessageCenter *retHandle = nil;
    switch (packetType)
    {
        case PACKET_TYPE_HTTP:
        {
            retHandle = [VSHttpHandleMessageCenter shareInstance];
        }break;
        case PACKET_TYPE_HTTPS:
        {
            retHandle = [VSHttpsHandleMessageCenter shareInstance];
        }break;
        case PACKET_TYPE_TCP:
        {
            retHandle = [VSTcpHandleMessageCenter shareInstance];
        }break;
        case PACKET_TYPE_UDP:
        {
            retHandle = [VSUdpHandleMessageCenter shareInstance];
        }break;
        case PACKET_TYPE_INVALID:
        case PACKET_TYPE_MAX:
        {
            retHandle = nil;
        }break;
        default:
            break;
    }
    
    return retHandle;
}

@end


