//
//  AdressManger.h
//  VSProject
//
//  Created by certus on 15/11/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdressModel.h"
#import "AdressResponseModel.h"

@interface AdressManger : NSObject

//请求用户收货地址
- (void)requestReceivingAddressed:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//请求增加用户收货地址
- (void)requestAddAddress:(AdressModel *)paraModel success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//请求删除用户收货地址
- (void)requestDeleteAddress:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//请求更新用户收货地址
- (void)requestUpdateAddress:(AdressModel *)paraModel success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

//请求置成默认地址
- (void)requestSetDefaultAddress:(NSDictionary *)paraDic success:(void (^) (NSDictionary*responseObj))sResponse failure:(void (^) (NSError *error))fResponse;

@end
