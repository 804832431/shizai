//
//  VSUserLogicManager.h
//  VSProject
//
//  Created by tiezhang on 15/1/31.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseLogicManager.h"
#import "VSUserDataInfo.h"
#import "VSUserRegisterParm.h"
#import "VSUserLoginParm.h"
#import "UserPartyidAccountParm.h"
#import "RTXOrganizationParm.h"
#import "RTXBapplicationsModel.h"

@interface VSUserLogicManager : VSBaseLogicManager


_PROPERTY_NONATOMIC_STRONG(VSUserDataInfo, userDataInfo);

//登陆
- (void)vs_login:(VSUserLoginParm*)loginParm success:(VSMessageHandleCallBack)success failed:(VSMessageHandleCallBack)failed;

//用户是否有访问B端权限
- (void)vs_checkPermission:(UserPartyidAccountParm*)parm model:(Class)model success:(VSMessageHandleCallBack)success failed:(VSMessageHandleCallBack)failed;

//客户B端首页，获取请求时的项目ID可用的B端应用
- (void)vs_getApplicationsForB:(RTXOrganizationParm*)parm model:(Class)model success:(VSMessageHandleCallBack)success failed:(VSMessageHandleCallBack)failed;

//不解析－－客户B端首页，获取请求时的项目ID可用的B端应用
- (void)vs_getApplicationsForB:(RTXOrganizationParm*)parm success:(VSMessageHandleCallBack)success failed:(VSMessageHandleCallBack)failed;
@end








