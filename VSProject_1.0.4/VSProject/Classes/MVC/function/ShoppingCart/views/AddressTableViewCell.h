//
//  AddressTableViewCell.h
//  114IOS
//
//  Created by 陈海涛 on 15/11/14.
//  Copyright © 2015年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdressModel.h"

@interface AddressTableViewCell : UITableViewCell

@property (nonatomic,strong) AdressModel *address;

@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic,strong) UIImageView *contactImageView;

@property (nonatomic,strong) UILabel *contactName;

@property (nonatomic,strong) UILabel *addressName;

@property (nonatomic,strong) UILabel *contactNameLabel;

@property (nonatomic,strong) UIImageView *phoneImageView;

@property (nonatomic,strong) UILabel *phoneLabel;

@property (nonatomic,strong) UILabel *addressLabel;

@property (nonatomic,strong) UIImageView *detailImageView;

@property (nonatomic,strong) NSString *orderTypeId;//订单类型id

@end
