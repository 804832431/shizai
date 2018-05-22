//
//  CheckOrderViewController.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/14.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseTableViewController.h"
#import "SendTimeChooseView.h"
#import "ShoppingCartInfoDTO.h"
#import "CartItemDTO.h"
#import "CategoryDTO.h"
#import "ProductDTO.h"

@interface CheckOrderViewController : VSBaseTableViewController

@property (nonatomic,assign) BOOL fromShoppingCart;

@property (nonatomic,weak) void (^chooseTimeBlock)(NSString *time);

@property (nonatomic,strong) SendTimeChooseView *sendTimeChooseView;

@property (nonatomic,strong) ShoppingCartInfoDTO *shoppingCartInfo;

@property (nonatomic,strong) CategoryDTO *selectedCategoryDTO;

@property (nonatomic,strong) NSMutableArray *selectedProductDTOList;


@property (nonatomic,strong)NSString *orderDemand;


@end
