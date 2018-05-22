//
//  NSDictionary+Util.h
//  VSProject
//
//  Created by tiezhang on 15/4/19.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Util)

//获取Dictionary中的元素,主要防止服务器发送@""或者obje-c转化成NSNull
- (id)vs_getElementForKey:(id)key fromDict:(NSDictionary *)dict;
//按照数据类型获取Dictionary中的元素,主要防止服务器发送@""或者obje-c转化成NSNull
- (id)vs_getElementForKey:(id)key fromDict:(NSDictionary *)dict forClass:(Class)forClass;
//获取Dictionary中的元素,当是字符串时候处理过滤空白字符,否则返回取出的值
- (id)vs_getElementForKey:(id)key fromDict:(NSDictionary *)dict character:(NSCharacterSet*)character;
//过滤字典中的空数据
- (id)vs_filterDictionary:(NSDictionary *)dictionary;

// add by pangchao
- (NSInteger)intValue:(NSString*)path;
- (long)longValue:(NSString*)path;
- (float)floatValue:(NSString*)path;
- (NSString*)strValue:(NSString*)path;
-(NSArray *) arrayValue :(NSString *) path;

@end
