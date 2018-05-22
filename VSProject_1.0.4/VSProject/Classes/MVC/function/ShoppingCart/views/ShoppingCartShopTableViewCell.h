//
//  ShoppingCartShopTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryDTO.h"
#import "ProductDTO.h"

@class ShoppingCartShopTableViewCell;



typedef void (^ShoppingCartShopTableViewCellChooseBlock)(ShoppingCartShopTableViewCell *cell);

@interface ShoppingCartShopTableViewCell : UITableViewCell

@property (nonatomic,weak)CategoryDTO *selectedCategoryDTO;

@property (nonatomic,weak)NSMutableArray *selectedProductDTOList;

@property (nonatomic,strong) CategoryDTO *data;

@property (copy,nonatomic) ShoppingCartShopTableViewCellChooseBlock block;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;

@end
