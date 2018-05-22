//
//  VSCacheManager.m
//  beautify
//
//  Created by user on 14/12/30.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import "VSImageCacheManager.h"
#import <SDImageCache.h>

@implementation VSImageCacheManager

DECLARE_SINGLETON(VSImageCacheManager)

- (CGFloat)vs_cacheImageSize
{
     return [[SDImageCache sharedImageCache] getSize] / 1024.0 / 1024.0; // M
}

- (void)vs_clearImageCache
{
    [[SDImageCache sharedImageCache] clearDisk];
    
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
