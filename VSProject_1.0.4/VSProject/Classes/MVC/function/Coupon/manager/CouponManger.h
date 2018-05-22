//
//  CouponManger.h
//  VSProject
//
//  Created by certus on 16/4/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponManger : NSObject

//请求我的优惠券
- (void)requestCouponList:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//获取默认优惠券接口
- (void)requestDefaultCoupon:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;


//请求兑换优惠券
- (void)requestConvertCoupon:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

@end
