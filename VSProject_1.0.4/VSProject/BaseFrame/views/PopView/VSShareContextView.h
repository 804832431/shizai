//
//  VSShareContextView.h
//  QianbaoIM
//
//  Created by liyan on 9/28/14.
//  Copyright (c) 2014 liu nian. All rights reserved.
//

#import "VSPopBaseContextView.h"
#import "VSShareManager.h"



@class VSShareDataSource;
@interface VSShareContextView : VSPopBaseContextView

@property (nonatomic, weak)UIViewController *viewController;

- (void)shareArray:(SHARETYPE)array  shareDataSource:(VSShareDataSource *)shareDataSource;

+ (CGFloat )height:(int)count;

+ (CGFloat)heightWithShareType:(SHARETYPE)array;

+ (SHARETYPE)outShare;//外站分享
+ (SHARETYPE)allShare;//全部分享



@end
