//
//  NotificationAgentManger.h
//  VSProject
//
//  Created by certus on 16/4/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationAgentManger : NSObject

//获取我的预约待办
- (void)requestGetReservationByStatus:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//查看预约待办详情
- (void)requestGetReservationDetail:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//获取我的预约待办
- (void)requestCancelReservation:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

@end
