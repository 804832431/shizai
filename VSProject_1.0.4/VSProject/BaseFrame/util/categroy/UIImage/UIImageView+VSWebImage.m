//
//  UIImageView+WMWebImage.m
//  beautify
//
//  Created by user on 14/12/3.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import "UIImageView+VSWebImage.h"

@implementation UIImageView (VSWebImage)

- (void)addHeader
{
    // 本地Hack，添加请求头
//    NSMutableDictionary *commonHeader = nil;
//    
//    [commonHeader enumerateKeysAndObjectsUsingBlock:^(id key, id val, BOOL *stop) {
//        [SDWebImageManager.sharedManager.imageDownloader setValue:val forHTTPHeaderField:key];
//    }];
}

- (void)sd_setImageWithString:(NSString *)url
{
    NSURL *t_url = [NSURL URLWithString:url];
    [self addHeader];
    [self sd_setImageWithURL:t_url];
}

- (void)sd_setImageWithString:(NSString *)url placeholderImage:(UIImage *)placeholder
{
    NSURL *t_url = [NSURL URLWithString:url];
    [self addHeader];
    [self sd_setImageWithURL:t_url placeholderImage:placeholder];
}

- (void)sd_setImageWithString:(NSString *)url completed:(SDWebImageCompletionBlock)completedBlock
{
    NSURL *t_url = [NSURL URLWithString:url];
    [self addHeader];
    [self sd_setImageWithURL:t_url completed:completedBlock];
}

- (void)sd_setImageWithString:(NSString *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock
{
    NSURL *t_url = [NSURL URLWithString:url];
    [self addHeader];
    [self sd_setImageWithURL:t_url placeholderImage:placeholder completed:completedBlock];
}

@end
