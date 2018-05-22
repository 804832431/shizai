//
//  CouponManger.m
//  VSProject
//
//  Created by certus on 16/4/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import "CouponManger.h"

@implementation CouponManger

//请求我的优惠券列表
- (void)requestCouponList:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.coupon/get-coupon-list"];
    
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//获取默认优惠券接口
- (void)requestDefaultCoupon:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.coupon/get-default-coupon"];
    
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

//请求兑换优惠券
- (void)requestConvertCoupon:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse {
    
    NSString *url = [SERVER_IP stringByAppendingString:@"/RUI-CustomerJSONWebService-portlet.coupon/exchange-coupon"];
    
    [RequestService requesturl:url paraDic:paraDic success:^(NSDictionary *responseObj) {
        
        sResponse(responseObj);
        
    } failure:^(NSError *error) {
        //
        fResponse(error);
    }];
    
}

@end
