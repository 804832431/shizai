//
//  RefundOrdersTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderProduct.h"
#import "Order.h"

@interface RefundOrdersProductTableViewCell : UITableViewCell


@property (nonatomic,strong) Order  *order;

@property (nonatomic,strong) UIImageView *productImageView;

@property (nonatomic,strong) UILabel *productName;

@property (nonatomic,strong) UILabel *storeName;

@property (nonatomic,strong) UILabel *orderPrice;

@property (nonatomic,strong) UILabel *outOrderPrice;

@property (nonatomic,strong) UILabel *orderTime;



//@property (nonatomic,strong) UILabel *productCount;

//@property (nonatomic,strong) UILabel *bottomView;

//@property (nonatomic,strong) UILabel *productAttributelabel;


@end
