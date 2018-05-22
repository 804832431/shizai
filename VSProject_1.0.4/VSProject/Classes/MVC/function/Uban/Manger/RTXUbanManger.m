//
//  RTXUbanManger.m
//  VSProject
//
//  Created by certus on 16/3/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RTXUbanManger.h"

@implementation RTXUbanManger

//房源信息登记接口
- (void)requestSubmitRental:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.ubanrental/submit-uban-rental"];
    [RequestService requesturl:url paraContentDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//查看某个房源的看房记录信息
- (void)getMyUbanRentalInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.ubanrental/get-my-uban-rental-info"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        //房租租赁
        NSNumber *hasUnreadFWZL = [responseObj objectForKey:@"hasUnread"];
        [VSUserLogicManager shareInstance].userDataInfo.vm_hasUnreadFWZL = hasUnreadFWZL.boolValue;
        [[VSUserLogicManager shareInstance].userDataInfo vp_saveToLocal];

        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//我的优办租房获取已发布的租房信息
- (void)getShowHistory:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.ubanrental/get-show-history"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//获取所有房源信息接口
- (void)getAllUbanRentalInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.ubanrental/get-all-uban-rental-info"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}
//获取房源详情
- (void)getUbanRentalDetail:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.ubanrental/get-uban-rental-detail"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}
@end
