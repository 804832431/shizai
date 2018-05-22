//
//  NSString+Filter.h
//  VSProject
//
//  Created by tiezhang on 15/2/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Filter)

#pragma mark - 正则
//金额验证 MODIFIED BY ThomasXu*/
+ (BOOL)isValidateMoney:(NSString *)money;
//手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateMobile:(NSString *)mobile;
//6-32个字符,请使用字母、数字或下划线，区分大小写
+ (BOOL)isValidateUserPassword:(NSString *)password;
//只能输入汉字
+ (BOOL)isValidateChinaChar:(NSString *)realname;
//身份证号码
+ (BOOL)isValidateIdentityCard:(NSString *)identityCard;
//邮箱
+ (BOOL)isEmail:(NSString *)emailStr;
//中国大陆手机号码
+ (BOOL)isPhoneNum:(NSString *)phoneNum;
//身份证上的姓名
+ (BOOL)isValidateCHNameChar:(NSString *)realname;
//纯数字
+ (BOOL)isTypeNumber:(NSString *)num;
//是否包含特殊字符
+ (BOOL)isContainSpecialCharacter:(NSString*)str;
//是否是否仅包含英文、中文、数字
+ (BOOL)isContainNonEnglishAndChineseCharacter:(NSString*)str;
//字母、数字或下划线
+ (BOOL)isContainNonEnglishAndUnderscores:(NSString*)str;
//字母、数字或下划线中文
+ (BOOL)isContainNonEnglishAndUnderscoresAndChinese:(NSString*)str;


@end
