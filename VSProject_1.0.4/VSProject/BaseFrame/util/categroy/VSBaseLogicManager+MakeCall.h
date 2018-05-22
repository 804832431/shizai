//
//  VSBaseLogicManager+MakeCall.h
//  VSProject
//
//  Created by tiezhang on 15/2/10.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseLogicManager.h"

@interface VSBaseLogicManager (MakeCall)

/**
 *  @desc  拨打电话，内部调用会弹出alert提示框
 *  @parm  tel 需要拨打的电话
 *  @note  内置调用 vs_makeCallToTel:(NSString*)tel noteTitle:(NSString*)title okTitle:(NSString*)okTitle cancelTitle:(NSString*)cancelTitle;
 *         默认noteTitle：确定要拨打tel吗？ okTitle：@"确定" cancelTitle:@"取消"
 */
+ (void)vs_makeCallToTel:(NSString*)tel;

/**
 *  @desc  拨打电话，内部调用会弹出alert提示框
 *  @parm  tel:需要拨打的电话 noteTitle:提示文本 okTitle:alert确认按钮文本 cancelTitle:alert取消按钮文本
 */
+ (void)vs_makeCallToTel:(NSString*)tel noteTitle:(NSString*)title okTitle:(NSString*)okTitle cancelTitle:(NSString*)cancelTitle;

@end
