//
//  VSJsonHelper.h
//  beautify
//
//  Created by user on 14/12/11.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSJsonHelper : NSObject

//将json文件读到一个对象中去
+ (id)connvertJSONFileToObj:(NSString *)fileName;

//将json文件读到一个对象中去
+ (id)connvertJSONFilePathToObj:(NSString *)filePath;

//JSON转换成obj
+ (id)convertJSONToDict:(NSString *)string;

//obj转换成JSON, obj可以为dictionary，array...
+ (NSString *)convertObjectToJSON:(id)object;

//bexcept是否采取替换特殊符号
+ (NSString *)convertObjectToJSON:(id)object except:(BOOL)bexcept;

//将NSData转成object
+ (id)convertDataToObj:(NSData *)data;

//获取Dictionary中的元素,主要防止服务器发送@""或者obje-c转化成NSNull
+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict;

//按照数据类型获取Dictionary中的元素,主要防止服务器发送@""或者obje-c转化成NSNull
+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict forClass:(Class)forClass;

//获取Dictionary中的元素,当是字符串时候处理过滤空白字符,否则返回取出的值
+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict character:(NSCharacterSet*)character;

@end
