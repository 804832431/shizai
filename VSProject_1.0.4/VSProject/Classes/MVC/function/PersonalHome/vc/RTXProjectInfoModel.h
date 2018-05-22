//
//  RTXProjectInfoModel.h
//  VSProject
//
//  Created by XuLiang on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface RTXProjectInfoModel : VSBaseNeedSaveDataModel

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, comments);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, companyId);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, countryId);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, createDate);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, modifiedDate);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, name);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, organizationId);//项目编号

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, parentOrganizationId);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, recursable);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, regionId);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, statusId);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, treePath);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, type);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, userId);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, userName);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, uuid);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, cityId);

_PROPERTY_NONATOMIC_STRONG_OPTION(NSString, cityName);
/*
 comments = "";
 companyId = 158;
 countryId = 0;
 createDate = 1446273059000;
 modifiedDate = 1446273059000;
 name = "\U7eff\U5730\U9879\U76ee";
 organizationId = 7301;
 parentOrganizationId = 0;
 recursable = 1;
 regionId = 0;
 statusId = 12017;
 treePath = "/7301/";
 type = "regular-organization";
 userId = 202;
 userName = "Test Test";
 uuid = "d9f9e059-3e61-45c6-ae8a-74e80bd59f2a";
 */

//改为使用jsonModel
//-(instancetype)initwithDic:(NSDictionary *)dic;
@end
