//
//  VSNetErrorView.h
//  beautify
//
//  Created by user on 15/1/9.
//  Copyright (c) 2015年 Elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NetErrorViewCallBack)(void);

@interface VSNetErrorView : UIView <UIInitProtocol>

- (VSNetErrorView*)initWithCallBack:(NetErrorViewCallBack)callBack;

@end
