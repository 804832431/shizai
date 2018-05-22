//
//  LDResisterManger.h
//  VSProject
//
//  Created by certus on 15/11/3.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDResisterViewController.h"

@interface LDResisterManger : NSObject

//请求注册
- (void)requestRegister:(LDResisterViewController *)viewController;

//请求登录
- (void)requestLogin:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//重置密码
- (void)requestForgetPassword:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//发送验证码
- (void)requestSendCaptcha:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//校验验证码
- (void)requestCheckCaptcha:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//校验接口版本
- (void)checkInterfaceVersion:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//校验当前登陆者企业身份
- (void)requestInviaterRole:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

@end
