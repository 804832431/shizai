//
//  VSHandleMessageCenterFactory.h
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSMessageCenterEnum.h"
#import "VSTcpHandleMessageCenter.h"
#import "VSUdpHandleMessageCenter.h"
#import "VSHttpHandleMessageCenter.h"
#import "VSHttpsHandleMessageCenter.h"

@class VSBaseHandleMessageCenter;
@interface VSHandleMessageCenterFactory : NSObject

+ (VSBaseHandleMessageCenter*)createHandleMessageCenterByType:(VS_PACKET_TYPE)packetType;

@end
