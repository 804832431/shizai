//
//  TopicDTO.h
//  VSProject
//
//  Created by pangchao on 17/6/27.
//  Copyright © 2017年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicProductDTO.h"

@interface TopicDTO : NSObject

@property (nonatomic, copy) NSString *name; // 主题名称

@property (nonatomic, copy) NSString *desc; // 主题描述

@property (nonatomic, strong) NSMutableArray<TopicProductDTO *> *projectList;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
