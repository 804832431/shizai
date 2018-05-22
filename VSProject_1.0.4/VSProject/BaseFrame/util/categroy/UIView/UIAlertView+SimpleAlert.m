//
//  UIAlertView+SimpleAlert.m
//  VSProject
//
//  Created by user on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "UIAlertView+SimpleAlert.h"

@implementation UIAlertView (SimpleAlert)

+ (void)vs_simpleAlertTitle:(NSString*)title message:(NSString*)msg okAction:(void(^)(void))okBlock cancelAction:(void(^)(void))cancelBlock
{
    RIButtonItem * okItem   = [RIButtonItem itemWithLabel:@"确定" action:okBlock];
    
    RIButtonItem * cancelItem = [RIButtonItem itemWithLabel:@"取消" action:^{
        
    }];
    
    UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:title
                                                    message:msg
                                           cancelButtonItem:cancelItem
                                           otherButtonItems:okItem, nil];
    [alert show];
}

@end
