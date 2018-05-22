//
//  VSRemoteNotificationManager.m
//  VSProject
//
//  Created by user on 15/1/19.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSRemoteNotificationManager.h"

@implementation VSRemotePushData



@end

@implementation VSRegisterPushParm


@end

@interface VSRemoteNotificationManager ()
{
    VSRegisterPushParm *_vm_registerParm;
}

@end

@implementation VSRemoteNotificationManager

DECLARE_SINGLETON(VSRemoteNotificationManager)

//token转成NSString
- (NSString*)vs_filterPushTokenFromData:(NSData*)deviceToken
{
    NSMutableString * deviceTokenString = nil;
    if (deviceToken)
    {
        deviceTokenString = [NSMutableString stringWithString:[deviceToken description]];
        //将字符串中"<"，“>”," " 全部去掉
        [deviceTokenString replaceOccurrencesOfString:@"<" withString:@""
                                              options:0
                                                range:NSMakeRange(0, [deviceTokenString length])];
        [deviceTokenString replaceOccurrencesOfString:@">" withString:@""
                                              options:0
                                                range:NSMakeRange(0, [deviceTokenString length])];
        [deviceTokenString replaceOccurrencesOfString:@" " withString:@""
                                              options:0
                                                range:NSMakeRange(0, [deviceTokenString length])];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return deviceTokenString;
}

/*
 *  @desc:发送注册pushtoken
 *  @note:如果参数缺少调用此方法不会发送请求,
 @note:只有当用户标示和token都填充到vm_registerParm中才会发送请求
 */
- (void)vs_registerTokenToServer
{

    if(self.vm_registerParm.vm_userID.length <= 0)
    {
        DBLog(@"UID不能为空");
        return;
    }
    
    if(self.vm_registerParm.vm_pushToken.length <= 0)
    {
        DBLog(@"userPushToken不能为空");
        return;
    }

//    VSRegisterPushParm *parm = [VSRegisterPushParm createParmObj];
//
//    parm.pushtoken   = self.userPushToken;
//    parm.uid         = self.uid;

    [[self class] vs_sendAPI:@"" parm:self.vm_registerParm successBlock:^(id result, id data) {

    } failedBlock:^(id result, id data) {

    } completeBlock:nil];

    
}

//将userinfo转换成VSRemotePushData
- (VSRemotePushData *)vs_transFormUserInfo2RemoteData:(NSDictionary*)pushInfo
{
    NSDictionary *apsDict   = VSGetObjFromDict(@"aps", pushInfo, [NSDictionary class]);
    
    return [[VSRemotePushData alloc]initWithDictionary:apsDict error:nil];
    
}

#pragma mark -- getter
_GETTER_BEGIN(VSRegisterPushParm, vm_registerParm)
{
    _vm_registerParm = [VSRegisterPushParm createParmObj];
}
_GETTER_END(vm_registerParm)

@end
