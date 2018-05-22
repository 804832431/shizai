//
//  OrderSumAndDiscountTableViewCell.h
//  114IOS
//
//  Created by 陈海涛 on 15/11/14.
//  Copyright © 2015年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartInfoDTO.h"

@interface OrderSumAndDiscountTableViewCell : UITableViewCell<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) ShoppingCartInfoDTO *shoppingCartInfoDTO;

@property (nonatomic,copy) void (^remarkBlock)(NSString *remark);

@property (nonatomic,copy) void (^couponBlock)(void);

@property (nonatomic,strong) UILabel *discountLabel;

@property (nonatomic,strong) UILabel *couponLabel;

@property (nonatomic,strong) UIImageView *descImageView;

@property (nonatomic,strong) UITextView *messageTextView;

@property (nonatomic,strong) UILabel *totalLabel;

@property (nonatomic,strong) UILabel *totalMoney;

@property (nonatomic,strong) UILabel *postMoney;//运费

@property (nonatomic,strong) UILabel *bottomLineView;

@property (nonatomic,strong) NSString *orderTypeId;//订单类型id

@property (nonatomic,strong) UILabel *remarkTitleLabel;

@property (nonatomic,strong)NSString *orderDemand;
@end
