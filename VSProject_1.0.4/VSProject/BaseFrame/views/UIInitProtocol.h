//
//  UIInitProtocol.h
//  beautify
//  *********************************************************************************************
//                                  UI初始化的协议
//  *********************************************************************************************
//  Created by user on 14/12/5.
//  Copyright (c) 2014年 Elephant. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIInitProtocol <NSObject>

@optional
+ (CGFloat)vp_height;   //返回UI高度

- (void)vp_setInit;     //设置ui样式

- (void)vp_updateUIWithModel:(id)model; //根据数据模型更新ui

@end
