//
//  RTXMotionLogicManager.h
//  VSProject
//
//  Created by XuLiang on 15/11/16.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseLogicManager.h"

@interface RTXMotionLogicManager : VSBaseLogicManager

//秒杀
- (void)vs_motionWithBaseModel:(Class)model success:(VSMessageHandleCallBack)success failed:(VSMessageHandleCallBack)failed;

@end
