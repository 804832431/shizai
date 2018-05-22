//
//  AddressCell.m
//  VSProject
//
//  Created by certus on 15/11/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "AddressCell.h"
#import "AdressModel.h"

@implementation AddressCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:_COLOR_HEX(0xf1f1f1)];
    
    _nameLabel.numberOfLines = 0;
    _phoneLabel.numberOfLines = 0;
    _phoneLabel.textAlignment = NSTextAlignmentRight;
    _adressLabel.numberOfLines = 0;
    [self vm_showBottonLine:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)vp_setInit
{
    [super vp_setInit];
    //TODO：设置样式

}


- (void)vp_updateUIWithModel:(id)model
{
    
    //TODO：更新UI
    if ([model isKindOfClass:[NSDictionary class]]) {
        NSDictionary *admodel = (NSDictionary *)model;
        if ([[admodel objectForKey:@"recipient"] isEqual:[NSNull null]] || ![admodel objectForKey:@"recipient"]) {
            _nameLabel.text = @"";
        }else {
            _nameLabel.text = [admodel objectForKey:@"recipient"];
        }
        if ([[admodel objectForKey:@"contactNumber"] isEqual:[NSNull null]] || ![admodel objectForKey:@"contactNumber"]) {
            _phoneLabel.text = @"";
        }else {
            _phoneLabel.text = [admodel objectForKey:@"contactNumber"];
        }
        if ([[admodel objectForKey:@"zipCode"] isEqual:[NSNull null]] || ![admodel objectForKey:@"zipCode"]) {
            _adressLabel.text = @"";
        }else {
            _adressLabel.text = [admodel objectForKey:@"zipCode"];
        }

        if ([[admodel objectForKey:@"address"] isEqual:[NSNull null]] || ![admodel objectForKey:@"address"]) {
            _adressLabel.text = @"";
        }else {
            _adressLabel.text = [NSString stringWithFormat:@"%@%@",_adressLabel.text,[admodel objectForKey:@"address"]];
        }
        if ([[admodel objectForKey:@"isDefault"] isEqual:[NSNull null]] || ![admodel objectForKey:@"isDefault"] || [[admodel objectForKey:@"isDefault"] isEqualToString:@"N"]) {
            [_defaultButton setImage:[UIImage imageNamed:@"adress_default"] forState:0];
        }else {
            
            [_defaultButton setImage:[UIImage imageNamed:@"adress_default_setted"] forState:0];
            [_deleteButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).with.offset(5);
                make.top.equalTo(self.mas_top);
                make.width.equalTo(@0);
                make.height.equalTo(@0);
            }];

        }
    }
}

@end
