//
//  SpaceProjectModel.h
//  VSProject
//
//  Created by pangchao on 2017/10/24.
//  Copyright © 2017年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpaceProjectModel : NSObject

@property (nonatomic, copy) NSString *projectId; // 项目Id

@property (nonatomic, copy) NSString *title; // 项目标题

@property (nonatomic, copy) NSString *projectUrl; //列表页图片

@property (nonatomic, copy) NSString *areaInfo; // 区域 商圈

@property (nonatomic, copy) NSString *projectDetail; // 项目详情页

@property (nonatomic, copy) NSString *trafficInfo; // 交通信息

@property (nonatomic, copy) NSString *singlePrice; // 价格

@property (nonatomic, copy) NSString <Optional>*isCollected; // 是否已收藏 Y:是 N:否

@property (nonatomic, copy) NSString <Optional>*spaceDetail; // 空间详情页

- (id)initWithDic:(NSDictionary *)dic;

@end
