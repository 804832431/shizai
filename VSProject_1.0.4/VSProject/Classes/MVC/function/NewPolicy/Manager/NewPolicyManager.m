//
//  NewPolicyManager.m
//  VSProject
//
//  Created by apple on 11/4/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "NewPolicyManager.h"

@implementation NewPolicyManager

//获取政策内容列表接口
- (void)onRequestPolicyList:(NSString *)page
                        row:(NSString *)row
                    partyId:(NSString *)partyId
               industryCode:(NSString *)industryCode
                     cityId:(NSString *)cityId
                     areaId:(NSString *)areaId
            publicityStatus:(NSString *)publicityStatus
                    success:(void (^) (NSDictionary*responseObj))sResponse
                    failure:(void (^) (NSError *error))fResponse {
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.policy/get-policy-list/version/1.6.0"];
    
    NSDictionary *paraDic = [[NSDictionary alloc] initWithObjectsAndKeys:page,@"page",row,@"row",partyId,@"partyId",industryCode,@"industryCode",cityId,@"cityId",areaId,@"areaId",publicityStatus,@"publicityStatus",nil];
    
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
}

//收藏、取消收藏政策
- (void)onCollectPolicy:(NSString *)partyId
               policyId:(NSString *)policyId
                 action:(NSString *)action
                success:(void (^) (NSDictionary*responseObj))sResponse
                failure:(void (^) (NSError *error))fResponse {
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.policy/collect-policy/version/1.2.2"];
    
    NSDictionary *paraDic = [[NSDictionary alloc] initWithObjectsAndKeys:partyId,@"partyId",policyId,@"policyId",action,@"action",nil];
    
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
}

//查询收藏活动列表接口
- (void)onRequestCollectedPolicyList:(NSString *)page
                                 row:(NSString *)row
                             partyId:(NSString *)partyId
                             success:(void (^) (NSDictionary*responseObj))sResponse
                             failure:(void (^) (NSError *error))fResponse {
//    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.policy/get-my-collect-policy/version/1.2.2"];
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.policy/get-my-collect-policy/version/1.6.0"];
    
    NSDictionary *paraDic = [[NSDictionary alloc] initWithObjectsAndKeys:page,@"page",row,@"row",partyId,@"partyId",nil];
    
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
}

//信息填写
- (void)onCompleteInfo:(NSString *)partyId
              policyId:(NSString *)policyId
        enterpriseName:(NSString *)enterpriseName
              areaName:(NSString *)areaName
           legalPerson:(NSString *)legalPerson
         contactPerson:(NSString *)contactPerson
         contactNumber:(NSString *)contactNumber
               success:(void (^) (NSDictionary*responseObj))sResponse
               failure:(void (^) (NSError *error))fResponse {
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.policy/apply-policy/version/1.2.2"];
    
    NSDictionary *paraDic = [[NSDictionary alloc] initWithObjectsAndKeys:partyId,@"partyId",
                             policyId,@"policyId",
                             enterpriseName,@"enterpriseName",
                             areaName,@"areaName",
                             legalPerson,@"legalPerson",
                             contactPerson,@"contactPerson",
                             contactNumber,@"contactNumber",
                             nil];
    
    [RequestService requesturl:url paraContentDic:paraDic success:^(NSDictionary *responseObj) {
        sResponse(responseObj);
    } failure:^(NSError *error) {
        fResponse(error);
    }];
}

////查询我的政策列表接口
- (void)onRequestMyPolicyList:(NSString *)page
                          row:(NSString *)row
              publicityStatus:(NSString *)publicityStatus
                      partyId:(NSString *)partyId
                      success:(void (^) (NSDictionary*responseObj))sResponse
                      failure:(void (^) (NSError *error))fResponse {
//    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.policy/get-my-policy-list/version/1.2.2"];
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.policy/get-my-policy-list/version/1.6.0"];
    
    NSDictionary *paraDic = [[NSDictionary alloc] initWithObjectsAndKeys:publicityStatus,@"publicityStatus",page,@"page",row,@"row",partyId,@"partyId",nil];
    
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
}

//请求行政区划
- (void)onRequestCityAndDistrictSuccess:(void (^) (NSDictionary*responseObj))sResponse
                                failure:(void (^) (NSError *error))fResponse {
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.policy/get-area-list/version/1.6.0"];
    
    [RequestService requesturl:url paraDic:nil success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
}

@end
