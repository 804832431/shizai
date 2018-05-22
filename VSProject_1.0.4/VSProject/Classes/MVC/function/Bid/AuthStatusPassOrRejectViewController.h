//
//  AuthStatusPassOrRejectViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "BidProject.h"
#import "AuthHistoryDTO.h"
#import "AuthStatusView.h"
#import "AuthedEnterprise.h"

@interface AuthStatusPassOrRejectViewController : VSBaseViewController

@property (nonatomic,strong) AuthStatusView *statusView;

@property (nonatomic,strong) UILabel *contentTitleLabel;

@property (nonatomic,strong) UILabel *enterpriseName;
@property (nonatomic,strong) UILabel *enterpriseLegalPerson;
@property (nonatomic,strong) UILabel *contactName;
@property (nonatomic,strong) UILabel *contactNumber;
@property (nonatomic,strong) UILabel *enterpriseIdentity;
@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UILabel *enterpriseNameContent;
@property (nonatomic,strong) UILabel *enterpriseLegalPersonContent;
@property (nonatomic,strong) UILabel *contactNameContent;
@property (nonatomic,strong) UILabel *contactNumberContent;
@property (nonatomic,strong) UILabel *enterpriseIdentityContent;

@property (nonatomic,strong) UIView *sepLineView;

@property (nonatomic,strong) AuthHistoryDTO *dto;

@property (nonatomic,strong) AuthedEnterprise *data;

- (IBAction)playCall:(id)sender;


@end
