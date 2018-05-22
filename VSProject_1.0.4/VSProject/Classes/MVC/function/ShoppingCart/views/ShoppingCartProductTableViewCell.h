//
//  ShoppingCartProductTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/12.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryDTO.h"
#import "ProductDTO.h"



@interface ShoppingCartProductTableViewCell : UITableViewCell

@property (nonatomic,weak)CategoryDTO *selectedCategoryDTO;

@property (nonatomic,weak)NSMutableArray *selectedProductDTOList;

@property (nonatomic,strong) ProductDTO *data;

@property (nonatomic,weak) CategoryDTO *categoryDTO;//data所属的门店

@property (nonatomic,copy) void (^block)(ShoppingCartProductTableViewCell *cell);//选择商品

@property (nonatomic,copy) void(^addBlock)(ProductDTO *product);//添加数量

@property (nonatomic,copy) void(^reductionBlock)(ProductDTO *product);//删除数量

@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentTitle;
@property (weak, nonatomic) IBOutlet UILabel *contentPrice;
@property (weak, nonatomic) IBOutlet UIButton *productNum;
@property (weak, nonatomic) IBOutlet UIButton *reductionButton;
- (IBAction)reductionAction:(id)sender;
- (IBAction)addAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic,strong) UILabel *bottomLineView;
@property (nonatomic,strong) UILabel *lastBottomLineview;

@end
