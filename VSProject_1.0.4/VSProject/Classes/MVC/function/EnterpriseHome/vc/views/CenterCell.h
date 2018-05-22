//
//  CenterCell.h
//  VSProject
//
//  Created by certus on 15/11/2.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterButton.h"
#import "TopButton.h"

typedef NS_ENUM(NSInteger,CenterCellType) {
    
    OrderCell = 0,
    SubscribeCell = 1,
    ShoppingCartCell = 2,
    AdressCell = 3,

};


@interface CenterCell : UITableViewCell

_PROPERTY_NONATOMIC_STRONG(TopButton, topButton)
_PROPERTY_NONATOMIC_STRONG(CenterButton, button1)
_PROPERTY_NONATOMIC_STRONG(CenterButton, button2)
_PROPERTY_NONATOMIC_STRONG(CenterButton, button3)
_PROPERTY_NONATOMIC_STRONG(CenterButton, button4)
//_PROPERTY_NONATOMIC_STRONG(UILabel, bottomLabel)
_PROPERTY_NONATOMIC_STRONG(NSArray, picArray)
_PROPERTY_NONATOMIC_STRONG(NSArray, nameArray)
_PROPERTY_NONATOMIC_STRONG(NSArray, superscriptArray)
_PROPERTY_NONATOMIC_ASSIGN(CenterCellType, celltype)

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier cellType:(CenterCellType)cellType;

@end
