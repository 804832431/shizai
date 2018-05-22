//
//  VSVersionCheckManager.h
//  VSProject
//
//  ******************************************************************************
//                          该类用于检测版本
//  ******************************************************************************
//
//  Created by tiezhang on 15/1/13.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseLogicManager.h"

@interface VSVersionCheckManager : VSBaseLogicManager

//当前app配置版本号
@property(nonatomic, assign, readonly)CGFloat currentAppVersion;

/**
 *  发送版本检测请求
 *
 *  @param callBack 版本检测回调
 *  @note  若callBack为nil则默认弹出更新alert
 */
- (void)vs_checkVersionCallBack:(VSMessageHandleCallBack)callBack;

@end
