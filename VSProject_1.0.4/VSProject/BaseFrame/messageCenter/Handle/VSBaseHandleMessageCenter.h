//
//  VSBaseHandleMessageCenter.h
//  VSProject
//
//  ******************************************************************************
//                          消息包发送句柄
//  ******************************************************************************
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSBasePacket;
@protocol VSBaseHandleMessageCenter <NSObject>

@optional
- (void)sendPacketHandle:(VSBasePacket*)packet;

+ (instancetype)shareInstance;


@end

@interface VSBaseHandleMessageCenter : NSObject <VSBaseHandleMessageCenter>

@end
