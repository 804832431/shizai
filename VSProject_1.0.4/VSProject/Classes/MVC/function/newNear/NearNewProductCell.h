//
//  NearNewProductCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/7/29.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearNewProduct.h"

@interface NearNewProductCell : UITableViewCell

@property (nonatomic,strong)UIView *bottomLineView;

@property (nonatomic,strong)UIImageView *prodcutView;

@property (nonatomic,strong)UILabel *descriptionLabel;

@property (nonatomic,strong)UILabel *companyLabel;

@property (nonatomic,strong)UILabel *successOrderCountsLabel;

@property (nonatomic,strong)UILabel *priceLabel;

@property (nonatomic,strong)UILabel *oldPriceLabel;

@property (nonatomic,strong)UIView *oldAddLineView;

@property (nonatomic,strong)UILabel *scoreLabel;

@property (nonatomic,strong)NSArray *promotionTypeImageViews;//优惠 折  减  送 免

@property (nonatomic,strong)UIView *promotionTypebackgroundView;

@property (nonatomic,strong)UIView *starView;//几星等级

@property (nonatomic,strong) NearNewProduct *product;
@end
