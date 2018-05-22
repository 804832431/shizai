//
//  UIImageView+WMWebImage.h
//  beautify
//
//  Created by user on 14/12/3.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (VSWebImage)

- (void)addHeader;

- (void)sd_setImageWithString:(NSString *)url;

- (void)sd_setImageWithString:(NSString *)url placeholderImage:(UIImage *)placeholder ;

- (void)sd_setImageWithString:(NSString *)url completed:(SDWebImageCompletionBlock)completedBlock;

- (void)sd_setImageWithString:(NSString *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock ;

@end
