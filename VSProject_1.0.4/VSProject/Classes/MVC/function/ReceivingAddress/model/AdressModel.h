//
//  AdressModel.h
//  VSProject
//
//  Created by certus on 15/11/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseParmModel.h"

@interface AdressModel : VSBaseNeedSaveDataModel

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, contactMechId);    //收货地址id
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, recipient);        //收货人
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, contactNumber);    //收货人联系电话
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, address);          //收货人地址
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, zipCode);          //邮政编码
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, isDefault);        //是否默认
_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, partyId);          //用户id

@end
