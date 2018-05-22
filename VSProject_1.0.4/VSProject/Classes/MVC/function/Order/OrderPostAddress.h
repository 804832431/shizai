//
//  OrderPostAddress.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/23.
//  Copyright © 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderPostAddress : VSBaseModel

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,address);//	收货地址
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,contactMechId);//	收货地址Id
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,contactNumber);//	联系电话
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,recipient);//	收货人
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString,zipCode);//	邮编

@end
