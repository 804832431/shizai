//
//  RequestBackDepositTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/11/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BidProject.h"

@interface RequestBackDepositTableViewCell : UITableViewCell

@property (nonatomic,strong) BidProject *dto;

@property (nonatomic,strong) UIView *contentBackgroundView;//整个背景视图

@property (nonatomic,strong) UIView *bottomContentBackgroundView;//底部背景视图

@property (nonatomic,strong) UIView *topLieView;

@property (nonatomic,strong) UILabel *bidDespoitCallbackStatusLabel;//退款状态

@property (nonatomic,strong) UILabel *bidNameLabel;

@property (nonatomic,strong) UILabel *bidDespoitLabel;//保证金额

@property (nonatomic,strong) UILabel *payTitleLabel;//支付金额提示、

@property (nonatomic,strong) UILabel *payLabel;//支付金额

@end











































