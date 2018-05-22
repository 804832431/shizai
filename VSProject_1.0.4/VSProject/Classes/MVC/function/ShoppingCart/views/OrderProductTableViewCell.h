//
//  OrderProductTableViewCell.h
//  114IOS
//
//  Created by 陈海涛 on 15/11/14.
//  Copyright © 2015年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartItemDTO.h"
#import "ProductDTO.h"

@interface OrderProductTableViewCell : UITableViewCell

@property (nonatomic,strong) CartItemDTO *cartItemDTO;

@property (nonatomic,strong) ProductDTO *productDTO;

@property (nonatomic,strong) UIImageView *productImageView;

@property (nonatomic,strong) UILabel *productName;

@property (nonatomic,strong) UILabel *productPrice;

@property (nonatomic,strong) UILabel *productCount;

@property (nonatomic,strong) UILabel *bottomView;

@property (nonatomic,strong) UILabel *lastBottomView;

@property (nonatomic,strong) UILabel *productAttributelabel;

@property (nonatomic, assign) NSInteger orderType; // 0:其他订单; 1:空间订单

@end
