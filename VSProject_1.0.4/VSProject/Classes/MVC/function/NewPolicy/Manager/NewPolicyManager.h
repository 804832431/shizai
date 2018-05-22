//
//  NewPolicyManager.h
//  VSProject
//
//  Created by apple on 11/4/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewPolicyManager : NSObject

//获取政策内容列表接口
//partyId	用户ID
//industryCode	行业编码
//areaId	区id
//publicityStatus	"公示状态，Y：已公示（历史政策）N：未公示（当前政策）"
//page	显示第几页
//row	每页显示条数
- (void)onRequestPolicyList:(NSString *)page
                        row:(NSString *)row
                    partyId:(NSString *)partyId
               industryCode:(NSString *)industryCode
                     cityId:(NSString *)cityId
                     areaId:(NSString *)areaId
            publicityStatus:(NSString *)publicityStatus
                    success:(void (^) (NSDictionary*responseObj))sResponse
                    failure:(void (^) (NSError *error))fResponse;

//收藏、取消收藏政策
//partyId = 用户Id
//policyId = 活动Id
//action : 1 = 收藏   0 = 取消收藏
- (void)onCollectPolicy:(NSString *)partyId
               policyId:(NSString *)policyId
                 action:(NSString *)action
                success:(void (^) (NSDictionary*responseObj))sResponse
                failure:(void (^) (NSError *error))fResponse;

//查询收藏活动列表接口
- (void)onRequestCollectedPolicyList:(NSString *)page
                                         row:(NSString *)row
                                     partyId:(NSString *)partyId
                                     success:(void (^) (NSDictionary*responseObj))sResponse
                                     failure:(void (^) (NSError *error))fResponse;

//信息填写接口
//partyId	客户id
//policyId	政策id
//enterpriseName	企业名称
//areaName	所属区域
//legalPerson	法人姓名
//contactPerson	联系人
//contactNumber	联系方式
- (void)onCompleteInfo:(NSString *)partyId
              policyId:(NSString *)policyId
        enterpriseName:(NSString *)enterpriseName
              areaName:(NSString *)areaName
           legalPerson:(NSString *)legalPerson
         contactPerson:(NSString *)contactPerson
         contactNumber:(NSString *)contactNumber
               success:(void (^) (NSDictionary*responseObj))sResponse
               failure:(void (^) (NSError *error))fResponse;

//查询我的政策列表接口
- (void)onRequestMyPolicyList:(NSString *)page
                          row:(NSString *)row
              publicityStatus:(NSString *)publicityStatus
                      partyId:(NSString *)partyId
                      success:(void (^) (NSDictionary*responseObj))sResponse
                      failure:(void (^) (NSError *error))fResponse;


//请求行政区划
- (void)onRequestCityAndDistrictSuccess:(void (^) (NSDictionary*responseObj))sResponse
                                failure:(void (^) (NSError *error))fResponse;

@end
