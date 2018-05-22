//
//  BCNetWorkTool.h
//  BeautyCat
//
//  Created by helloworld on 15-3-27.
//  Copyright (c) 2015年 chuangzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


//成功回调
typedef  void(^SuccessCallBackBlock)(id callBackData);
//失败回调
typedef  void(^FailCallBackBlock)(id callBackData);

typedef  void(^FailWithCodeCallBackBlock)(NSString* errorCode,id callBackData);

@interface BCNetWorkTool : NSObject

//开始监听网络状态
+ (void)checkNetworkStatus;

//get方法调用网络访问方法
+ (void)executeGETNetworkWithParameter:(NSDictionary *)parameter andUrlIdentifier:(NSString *)urlIdentifier withSuccess:(SuccessCallBackBlock)successBlock orFail:(FailCallBackBlock)failBlock;


//post方法调用网络访问方法
+ (void)executePostNetworkWithParameter:(NSDictionary *)parameter andUrlIdentifier:(NSString *)urlIdentifier withSuccess:(SuccessCallBackBlock)successBlock orFail:(FailCallBackBlock)failBlock;

@end
