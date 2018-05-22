//
//  VSZiXunStyleManager.m
//  VSProject
//
//  Created by tiezhang on 15/4/12.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSZiXunStyleManager.h"

@implementation VSZiXunStyleManager

DECLARE_SINGLETON(VSZiXunStyleManager)

//设置15号字体
- (void)vs_useTitleStyle_Font_15_WhiteColor:(UIView*)desView
{
    
    if([desView isKindOfClass:[UITextField class]])
    {
        UITextField *txtFieldView = (UITextField*)desView;
        txtFieldView.font = kSysFont_15;
        txtFieldView.textColor = kColor_ffffff;
    }
    else if([desView isKindOfClass:[UITextView class]])
    {
        
    }
    else if ([desView isKindOfClass:[UILabel class]])
    {
        
    }
    else
    {
        
    }
}

- (void)testMethodA
{
    NSString *methodName = @"testMethodA";
    
}

@end
