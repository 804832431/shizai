//
//  ShoppingCartShopTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/11.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ShoppingCartShopTableViewCell.h"

@implementation ShoppingCartShopTableViewCell

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}


- (IBAction)chooseAction:(id)sender {
    if (self.block) {
        self.block(self);
    }
}

- (void)setData:(CategoryDTO *)data{
    _data = data;
    
    self.shopNameLabel.text = data.categoryName;
    
    if (self.selectedCategoryDTO == nil && self.selectedProductDTOList.count == 0) {
         self.chooseImageView.image = [UIImage imageNamed:@"全选"];
    }else if ([self.selectedCategoryDTO.categoryId isEqualToString:data.categoryId] && self.selectedProductDTOList.count == data.prodsList.count) {
        self.chooseImageView.image = [UIImage imageNamed:@"完成"];
    }else if([self.selectedCategoryDTO.categoryId isEqualToString:data.categoryId]){
        self.chooseImageView.image = [UIImage imageNamed:@"全选"];
    }else{
        self.chooseImageView.image = [UIImage imageNamed:@"全选（不能）"];
    }
}

@end
