//
//  UIViewController+BackBar.h
//  VSBuyComponent
//
//  Created by summer.zhu on 31/10/14.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBlock)();

@interface UIViewController (BackBar)

/**
*  是否使用navigation自定义的返回按钮
*
*  @param bUse       是否使用
*  @param bAnimation 返回时是否需要动画
*  @param block      返回时的block
*/
- (void)useLeftBarItem:(BOOL)bUse back:(BackBlock)block;

- (void)hideUseLeftBarItem;

@end
