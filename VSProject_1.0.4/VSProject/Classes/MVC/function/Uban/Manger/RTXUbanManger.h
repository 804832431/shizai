//
//  RTXUbanManger.h
//  VSProject
//
//  Created by certus on 16/3/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTXUbanManger : NSObject

//房源信息登记接口
- (void)requestSubmitRental:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//查看某个房源的看房记录信息
- (void)getMyUbanRentalInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//我的优办租房获取已发布的租房信息
- (void)getShowHistory:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//获取所有房源信息接口
- (void)getAllUbanRentalInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//获取房源详情
- (void)getUbanRentalDetail:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

@end
