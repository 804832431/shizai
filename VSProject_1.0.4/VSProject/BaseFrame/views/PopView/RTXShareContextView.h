//
//  RTXShareContextView.h
//  VSProject
//
//  Created by XuLiang on 16/1/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSPopBaseContextView.h"
#import "VSShareManager.h"

@class VSShareDataSource;
@interface RTXShareContextView : VSPopBaseContextView

@property (nonatomic, weak)UIViewController *viewController;

- (void)shareArray:(SHARETYPE)array  shareDataSource:(VSShareDataSource *)shareDataSource;

+ (CGFloat )height:(int)count;

+ (CGFloat)heightWithShareType:(SHARETYPE)array;

+ (SHARETYPE)rtxShare;//自定分享
@end
