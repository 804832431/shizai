//
//  ActivitiesManager.m
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ActivitiesManager.h"

@implementation ActivitiesManager


//请求精彩活动列表
- (void)requestGreatActivityList:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.activity/get-all-activities"];
    
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//请求精彩活动详情
- (void)requestGreatActivityDetail:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.activity/get-activity-detail"];
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:paraDic];
    [dict setObject:partyId forKey:@"partyId"];
    
    [RequestService requesturl:url paraDic:dict success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//报名活动
- (void)requestSignupActivity:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.activity/enroll-activity"];
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:paraDic];
    [dict setObject:partyId forKey:@"partyId"];
    
    [RequestService requesturl:url paraContentDic:dict success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//请求我的活动列表
- (void)requestMytActivityList:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.activity/get-my-activities"];
    
    NSString *partyId = [VSUserLogicManager shareInstance].userDataInfo.vm_userInfo.partyId?:@"";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:paraDic];
    [dict setObject:partyId forKey:@"partyId"];
    
    [RequestService requesturl:url paraDic:dict success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//请求政策列表
- (void)requestPolicyList:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.policy/find-policy-by-organization-id"];
    
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

@end
