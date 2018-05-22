//
//  ShoppingCartBottomView.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/12.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ShoppingCartBottomView.h"

@implementation ShoppingCartBottomView

- (void)awakeFromNib{
    
    self.clearButton.layer.masksToBounds = YES;
    self.clearButton.layer.cornerRadius = 2;
    
}

- (IBAction)clearButtonAction:(id)sender {
    if (self.clearBlock) {
        self.clearBlock();
    }
}

- (IBAction)okAction:(id)sender {
    
    if (self.okBlock) {
        self.okBlock();
    }
}

@end
