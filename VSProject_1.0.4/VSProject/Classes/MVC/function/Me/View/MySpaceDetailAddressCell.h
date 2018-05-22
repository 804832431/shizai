//
//  MySpaceDetailAddressCell.h
//  VSProject
//
//  Created by pangchao on 17/1/9.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Order;

@interface MySpaceDetailAddressCell : UITableViewCell

@property (nonatomic,strong) Order *order;

@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic,strong) UIImageView *contactImageView;

@property (nonatomic,strong) UILabel *contactNameLabel;

@property (nonatomic,strong) UIImageView *phoneImageView;

@property (nonatomic,strong) UILabel *phoneLabel;

@property (nonatomic,strong) UILabel *contactName;

@end
