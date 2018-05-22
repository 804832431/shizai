//
//  VSBaseHttpManager.h
//  VSProject
//
//  ****************************************************************************
//                      此manager用于http网络交互
//  ****************************************************************************
//
//  Created by tiezhang on 15/1/12.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseManager.h"
#import "VSMessageCenterEnum.h"
#import "VSResultData.h"

#define kerror_message      @"服务器异常"

@interface VSBaseHttpManager : VSBaseManager

/**
 *  HTTP发送请求API
 *
 *  @param apiUrl 接口地址
 *  @param parm   参数对象
 *  @param successed, failed , completed 分别为成功，失败，完成回调
 *  @note  完成回调不会进行成功逻辑判断，请求出去肯定会执行一次
 */
+ (void)vs_sendAPI:(NSString*)apiUrl
              parm:(VSBaseParmModel*)parm
      successBlock:(VSMessageHandleCallBack)successed
       failedBlock:(VSMessageHandleCallBack)failed
     completeBlock:(VSMessageHandleCallBack)completed;

+ (void)vs_sendAPI:(NSString*)apiUrl
              parm:(VSBaseParmModel*)parm
        httpMethod:(VS_HTTPMETHOD)method
      successBlock:(VSMessageHandleCallBack)successed
       failedBlock:(VSMessageHandleCallBack)failed
     completeBlock:(VSMessageHandleCallBack)completed;

/**
 *  HTTP发送请求API
 *
 *  @param apiUrl 接口地址
 *  @param parm   参数对象
 *  @param responseObjClass 返回对象的类
 *  @param successed, failed , completed 分别为成功，失败，完成回调
 *  @note  完成回调不会进行成功逻辑判断，请求出去肯定会执行一次
 */
+ (void)vs_sendAPI:(NSString*)apiUrl
              parm:(VSBaseParmModel*)parm
  responseObjClass:(Class)responseObjClass
      successBlock:(VSMessageHandleCallBack)successed
       failedBlock:(VSMessageHandleCallBack)failed
     completeBlock:(VSMessageHandleCallBack)completed;

+ (void)vs_sendAPI:(NSString*)apiUrl
              parm:(VSBaseParmModel*)parm
        httpMethod:(VS_HTTPMETHOD)method
  responseObjClass:(Class)responseObjClass
      successBlock:(VSMessageHandleCallBack)successed
       failedBlock:(VSMessageHandleCallBack)failed
     completeBlock:(VSMessageHandleCallBack)completed;

/**
 *  HTTP发送请求API,但返回的数据是xml格式
 *
 *  @param apiUrl 接口地址
 *  @param parm   参数对象
 *  @param successed, failed 分别为成功，失败
 *  @note  返回的数据格式是xml格式,直接返回成功或者失败
 */
+ (void)vs_sendXMLAPI:(NSString*)apiUrl
                 parm:(VSBaseParmModel*)parm
         successBlock:(VSMessageHandleCallBack)successed
          failedBlock:(VSMessageHandleCallBack)failed;

/**
 *  HTTP发送请求API,但返回的数据是json格式
 
 *  @note  返回的数据格式是xml格式,直接返回成功或者失败
 */
+ (void)vs_sendJSONAPI:(NSString*)apiUrl
                  parm:(VSBaseParmModel*)parm
          successBlock:(VSMessageHandleCallBack)successed
           failedBlock:(VSMessageHandleCallBack)failed;
@end
