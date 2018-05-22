//
//  VSRemoteNotificationManager.h
//  VSProject
//
//  Created by user on 15/1/19.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseNotificationManager.h"

@interface VSRemotePushData : VSBaseDataModel

@property(nonatomic, strong)NSString *alert;
@property(nonatomic, strong)NSString *sound;

@end

@interface VSRegisterPushParm : VSBaseParmModel

@property(nonatomic, retain)NSString *vm_pushToken; //push
@property(nonatomic, retain)NSString *vm_userID;

@end

@protocol VSRemoteNotificationManagerProtocol <NSObject>

@optional
- (void)vp_registerTokenHandle;

@end

@interface VSRemoteNotificationManager : VSBaseNotificationManager

_PROPERTY_NONATOMIC_READONLY(VSRegisterPushParm, vm_registerParm);

//token转成NSString
- (NSString*)vs_filterPushTokenFromData:(NSData*)deviceToken;

//将userinfo转换成VSRemotePushData
- (VSRemotePushData*)vs_transFormUserInfo2RemoteData:(NSDictionary*)pushInfo;

/*
 *  @desc:发送注册pushtoken
 *  @note:如果参数缺少调用此方法不会发送请求,
    @note:只有当用户标示和token都填充到vm_registerParm中才会发送请求
 */
- (void)vs_registerTokenToServer;

@end
