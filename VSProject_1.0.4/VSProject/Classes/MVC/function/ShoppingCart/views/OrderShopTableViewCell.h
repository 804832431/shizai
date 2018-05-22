//
//  OrderShopTableViewCell.h
//  114IOS
//
//  Created by 陈海涛 on 15/11/14.
//  Copyright © 2015年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartInfoDTO.h"
#import "CartItemDTO.h"

@interface OrderShopTableViewCell : UITableViewCell

@property (nonatomic,strong) ShoppingCartInfoDTO *cartInfoDTO;

@property (nonatomic,strong) UILabel *topLineView;

@property (nonatomic,strong) UILabel *shopName;

@property (nonatomic,strong) UILabel *bottomLineView;

@end
