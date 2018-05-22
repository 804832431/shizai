//
//  ServerProductDTO.h
//  VSProject
//
//  Created by pch_tiger on 16/12/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerProductDTO : NSObject

@property (nonatomic, copy) NSString *appName; // 应用名称

@property (nonatomic, copy) NSString *productName; // 商品名称

@property (nonatomic, copy) NSString *listImageUrl; // 商品图片

@property (nonatomic, copy) NSString *productType; // 商品类型 1：购买类；2：服务类；3：预约类

@property (nonatomic, copy) NSString *price; // 商品价格

@property (nonatomic, copy) NSString *dealedCount; // 已成交笔数

@property (nonatomic, copy) NSString *subCount; // 已预约笔数

@property (nonatomic, copy) NSString *productDetail; // 商品详情页

- (id)initWithDic:(NSDictionary *)dic;

@end
