//
//  MessageCenter.h
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSBasePacket;
@interface VSMessageCenter : NSObject

+ (VSMessageCenter*)shareInstance;

- (void)vs_sendPacket:(VSBasePacket*)packet;

@end
