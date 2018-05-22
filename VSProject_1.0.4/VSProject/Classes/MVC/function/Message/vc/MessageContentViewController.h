//
//  MessageContentViewController.h
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "MessageModel.h"

@interface MessageContentViewController : VSBaseViewController

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic,strong)MessageModel *m_model;

@end
