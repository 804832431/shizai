//
//  RTXAppointmentViewController.h
//  VSProject
//
//  Created by XuLiang on 15/11/27.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseTableViewController.h"
#import "SendTimeChooseView.h"
#import "ShoppingCartInfoDTO.h"
#import "CartItemDTO.h"
#import "CategoryDTO.h"
#import "ProductDTO.h"

@interface RTXAppointmentViewController : VSBaseTableViewController

@property (nonatomic,weak) void (^chooseTimeBlock)(NSString *time);

@property (nonatomic,strong) SendTimeChooseView *sendTimeChooseView;

@property (nonatomic,strong) ShoppingCartInfoDTO *shoppingCartInfo;

@property (nonatomic,strong) CategoryDTO *selectedCategoryDTO;

@property (nonatomic,strong) NSMutableArray *selectedProductDTOList;
@end
