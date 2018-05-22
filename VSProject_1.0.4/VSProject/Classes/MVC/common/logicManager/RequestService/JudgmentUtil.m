//
//  JudgmentUtil.m
//  complat2.1
//
//  Created by yaojun on 14-8-26.
//  Copyright (c) 2014年 hanweb. All rights reserved.
//

#import "JudgmentUtil.h"

@implementation JudgmentUtil


//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//邮政编码
+ (BOOL) validatePostalCode:(NSString *)postalCode
{
    NSString *postalCodeRegex = @"^[1-9]\\d{5}$";
    NSPredicate *postalCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", postalCodeRegex];
    return [postalCodeTest evaluateWithObject:postalCode];
}
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^((1[3,7][0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [phoneTest evaluateWithObject:mobile];
    
    //1开头，11位纯数字
    if ([mobile hasPrefix:@"1"] && mobile.length == 11) {
        return [JudgmentUtil isPureInt:mobile];
    } else {
        return NO;
    }
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//联系方式验证
+ (BOOL) validateContact:(NSString *)phoneNumber
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    BOOL isMatch = YES;
    
    if (([regextestmobile evaluateWithObject:phoneNumber] == YES)
        || ([regextestcm evaluateWithObject:phoneNumber] == YES)
        || ([regextestct evaluateWithObject:phoneNumber] == YES)
        || ([regextestcu evaluateWithObject:phoneNumber] == YES)
        || ([regextestphs evaluateWithObject:phoneNumber] == YES)){
        isMatch = YES;
    }else{
        isMatch = NO;
    }
    return isMatch;
}

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,15}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//n位纯数字
+ (BOOL) validateInteger: (NSString *)integerCard digits:(int)digitsNUm
{
    NSString *regex2 = [NSString stringWithFormat:@"%@%d%@",@"[0-9]{",digitsNUm,@"}"];
    NSPredicate *integerPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [integerPredicate evaluateWithObject:integerCard];
}

//正整数
+ (BOOL) validateInteger: (NSString *)integerCard
{
    NSString *regex2 = @"^[1-9]\\d*$";
    NSPredicate *integerPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [integerPredicate evaluateWithObject:integerCard];
}
//数字和小数点
+ (BOOL) validateIntegerPoint: (NSString *)integerCard
{
    NSString *regex2 = [NSString stringWithFormat:@"^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$"];
    NSPredicate *integerPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [integerPredicate evaluateWithObject:integerCard];
}

//车牌号
+ (BOOL) validateLicensePlate: (NSString *)licensePlate
{
    NSString *regex2 = [NSString stringWithFormat:@"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$"];
    NSPredicate *integerPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [integerPredicate evaluateWithObject:licensePlate];
}

//特殊字符
+ (BOOL) validateSpecialCharacter: (NSString *)character
{
    NSString *regex2 = [NSString stringWithFormat:@"^[\u4e00-\u9fa5]|^\\w+[1-10]$"];
    NSPredicate *integerPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [integerPredicate evaluateWithObject:character];
}

//优惠券
+ (BOOL) validateDiscountCode:(NSString *)name
{
//    NSString *userNameRegex = @"^[A-Za-z0-9]{8}+$";
    NSString *userNameRegex = @"^[A-Za-z0-9]+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
@end
