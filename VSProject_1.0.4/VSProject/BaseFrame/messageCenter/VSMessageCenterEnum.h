//
//  VSMessageCenterEnum.h
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#ifndef VSProject_VSMessageCenterEnum_h
#define VSProject_VSMessageCenterEnum_h

//消息包类型
typedef enum _VS_PACKET_TYPE
{
    PACKET_TYPE_INVALID     = -1,
    
    PACKET_TYPE_HTTP,       //http消息
    
    PACKET_TYPE_HTTPS,      //https消息
    
    PACKET_TYPE_TCP,        //tcp-socket消息
    
    PACKET_TYPE_UDP,        //udp-socket消息
    
    PACKET_TYPE_MAX,
    
}VS_PACKET_TYPE;

//http类型
typedef enum _VS_HTTPMETHOD
{
    VS_HTTPMETHOD_GET,
    VS_HTTPMETHOD_POST,
    VS_HTTPMETHOD_INPUT,
    VS_HTTPMETHOD_DELETE,
    
}VS_HTTPMETHOD;

typedef void(^VSMessageHandleCallBack)(id result, id data);

#endif
