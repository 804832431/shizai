//
//  MyOrdersProductTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/22.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderProduct.h"

@interface MyOrdersProductTableViewCell : UITableViewCell

@property (nonatomic,strong) OrderProduct *orderProduct;

@property (nonatomic,strong) UIImageView *productImageView;

@property (nonatomic,strong) UILabel *productName;

@property (nonatomic,strong) UILabel *productPrice;

@property (nonatomic,strong) UILabel *productCount;

@property (nonatomic,strong) UILabel *bottomView;

@property (nonatomic,strong) UILabel *productAttributelabel;


@end
