//
//  ECFirstViewController.h
//  EmperorComing
//
//  Created by XuLiang on 15/10/10.
//  Copyright (c) 2015年 姚君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroView.h"

@interface ECFirstViewController : UIViewController<EAIntroDelegate>

@property (nonatomic,strong)UINavigationController *nextRoot;

@end
