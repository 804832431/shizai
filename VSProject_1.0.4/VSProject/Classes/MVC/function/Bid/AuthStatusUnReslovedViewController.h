//
//  AuthStatusUnReslovedViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"

@interface AuthStatusUnReslovedViewController : VSBaseViewController
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *topBackGroundView;
@property (weak, nonatomic) IBOutlet UILabel *authStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *failReasonLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *failReasonHigh;
@property (weak, nonatomic) IBOutlet UIView *failSeparatorLine;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *modifyButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *deleteSeparaterLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deleteHigh;

- (IBAction)playCall:(id)sender;


@end
