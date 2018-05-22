//
//  AuthStatusView.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import "AuthStatusView.h"

@implementation AuthStatusView

- (void)awakeFromNib{
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    
}

@end
