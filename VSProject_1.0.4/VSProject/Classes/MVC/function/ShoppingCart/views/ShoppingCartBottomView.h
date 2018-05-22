//
//  ShoppingCartBottomView.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/12.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartBottomView : UIView

@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@property (weak, nonatomic) IBOutlet UILabel *totalMoney;

@property (nonatomic,copy) void (^clearBlock)(void);

@property (nonatomic,copy) void (^okBlock)(void);

- (IBAction)okAction:(id)sender;

- (IBAction)clearButtonAction:(id)sender;

@end
