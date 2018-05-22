//
//  LDResisterManger.m
//  VSProject
//
//  Created by certus on 15/11/3.
//  Copyright © 2015年 user. All rights reserved.
//

#import "LDResisterManger.h"
#import "AdressManger.h"
#import "BidderManager.h"
#import "AuthedEnterprise.h"

@implementation LDResisterManger


- (void)getDefaultAdress {
    
    AdressManger *admanger = [[AdressManger alloc]init];
    [admanger requestReceivingAddressed:nil success:^(NSDictionary *responseObj) {
        //
    } failure:^(NSError *error) {
        //
    }];
    
}

//请求注册
- (void)requestRegister:(LDResisterViewController *)viewController{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.account/customer-register"];
    
    [viewController vs_showLoading];
    NSDictionary *paraDic = [NSDictionary dictionaryWithObjectsAndKeys:
                             viewController.phoneTextfield.textField.text,              @"username",
                             viewController.passwordTextfield.textField.text,           @"password",
                             viewController.verificationCodeTextfield.textField.text,   @"captcha",
                             viewController.enterpriceTextfield.textField.text?viewController.enterpriceTextfield.textField.text:@"",         @"companyName",
                             nil];
    
    __weak typeof(viewController) weakController = viewController;
    __weak typeof(self) weakself = self;
    
    [viewController vs_showLoading];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        [weakController vs_hideLoadingWithCompleteBlock:nil];
        
        //自动登录
        NSString *userRegiesterPath = [LocalStorage userRegiesterPath];
        [paraDic writeToFile:userRegiesterPath atomically:YES];
        [weakself requestLogin:paraDic success:^(NSDictionary *responseObj) {
            //
            [weakController pushTagsSelect];
            
        } failure:^(NSError *error) {
            //
        }];
        
    } failure:^(NSError *error) {
        //
        [weakController.view showTipsView:[error domain]];
        [weakController vs_hideLoadingWithCompleteBlock:nil];
    }];
    
}

//请求登录
- (void)requestLogin:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.account/customer-login"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        NSError *error = nil;
        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:paraDic];
        [userDic addEntriesFromDictionary:responseObj];
        
        [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo = [[RTXUserInfoModel alloc]initWithDictionary:userDic error:&error];
        [BidderManager shareInstance].authedEnterPrise = [AuthedEnterprise new];
        [BidderManager shareInstance].authedEnterPrise.authStatus =  [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.authStatus;
        [BidderManager shareInstance].authedEnterPrise.bidder =[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.bidder;
        
        [[VSUserLogicManager shareInstance].userDataInfo vp_saveToLocal];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"requestLayout" object:nil];
        [Notification setJPushAlias];
        
        //获取默认地址
        [self getDefaultAdress];
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}


//重置密码
- (void)requestForgetPassword:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.account/forget-password"];
    
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}


//发送验证码
- (void)requestSendCaptcha:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.account/send-captcha"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
}

//校验验证码
- (void)requestCheckCaptcha:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.account/check-captcha"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
}

//校验接口版本
- (void)checkInterfaceVersion:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *dic = @{@"appVersion":appVersion};
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.account/check-app-version"];
    [RequestService requesturl:url paraDic:dic success:^(NSDictionary *responseObj) {
        
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//校验当前登陆者企业身份
- (void)requestInviaterRole:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.company/get-role-in-company"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        NSString *role = ![[responseObj objectForKey:@"role"] isEqual:[NSNull null]]?[responseObj objectForKey:@"role"]:@"";
        [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.roleInCompany = role;
        [[VSUserLogicManager shareInstance].userDataInfo.vm_userInfo vp_saveToLocal];
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

@end
