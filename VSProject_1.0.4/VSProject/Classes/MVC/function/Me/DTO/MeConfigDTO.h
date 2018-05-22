//
//  MeConfigDTO.h
//  VSProject
//
//  Created by pangchao on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeConfigDTO : NSObject

@property (nonatomic, copy) NSString *iconName;         // 图标名称

@property (nonatomic, copy) NSString *iconUrl;          // 图标为网络图片

@property (nonatomic, copy) NSString *title;            // 标题

@property (nonatomic, copy) NSString *arrowImageName;   // 指向按钮

@property (nonatomic, copy) NSString *directUrl;        // 点击转向URL

@end
