//
//  VSCacheManager.h
//  beautify
//  ***************************************************************************************************
//                                      处理缓存逻辑
//  ***************************************************************************************************
//  Created by user on 14/12/30.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSImageCacheManager : VSBaseManager


//获取图片缓存大小
- (CGFloat)vs_cacheImageSize;

//清除图片缓存
- (void)vs_clearImageCache;

@end
