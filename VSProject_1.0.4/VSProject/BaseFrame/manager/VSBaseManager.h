//
//  VSBaseManager.h
//  VSProject
//
//************************************整个项目逻辑,业务管理对象基类******************************************************/
//    @desc:
//          1.用于派生逻辑业务管理对象
//          2.提供创建单例的协议
//************************************整个项目逻辑,业务管理对象基类******************************************************/
//
//  Created by tiezhang on 15/1/12.
//  Copyright (c) 2015年 user. All rights reserved.
//


@protocol VSBaseManagerProtocol <NSObject>

@optional
+ (instancetype)shareInstance;

@end

@class VSBaseParmModel;
@interface VSBaseManager : NSObject<VSBaseManagerProtocol>


@end
