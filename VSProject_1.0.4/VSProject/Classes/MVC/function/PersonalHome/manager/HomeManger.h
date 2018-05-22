//
//  HomeManger.h
//  VSProject
//
//  Created by certus on 15/11/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeManger : NSObject

//请求Customer布局
- (void)requestCustomerLayout:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//请求可选择应用
- (void)requestCustomerConfig:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//更新首页布局
- (void)updateCustomerLayout:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//请求城市
- (void)requestCitysAndProgects:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//请求天气
- (void)requestWeather:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

#pragma mark - V1.4

//请求C端页面信息接口
- (void)requestCustomerApplications:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;



//校验客户B端访问权限
- (void)requestCheckPermissionToB:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;



@end
