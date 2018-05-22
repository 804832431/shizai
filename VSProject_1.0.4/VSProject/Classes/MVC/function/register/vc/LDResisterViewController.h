//
//  LDResisterViewController.h
//  VSProject
//
//  Created by YaoJun on 15/10/28.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "PicPlaceholerView.h"

@interface LDResisterViewController : VSBaseViewController

@property (strong, nonatomic) PicPlaceholerView *phoneTextfield;
@property (strong, nonatomic) PicPlaceholerView *passwordTextfield;
@property (strong, nonatomic) PicPlaceholerView *surePasswordTextfield;
@property (strong, nonatomic) PicPlaceholerView *enterpriceTextfield;
@property (strong, nonatomic) PicPlaceholerView *verificationCodeTextfield;
@property (strong, nonatomic) UIButton *checkButton;
@property (strong, nonatomic) UIButton *agreementButton;
@property (strong, nonatomic) UIButton *registerButton;
@property (assign, nonatomic) BOOL checked;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic, strong) UIButton *backButton;

- (void)pushToComplete;
- (void)pushTagsSelect;

@end
