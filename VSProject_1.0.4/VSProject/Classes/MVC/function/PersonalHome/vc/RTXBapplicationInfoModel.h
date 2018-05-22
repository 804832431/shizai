//
//  RTXBapplicationInfoModel.h
//  VSProject
//
//  Created by XuLiang on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface RTXBapplicationInfoModel : VSBaseDataModel<NSCopying>
/*
 {
 appIcon = "http://172.16.39.140:8080/upload-apk/appIcon/sendWater.png";
 appIconKey = buybuybuy;
 appName = "\U4e0a\U95e8\U63a8\U9500";
 catalogId = 3fdfsdf;
 id = 3;
 orderType = 2;
 protocol = HTTP;
 visitType = H5;
 visitkeyword = "172.16.39.140:8080/RUI-InformationPublishManagement-portlet/html/H5/H5.jsp?searchKey=20151117001&appId=3";
 }
 */
_PROPERTY_NONATOMIC_STRONG(NSString, appIcon);
_PROPERTY_NONATOMIC_STRONG(NSString, appIconKey);
_PROPERTY_NONATOMIC_STRONG(NSString, appIntroduction);
_PROPERTY_NONATOMIC_STRONG(NSString, appName);
_PROPERTY_NONATOMIC_STRONG(NSString, catalogId);
_PROPERTY_NONATOMIC_STRONG(NSString, m_id);
_PROPERTY_NONATOMIC_STRONG(NSString, orderType);
_PROPERTY_NONATOMIC_STRONG(NSString, protocol);
_PROPERTY_NONATOMIC_STRONG(NSString, visitType);
_PROPERTY_NONATOMIC_STRONG(NSString, visitkeyword);

//由于存在“id”字段，故不可使用jsonmodel解析
-(instancetype)initwithDic:(NSDictionary *)dic;

@end
