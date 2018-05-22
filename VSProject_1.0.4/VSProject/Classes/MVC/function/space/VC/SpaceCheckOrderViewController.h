//
//  SpaceCheckOrderViewController.h
//  VSProject
//
//  Created by pangchao on 17/1/9.
//  Copyright © 2017年 user. All rights reserved.
//

#import "VSBaseTableViewController.h"
#import "ShoppingCartInfoDTO.h"
#import "CartItemDTO.h"
#import "CategoryDTO.h"
#import "ProductDTO.h"
#import "SendTimeChooseView.h"

@interface SpaceCheckOrderViewController : VSBaseTableViewController

@property (nonatomic,assign) BOOL fromShoppingCart;

@property (nonatomic,weak) void (^chooseTimeBlock)(NSString *time);

@property (nonatomic,strong) SendTimeChooseView *sendTimeChooseView;

@property (nonatomic,strong) ShoppingCartInfoDTO *shoppingCartInfo;

@property (nonatomic,strong) CategoryDTO *selectedCategoryDTO;

@property (nonatomic,strong) NSMutableArray *selectedProductDTOList;


@property (nonatomic,strong)NSString *orderDemand;

@end
