//
//  VSBaseLogicManager+MakeCall.m
//  VSProject
//
//  Created by tiezhang on 15/2/10.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseLogicManager+MakeCall.h"
#import <UIAlertView-Blocks/UIAlertView+Blocks.h>

@implementation VSBaseLogicManager (MakeCall)

/**
 *  @desc  拨打电话，内部调用会弹出alert提示框
 *  @parm  tel 需要拨打的电话
 *  @note  内置调用 vs_makeCallToTel:(NSString*)tel noteTitle:(NSString*)title okTitle:(NSString*)okTitle cancelTitle:(NSString*)cancelTitle;
 *         默认noteTitle：确定要拨打tel吗？ okTitle：@"确定" cancelTitle:@"取消"
 */
+ (void)vs_makeCallToTel:(NSString*)tel
{
    return [self vs_makeCallToTel:tel noteTitle:[NSString stringWithFormat:@"确定要拨打%@吗？", tel] okTitle:@"确定" cancelTitle:@"取消"];
}


/**
 *  @desc  拨打电话，内部调用会弹出alert提示框
 *  @parm  tel:需要拨打的电话 noteTitle:提示文本 okTitle:alert确认按钮文本 cancelTitle:alert取消按钮文本
 */
+ (void)vs_makeCallToTel:(NSString*)tel noteTitle:(NSString*)title okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle
{
    RIButtonItem * okItem = [RIButtonItem itemWithLabel:okTitle action:^{
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", tel]]];
    }];
    
    RIButtonItem * cancelItem = [RIButtonItem itemWithLabel:cancelTitle action:^{
        
    }];
    
    UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:title cancelButtonItem:cancelItem otherButtonItems:okItem, nil];
    [alert show];
    
}

@end
