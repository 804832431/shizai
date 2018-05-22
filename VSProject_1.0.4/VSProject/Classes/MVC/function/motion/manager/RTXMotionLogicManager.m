//
//  RTXMotionLogicManager.m
//  VSProject
//
//  Created by XuLiang on 15/11/16.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXMotionLogicManager.h"

@implementation RTXMotionLogicManager

DECLARE_SINGLETON(RTXMotionLogicManager)

- (void)vs_motionWithBaseModel:(Class)model success:(VSMessageHandleCallBack)success failed:(VSMessageHandleCallBack)failed{
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.product/random-product"];
    [[self class] vs_sendAPI:url parm:nil responseObjClass:model successBlock:success failedBlock:failed completeBlock:nil];
}

@end
