//
//  GuideViewController.h
//  VSProject
//
//  Created by certus on 15/12/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseViewController.h"

@interface GuideViewController : VSBaseViewController

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UINavigationController *nextRoot;
@property (nonatomic,assign)BOOL needDisapperButton;

@end
