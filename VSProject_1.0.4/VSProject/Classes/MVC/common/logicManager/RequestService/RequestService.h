//
//  RequestService.h
//  EmperorComing
//
//  Created by certus on 15/8/31.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestService : NSObject

//字典转json
+(NSString*)DataTOjsonString:(id)object;

//请求
+ (void)requesturl:(NSString *)urlString paraDic:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//入参是json的请求
+ (void)requesturl:(NSString *)urlString paraContentDic:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;


//根据数据上传
+ (void)uploadurl:(NSString *)urlString dataArray:(NSArray *)dataArray fileType:(NSString *)fileType paraDic:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse progess:(void (^) (float progess))progess;

@end
