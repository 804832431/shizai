//
//  QBFileHelper.h
//  Qianbao
//
//  Created by zhangtie on 14-2-25.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSFileHelper : NSObject

+ (VSFileHelper*)shareIntance;

+ (NSString*)getDocumentPath;

- (BOOL)fileExistsAtPath:(NSString*)filePath;

- (BOOL)createDirectory:(NSString*)dir attribute:(NSDictionary*)attr;

- (BOOL)createFileAtPath:(NSString*)path content:(NSData*)contentData;

#pragma mark -- plist
//根据文件名加载Plist，默认位置bundle
- (NSDictionary*)loadDictInfoPlistName:(NSString*)plistName;

- (NSDictionary*)loadDictInfoPlistPath:(NSString *)filePath;

#pragma mark -- backup
//备份相关
+ (BOOL)setSkipBackupAttribute:(NSString *)path;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

#pragma mark -- usercache相关
- (void)setObjectToUserCache:(id)data forKey:(NSString*)key;

- (id)getObjectFromUserCacheForKey:(NSString*)key;

- (void)removeObjectFromUserCacheForKey:(NSString*)key;

@end
