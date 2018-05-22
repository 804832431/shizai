//
//  TopicProductDTO.h
//  VSProject
//
//  Created by pangchao on 17/6/27.
//  Copyright © 2017年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicProductDTO : NSObject

@property (nonatomic, copy) NSString *productId; // 产品id
@property (nonatomic, copy) NSString *mainTitle; // 主标题
@property (nonatomic, copy) NSString *subTile; // 副标题
@property (nonatomic, copy) NSString *photo; // 产品图片
@property (nonatomic, copy) NSString *productDetailUrl; // 产品详情页地址

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
