//
//  LocalStorage.m
//  EmperorComing
//
//  Created by certus on 15/9/1.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import "LocalStorage.h"

@implementation LocalStorage

//根路径
+ (NSString *)documentPath {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths lastObject];
    return documentPath;
}

#pragma mark - user

//用户根路径
+ (NSString *)user {
    
    NSString *path = [[LocalStorage documentPath] stringByAppendingPathComponent:@"user"];
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }

    return path;
}

//用户管理
+ (NSString *)userManagePath {

    return [[LocalStorage user] stringByAppendingPathComponent:@"userManage.plst"];
}

//用户注册信息
+ (NSString *)userRegiesterPath {
    
    return [[LocalStorage user] stringByAppendingPathComponent:@"userRegiester.plst"];
}

//用户地理位置
+ (NSString *)userLocationPath {
    
    return [[LocalStorage user] stringByAppendingPathComponent:@"userLocation.plst"];
}


//用户消息路径
+ (NSString *)pushMessegePath {
    
    return [[LocalStorage user] stringByAppendingPathComponent:@"userMessege.plst"];
}



#pragma mark - uploadPhotos

//上传图片保存路径
+ (NSString *)uploadPhotosPath {
    
    NSString *path = [[LocalStorage documentPath] stringByAppendingPathComponent:@"photos"];
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"path---%@",path);
    return path;
}

//保存上传图片
+(BOOL)uploadPhotos:(NSArray *)selectedPhotosArray{

    BOOL b = NO;
    NSString *uploadPhotos = [LocalStorage uploadPhotosPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:uploadPhotos]) {
        [[NSFileManager defaultManager] removeItemAtPath:uploadPhotos error:nil];
    }
    for (NSData *photoData in selectedPhotosArray) {
        NSString *photopath = [[LocalStorage uploadPhotosPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"upload%lu",(unsigned long)[selectedPhotosArray indexOfObject:photoData]]];
        b = [photoData writeToFile:photopath atomically:YES];
    }
    return b;
}


@end
