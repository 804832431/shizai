//
//  EnterpriseModel.h
//  VSProject
//
//  Created by pangchao on 16/12/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnterpriseModel : NSObject

@property (nonatomic, copy) NSString <Optional>*name; // 企业名称

@property (nonatomic, copy) NSString <Optional>*image; // 背景图片

@property (nonatomic, copy) NSString <Optional>*logo; // 企业logo

@property (nonatomic, copy) NSString <Optional>*themeColor; // 主题颜色 #ffffff

@property (nonatomic, copy) NSString <Optional>*enterpriseDetail; // 详情页

- (id)initWithDic:(NSDictionary *)dic;

@end
