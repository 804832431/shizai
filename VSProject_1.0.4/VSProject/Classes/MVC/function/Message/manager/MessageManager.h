//
//  MessageManager.h
//  VSProject
//
//  Created by certus on 16/1/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageListModel.h"
#import "MessageListModel.h"

@interface MessageManager : NSObject

//请求用户消息
- (void)requestMessages:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;


//请求用户消息正文
- (void)requestMessageContent:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;


//请求删除消息
- (void)requestDeleteMessage:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//请求清空消息
- (void)requestclearALLMessages:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//请求是否有新消息
- (void)requesthaveNewMessage:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;


@end
