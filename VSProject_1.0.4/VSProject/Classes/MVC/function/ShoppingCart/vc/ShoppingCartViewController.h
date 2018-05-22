//
//  ShoppingCartViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseTableViewController.h"
#import "ShoppingCartShopTableViewCell.h"
#import "ShoppingCartProductTableViewCell.h"
#import "ShoppingCartBottomView.h"
#import "CheckOrderViewController.h"

@interface ShoppingCartViewController : VSBaseTableViewController<UIAlertViewDelegate>


@property (nonatomic,strong) ShoppingCartBottomView *bottomView;


@end
