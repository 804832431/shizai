//
//  UIButton+WMWebImage.h
//  beautify
//
//  Created by user on 14/12/3.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIButton+WebCache.h>

@interface UIButton (VSWebImage)

- (void)sd_setBackgroundImageWithURL:(NSString *)url;

- (void)sd_setBackgroundImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;

- (void)sd_setBackgroundImageWithURL:(NSString *)url completed:(SDWebImageCompletionBlock)completedBlock;

- (void)sd_setBackgroundImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;

@end
