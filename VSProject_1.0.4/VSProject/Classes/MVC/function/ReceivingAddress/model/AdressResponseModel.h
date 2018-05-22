//
//  AdressResponseModel.h
//  VSProject
//
//  Created by certus on 15/11/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"
#import "AdressModel.h"

@protocol AdressModel


@end

@interface AdressResponseModel : VSBaseDataModel

_PROPERTY_NONATOMIC_STRONG(NSArray, __dataitem_typeof__(AdressModel) postalAddresses);           //地址数组
//@property (nonatomic,strong)NSArray<AdressModel>* postalAddresses;
//@property (nonatomic,strong)NSString *resultCode;
//@property (nonatomic,strong)NSString *errorMessage;

@end
