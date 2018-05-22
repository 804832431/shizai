//
//  OrderDetailProductTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderProduct.h"

@interface OrderDetailProductTableViewCell : UITableViewCell

@property (nonatomic,strong) OrderProduct *prodcut;

@property (nonatomic,strong) UIImageView *productImageView;

@property (nonatomic,strong) UILabel *productName;

@property (nonatomic,strong) UILabel *productPrice;

@property (nonatomic,strong) UILabel *productCount;

@property (nonatomic,strong) UILabel *bottomView;

@property (nonatomic,strong) UILabel *firstTopView;

@property (nonatomic,strong) UILabel *productAttributelabel;

@end
