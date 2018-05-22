//
//  CenterManger.h
//  VSProject
//
//  Created by certus on 15/11/4.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CenterManger : NSObject

//请求用户信息
- (void)requestCustomerInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//请求用户汇总信息
- (void)requestCustomerMainData:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//更改用户信息
- (void)updateCustomerInfo:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;


//更改用户头像
- (void)updateHeaderIcon:(NSDictionary *)paraDic dataArray:(NSArray *)dataArray success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//上传空间图片
- (void)updateSpaceIcon:(NSDictionary *)paraDic dataArray:(NSArray *)dataArray success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//获取标签列表
- (void)getTagsList:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//用户打标
- (void)updateMakeTags:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

@end
