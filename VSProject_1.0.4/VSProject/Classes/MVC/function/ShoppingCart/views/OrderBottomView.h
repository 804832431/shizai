//
//  OrderBottomView.h
//  114IOS
//
//  Created by 陈海涛 on 15/11/14.
//  Copyright © 2015年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBottomView : UIView

@property (nonatomic,copy) void (^goToPayBlock)(void);

@property (nonatomic,strong) UILabel *totalLabel;

@property (nonatomic,strong) UILabel *totalMoney;

@property (nonatomic,strong) UIButton *okButton;

@end
