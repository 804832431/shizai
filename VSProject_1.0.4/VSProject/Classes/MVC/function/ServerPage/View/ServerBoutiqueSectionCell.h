//
//  ServerBoutiqueSectionCell.h
//  VSProject
//
//  Created by pch_tiger on 16/12/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ServerProductDTO;

typedef enum {
    
    CELLTYPE_BOUTIQUE = 0,
    CELLTYPE_LIST = 1,
} SERVER_CELL_TYPE;

@interface ServerBoutiqueSectionCell : UITableViewCell

@property (nonatomic, strong) UIImageView *adImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *companyLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *orderNumLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) SERVER_CELL_TYPE type;

- (void)setData:(ServerProductDTO *)dto;

@end
