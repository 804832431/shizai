//
//  JudgmentUtil.h
//  complat2.1
//
//  Created by yaojun on 14-8-26.
//  Copyright (c) 2014年 hanweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JudgmentUtil : NSObject

//邮箱
+ (BOOL) validateEmail:(NSString *)email;

//邮政编码
+ (BOOL) validatePostalCode:(NSString *)postalCode;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//联系方式验证
+ (BOOL) validateContact:(NSString *)phoneNumber;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//车型
+ (BOOL) validateCarType:(NSString *)CarType;

//用户名
+ (BOOL) validateUserName:(NSString *)name;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//n位纯数字
+ (BOOL) validateInteger: (NSString *)integerCard digits:(int)digitsNUm;

//纯数字
+ (BOOL) validateInteger: (NSString *)integerCard;

//数字和小数点
+ (BOOL) validateIntegerPoint: (NSString *)integerCard;

//车牌号
+ (BOOL) validateLicensePlate: (NSString *)licensePlate;

//特殊字符
+ (BOOL) validateSpecialCharacter: (NSString *)character;

//优惠券
+ (BOOL) validateDiscountCode:(NSString *)name;

@end
