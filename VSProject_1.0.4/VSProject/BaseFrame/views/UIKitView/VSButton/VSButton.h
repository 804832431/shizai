//
//  VSButton.h
//  VSProject
//
//  Created by user on 15/1/20.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSButton : UIButton<UIInitProtocol>

_PROPERTY_NONATOMIC_ASSIGN(NSInteger, nindex);  //在按钮组中得index

@end
