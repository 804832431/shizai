//
//  VSBaseNeedSaveDataModel.h
//  VSProject
//
//************************************整个项目需要缓存本地数据对象基类模型******************************************************/
//    @desc:
//      用于处理项目中需要存储本地的对象数据模型
//************************************整个项目需要缓存本地数据对象基类模型******************************************************/
//
//  Created by tiezhang on 15/2/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface VSBaseNeedSaveDataModel : VSBaseDataModel

#pragma mark -- default action
//runtime处理属性encoder
- (void)vs_handleProperyEnCoder:(NSCoder *)aCoder;

//runtime处理属性decoder
- (void)vs_handleProperyDeCoder:(NSCoder *)aDecoder;

//对象持久化时属性名转化成持久化key的方法 默认 相同
- (NSString*)vs_codeKeyFromPropertyName:(NSString*)propertyName;

@end
