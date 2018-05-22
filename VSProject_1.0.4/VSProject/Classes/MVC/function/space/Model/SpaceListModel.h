//
//  SpaceModel.h
//  VSProject
//
//  Created by pangchao on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpaceListModel : NSObject

@property (nonatomic, copy) NSString *spaceId;

/*  spaceLease      空间租赁
    conferenceRoom  会议室
    mobileStation   移动工位
    spaceAcquisition 空间购置
 */
@property (nonatomic, copy) NSString <Optional>*spaceType; // 空间类型

@property (nonatomic, copy) NSString <Optional>*title; // 标题

@property (nonatomic, copy) NSString <Optional>*picListUrl; // 列表页图片

@property (nonatomic, copy) NSString <Optional>*isLargeImage; // 是否展示大图：Y：是，N：否

@property (nonatomic, copy) NSString <Optional>*roomInfo; // 面积，工位数量

@property (nonatomic, copy) NSString <Optional>*singlePrice; // 价格

@property (nonatomic, copy) NSString <Optional>*isCollected; // 是否已收藏 Y:是 N:否

@property (nonatomic, copy) NSString <Optional>*spaceDetail; // 空间详情页

- (id)initWithDic:(NSDictionary *)dic;

@end
