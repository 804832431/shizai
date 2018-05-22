//
//  VSPopView.h
//  QianbaoIM
//
//  Created by liyan on 9/23/14.
//  Copyright (c) 2014 liu nian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductShareView.h"

@class VSPopBaseContextView;
@protocol VSPopViewDelegate <NSObject>

@optional
- (void)popViewDidCloseEnd;
- (void)popViewDidShowEnd;

@end

@interface VSPopView : UIView

@property(nonatomic, weak)id<VSPopViewDelegate> delegate;

+ (instancetype)popView;

- (void)qb_show:(VSPopBaseContextView *)contextView toUIViewController:(UIViewController *)viewController title:(NSString *)title
;
- (void)newqb_show:(ProductShareView *)contextView toUIViewController:(UIViewController *)viewController;

- (void)qb_show:(VSPopBaseContextView *)contextView toUIViewController:(UIViewController *)viewController;

- (void)qb_showUIView:(UIView *)view toUIViewController:(UIViewController *)viewController title:(NSString *)title;

- (void)qb_showUIView:(UIView *)view toUIViewController:(UIViewController *)viewController titleView:(UIView *)titleView;


- (void)qb_hide;

- (void)moveUpInset:(float)upInset;

@end
