
//
//  NotificationAgentManger.m
//  VSProject
//
//  Created by certus on 16/4/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NotificationAgentManger.h"

@implementation NotificationAgentManger

//获取我的预约待办
- (void)requestGetReservationByStatus:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.reservation/get-reservations-by-status"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//查看预约待办详情
- (void)requestGetReservationDetail:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.reservation/get-reservation-detail"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}
//取消预约
- (void)requestCancelReservation:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse{
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.reservation/cancel-reservation"];
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}
@end
