//
//  VSUserLogicManager.m
//  VSProject
//
//  Created by tiezhang on 15/1/31.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSUserLogicManager.h"

@implementation VSUserLogicManager

DECLARE_SINGLETON(VSUserLogicManager)

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self vs_loadUserData];
    }
    return self;
}

- (void)vs_saveUserData
{
    [self.userDataInfo vp_saveToLocal];
}

- (void)vs_loadUserData
{
    [self userDataInfo];
}

#pragma mark -- action
//登陆
- (void)vs_login:(VSUserLoginParm*)loginParm success:(VSMessageHandleCallBack)success failed:(VSMessageHandleCallBack)failed
{
    [[self class] vs_sendAPI:[SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.account/customer-login/version/1.2.0"] parm:loginParm successBlock:success failedBlock:failed completeBlock:nil];
}

- (void)vs_checkPermission:(VSUserLoginParm*)parm model:(Class)model success:(VSMessageHandleCallBack)success failed:(VSMessageHandleCallBack)failed{
    [[self class]vs_sendAPI:[SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.customerlayout/check-permission-to-b"] parm:parm responseObjClass:model successBlock:success failedBlock:failed completeBlock:nil];
}

//客户B端首页，获取请求时的项目ID可用的B端应用
- (void)vs_getApplicationsForB:(RTXOrganizationParm*)parm model:(Class)model success:(VSMessageHandleCallBack)success failed:(VSMessageHandleCallBack)failed{
    [[self class]vs_sendAPI:[SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.application/get-applications-for-b"] parm:parm responseObjClass:model successBlock:success failedBlock:failed completeBlock:nil];
}

- (void)vs_getApplicationsForB:(RTXOrganizationParm*)parm success:(VSMessageHandleCallBack)success failed:(VSMessageHandleCallBack)failed{
    [[self class]vs_sendAPI:[SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.application/get-applications-for-b"] parm:parm successBlock:success failedBlock:failed completeBlock:nil];
}
#pragma mark -- getter
_GETTER_BEGIN(VSUserDataInfo, userDataInfo)
{
    _userDataInfo = [VSUserDataInfo vp_loadLocal];
    if(!_userDataInfo)
    {
        _userDataInfo = _ALLOC_OBJ_(VSUserDataInfo);
    }
}
_GETTER_END(userDataInfo)

@end
