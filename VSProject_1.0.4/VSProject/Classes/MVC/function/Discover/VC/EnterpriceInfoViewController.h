//
//  EnterpriceInfoViewController.h
//  VSProject
//
//  Created by pch_tiger on 17/1/7.
//  Copyright © 2017年 user. All rights reserved.
//

#import "NewShareWebViewController.h"

@interface EnterpriceInfoViewController : NewShareWebViewController

@property (nonatomic, copy) NSString *barColorStr; // #ffffff

@property (nonatomic, strong) UIImage *navBarImage;

- (void)hideFlow;

@end
