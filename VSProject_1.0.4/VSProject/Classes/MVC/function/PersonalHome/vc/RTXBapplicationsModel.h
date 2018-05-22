//
//  RTXBapplicationsModel.h
//  VSProject
//
//  Created by XuLiang on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"
#import "RTXBapplicationInfoModel.h"

@interface RTXBapplicationsModel : VSBaseDataModel

_PROPERTY_NONATOMIC_STRONG(NSArray, applications);

_PROPERTY_NONATOMIC_STRONG(NSString, count);

_PROPERTY_NONATOMIC_STRONG(NSString, hasNext);

-(instancetype)initwithDic:(NSDictionary *)dic;
@end
