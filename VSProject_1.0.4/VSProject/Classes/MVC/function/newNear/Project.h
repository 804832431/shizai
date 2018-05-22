//
//  Project.h
//  VSProject
//
//  Created by 陈 海涛 on 16/8/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject
@property(nonatomic,strong)NSString* id	;//    项目ID
@property(nonatomic,strong)NSString* picture;//	    项目图片
@property(nonatomic,strong)NSString* projectName;//	项目名称
@property(nonatomic,strong)NSString* city;//	定位到的城市
@property(nonatomic,strong)NSString* distance;//	距离

@end
