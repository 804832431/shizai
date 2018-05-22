//
//  LocalStorage.h
//  EmperorComing
//
//  Created by certus on 15/9/1.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalStorage : NSObject

//用户根路径
+ (NSString *)user;

//用户管理路径
+ (NSString *)userManagePath;

//用户注册信息
+ (NSString *)userRegiesterPath;

//用户位置信息
+ (NSString *)userLocationPath;

//用户消息路径
+ (NSString *)pushMessegePath;

//上传图片保存路径
+ (NSString *)uploadPhotosPath;

//保存上传图片
+(BOOL)uploadPhotos:(NSArray *)selectedPhotosArray;

@end
