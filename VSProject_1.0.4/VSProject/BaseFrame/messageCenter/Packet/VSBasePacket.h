//
//  VSBasePacket.h
//  VSProject
//
//  ******************************************************************
//                      此类为消息包类型基类
//  ******************************************************************
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSMessageCenterEnum.h"

@interface VSBasePacket : NSObject

@property(nonatomic, strong)NSString        *apiUrl;        //api路径
@property(nonatomic, strong)id              packetParm;     //参数对象
@property(nonatomic, assign)VS_PACKET_TYPE  packetType;     //消息类型

@property(nonatomic, copy)VSMessageHandleCallBack completeBlock;

+ (VSBasePacket*)createPacketUrl:(NSString*)apiUrl parm:(id)parm callBack:(VSMessageHandleCallBack)callBack;

- (void)cancelFromMessageCenter;

@end
