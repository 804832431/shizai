//
//  UIButton+WMWebImage.m
//  beautify
//
//  Created by user on 14/12/3.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import "UIButton+VSWebImage.h"

@implementation UIButton (VSWebImage)

- (void)addHeader
{
    // 本地Hack，添加请求头
    //    NSMutableDictionary *commonHeader = nil;
    //
    //    [commonHeader enumerateKeysAndObjectsUsingBlock:^(id key, id val, BOOL *stop) {
    //        [SDWebImageManager.sharedManager.imageDownloader setValue:val forHTTPHeaderField:key];
    //    }];
}

- (void)sd_setBackgroundImageWithURL:(NSString *)url
{
    NSURL *t_url = [NSURL URLWithString:url];
    // 本地Hack，添加请求头
    [self addHeader];
    
    [self sd_setBackgroundImageWithURL:t_url forState:UIControlStateNormal];
}

- (void)sd_setBackgroundImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder
{
    NSURL *t_url = [NSURL URLWithString:url];
    // 本地Hack，添加请求头
    [self addHeader];
    [self sd_setBackgroundImageWithURL:t_url forState:UIControlStateNormal placeholderImage:placeholder];
}

- (void)sd_setBackgroundImageWithURL:(NSString *)url completed:(SDWebImageCompletionBlock)completedBlock
{
    NSURL *t_url = [NSURL URLWithString:url];
    // 本地Hack，添加请求头
    [self addHeader];
    
    [self sd_setBackgroundImageWithURL:t_url forState:UIControlStateNormal completed:completedBlock];
}

- (void)sd_setBackgroundImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock
{
    NSURL *t_url = [NSURL URLWithString:url];
    // 本地Hack，添加请求头
    [self addHeader];
    
    [self sd_setBackgroundImageWithURL:t_url forState:UIControlStateNormal placeholderImage:placeholder completed:completedBlock];
}


@end
