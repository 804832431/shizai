//
//  NewActivitiesManager.h
//  VSProject
//
//  Created by apple on 10/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewActivitiesManager : NSObject

//查询活动列表接口
- (void)onRequestActivityList:(NSString *)page
                          row:(NSString *)row
                      partyId:(NSString *)partyId
                       status:(NSString *)status
                      success:(void (^) (NSDictionary*responseObj))sResponse
                      failure:(void (^) (NSError *error))fResponse;

//查询我的活动列表接口
- (void)onRequestMyActivityList:(NSString *)page
                            row:(NSString *)row
                         status:(NSString *)status
                        partyId:(NSString *)partyId
                        success:(void (^) (NSDictionary*responseObj))sResponse
                        failure:(void (^) (NSError *error))fResponse;

//查询收藏活动列表接口
- (void)onRequestCollectedActivityList:(NSString *)page
                                   row:(NSString *)row
                               partyId:(NSString *)partyId
                               success:(void (^) (NSDictionary*responseObj))sResponse
                               failure:(void (^) (NSError *error))fResponse;

//收藏、取消收藏活动
//partyId = 用户Id
//activityId = 活动Id
//action : 1 = 收藏   0 = 取消收藏
- (void)onCollectActivity:(NSString *)partyId
               activityId:(NSString *)activityId
                   action:(NSString *)action
                  success:(void (^) (NSDictionary*responseObj))sResponse
                  failure:(void (^) (NSError *error))fResponse;

//活动立即报名，获取支付订单号
//partyId = 用户Id
//activityId = 活动Id
- (void)onEnrollRightNow:(NSString *)partyId
              activityId:(NSString *)activityId
                 success:(void (^) (NSDictionary*responseObj))sResponse
                 failure:(void (^) (NSError *error))fResponse;

//完善信息接口
//partyId	客户id
//activityId	活动id
//name	姓名
//number	手机号码
//company	公司
//customerJob	职位
//userLoginId	登录手机号
- (void)onCompleteEnrollInfo:(NSString *)partyId
              activityId:(NSString *)activityId
                        name:(NSString *)name
                      number:(NSString *)number
                     company:(NSString *)company
                 customerJob:(NSString *)customerJob
                 userLoginId:(NSString *)userLoginId
                 success:(void (^) (NSDictionary*responseObj))sResponse
                 failure:(void (^) (NSError *error))fResponse;
@end
