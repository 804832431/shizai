//
//  VSBaseDataMode.h
//  VSProject
//
//************************************整个项目的数据对象基类模型******************************************************/
//    @desc:
//          1.用于项目中得数据对象模型(如:网路返回数据对象，如逻辑，业务对象等等)
//          2.提供统一持久化协议(vp_saveToLocal)
//          3.提供统一加载本地缓存数据协议(vp_loadLocal)
//************************************整个项目的数据对象基类模型******************************************************/
//
//  Created by user on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseModel.h"

@class VSBaseDataModel;
@protocol VSBaseDataModelProtocol <NSObject>

@optional
//持久化到本地
- (void)vp_saveToLocal;

//加载本地存储数据
+ (instancetype)vp_loadLocal;

//清除缓存
- (void)vp_clear;

@end

@interface VSBaseDataModel : VSBaseModel<VSBaseDataModelProtocol, NSCoding>

//深拷贝
- (BOOL)vs_copyWithOther:(VSBaseDataModel *)other;

@end
