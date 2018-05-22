//
//  NSString+Filter.m
//  VSProject
//
//  Created by tiezhang on 15/2/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "NSString+Filter.h"
#import <RegexKitLite.h>

//特殊字符正则
#define REGEX_SPECIALCHARACTER                  @"[`~!@#$^&*()=|{}':;'\\\\,\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；;”“'。，、？%]"

@implementation NSString (Filter)

#pragma mark - 正则

//金额验证 MODIFIED BY ThomasXu*/
+ (BOOL)isValidateMoney:(NSString *)money{
    //小数点前最多6位，小数点后最多两位
    NSString *commitMoneyRegex = @"\\b[1-9]\\d{0,5}\\b|\\b[1-9]\\d{0,5}\\.\\d{1,2}\\b|\\b0\\.[1-9]\\d?\\b|\\b0\\.\\d[1-9]\\b";
    NSPredicate *moneyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",commitMoneyRegex];
    return [moneyTest evaluateWithObject:money];
}

+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //交给服务端验证了，此处只要判断开头为1即可
    NSString *phoneRegex = @"^1\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

//+ (BOOL)isValidateMobile:(NSString *)mobile
//{
//
//    //手机号以13， 15，18开头,以及145，147两个新段，八个 \d 数字字符
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(14[57]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    //    NSLog(@"phoneTest is %@",phoneTest);
//    return [phoneTest evaluateWithObject:mobile];
//}

+ (BOOL)isValidateUserPassword:(NSString *)password;
{
    //NSString *regexStr = @"^[0-9A-Za-z_]{6,32}$";
    
    // modify by huagnxiaojie 2014.5.22 密码为6~14位单字符，支持数字，大小写字母和标点符号，不允许有空格
    NSString* regexStr   = @"^[\\x00-\\xff&&[^\\x20]]{6,14}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    return [predicate evaluateWithObject:password];
    
    
}

+ (BOOL)isValidateChinaChar:(NSString *)realname
{
    NSString *regexStr = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    return [predicate evaluateWithObject:realname];
}

+ (BOOL)isValidateIdentityCard:(NSString *)identityCard
{
    NSString *regexStr = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}[\\d|X]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    return [predicate evaluateWithObject:identityCard];
}

+ (BOOL)isEmail:(NSString *)emailStr
{
    //    NSString* regex_mail = @"([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\\.[a-zA-Z0-9_-]{2,3}){1,2})";
    
    NSString *regexStr = @"^[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    BOOL isMathed = [emailStr isMatchedByRegex:regexStr];
    return isMathed;
    //    return [predicate evaluateWithObject:emailStr];
}

+ (BOOL)isPhoneNum:(NSString *)phoneNum
{
    NSString *regexStr = @"^1[3458]\\d{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    return [predicate evaluateWithObject:phoneNum];
}

+ (BOOL)isValidateCHNameChar:(NSString *)realname
{
    NSString *regexStr = @"^[\u4e00-\u9fa5]{1,}[·|.|•|•|•]?[\u4e00-\u9fa5]{1,}$";//@"^[\u4e00-\u9fa5]{2,24}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    return [predicate evaluateWithObject:realname];
}

+ (BOOL)isTypeNumber:(NSString *)num
{
    NSString *regexStr = @"^\\d+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    return [predicate evaluateWithObject:num];
}

+ (BOOL)isContainSpecialCharacter:(NSString*)str
{
    if(!str || str.length <= 0)
        return YES;
    
    BOOL flag = [str isMatchedByRegex:REGEX_SPECIALCHARACTER];
    return flag;
}

+ (BOOL)isContainNonEnglishAndChineseCharacter:(NSString*)str
{
    NSString *regTags = @"^[0-9a-zA-Z\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regTags];
    return ![predicate evaluateWithObject:str];
}

+ (BOOL)isContainNonEnglishAndUnderscores:(NSString*)str
{
    NSString *regTags = @"^[0-9a-zA-Z_]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regTags];
    return ![predicate evaluateWithObject:str];
}

+ (BOOL)isContainNonEnglishAndUnderscoresAndChinese:(NSString*)str
{
    NSString *regTags = @"^[0-9a-zA-Z\u4e00-\u9fa5_]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regTags];
    return ![predicate evaluateWithObject:str];
}

@end
