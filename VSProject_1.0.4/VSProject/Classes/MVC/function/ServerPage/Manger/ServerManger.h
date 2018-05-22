//
//  ServerManger.h
//  VSProject
//
//  Created by pch_tiger on 16/12/24.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManger : NSObject

//请求精品服务
- (void)getServiceProduct:(NSDictionary *)paraDic success:(void (^) (NSDictionary *responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

// 获取服务下应用
- (void)getServiceAppArea:(NSDictionary *)paraDic success:(void (^) (NSDictionary *responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

@end
