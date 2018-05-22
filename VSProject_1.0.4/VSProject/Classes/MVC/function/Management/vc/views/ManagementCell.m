//
//  ManagementCell.m
//  VSProject
//
//  Created by certus on 16/3/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ManagementCell.h"

@implementation ManagementCell

- (void)adjustsubViews {
    
    _m_account.layer.borderColor = _COLOR_HEX(0xcbcbcb).CGColor;
    _m_account.layer.borderWidth = 0.5f;
    _m_name.layer.borderColor = _COLOR_HEX(0xcbcbcb).CGColor;
    _m_name.layer.borderWidth = 0.5f;
    _m_editButton.layer.borderColor = _COLOR_HEX(0xcbcbcb).CGColor;
    _m_editButton.layer.borderWidth = 0.5f;
    _m_deleteButton.layer.borderColor = _COLOR_HEX(0xcbcbcb).CGColor;
    _m_deleteButton.layer.borderWidth = 0.5f;

}

- (void)awakeFromNib {
    // Initialization code
    [self adjustsubViews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
