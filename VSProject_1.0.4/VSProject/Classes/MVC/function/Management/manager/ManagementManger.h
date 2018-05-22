//
//  ManagementManger.h
//  VSProject
//
//  Created by certus on 16/3/10.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagementManger : NSObject

//请求B端页面信息接口
- (void)requestBusinessApplications:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//校验客户访问B端应用权限
- (void)requestCheckPermissonToBApplication:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//获取公司信息接口
- (void)requestCompanyInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//获取公司员工信息接口
- (void)requestCompanyEmployee:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//邀请员工加入企业
- (void)requestInviteEmployee:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//删除企业员工
- (void)requestRemoveEmployee:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//获取员工信息
- (void)requestGetEmployeeInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//更新员工信息
- (void)requestUpdateEmployeeInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//更公司信息
- (void)requestUpdateCompanyInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//注册企业
- (void)requestRegisterCompanyInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

@end
