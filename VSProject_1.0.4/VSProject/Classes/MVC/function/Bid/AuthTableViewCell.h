//
//  AuthTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthHistoryDTO.h"

@interface AuthTableViewCell : UITableViewCell

@property (nonatomic,strong) AuthHistoryDTO *dto;

@property (nonatomic,strong) UILabel *contentTitleLabel;

@property (nonatomic,strong) UILabel *enterpriseName;
@property (nonatomic,strong) UILabel *enterpriseLegalPerson;
@property (nonatomic,strong) UILabel *contactName;
@property (nonatomic,strong) UILabel *contactNumber;
@property (nonatomic,strong) UILabel *enterpriseIdentity;

@property (nonatomic,strong) UIView *sepLineView;

@property (nonatomic,strong) UILabel *resultTileLabel;
@property (nonatomic,strong) UILabel *resultContentLabel;
@property (nonatomic,strong) UIImageView *resultImageView;



@property (nonatomic,strong) UILabel *processTime;
@property (nonatomic,strong) UILabel *rejectReason;

@property (nonatomic,strong) UIView *bgView;


@property (nonatomic,strong) UILabel *enterpriseNameContent;
@property (nonatomic,strong) UILabel *enterpriseLegalPersonContent;
@property (nonatomic,strong) UILabel *contactNameContent;
@property (nonatomic,strong) UILabel *contactNumberContent;
@property (nonatomic,strong) UILabel *enterpriseIdentityContent;
@property (nonatomic,strong) UILabel *processTimeContent;
@property (nonatomic,strong) UILabel *rejectReasonContent;



@end
