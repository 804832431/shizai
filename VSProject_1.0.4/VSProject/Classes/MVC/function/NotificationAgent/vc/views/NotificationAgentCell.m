//
//  NotificationAgentCell.m
//  VSProject
//
//  Created by certus on 16/4/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NotificationAgentCell.h"

@implementation NotificationAgentCell

- (void)awakeFromNib {
    // Initialization code
    _cancelButton.layer.cornerRadius = 5.f;
    _cancelButton.layer.borderColor = _COLOR_HEX(0xc4c4c4).CGColor;
    _cancelButton.layer.borderWidth = 1.f;
    _detailButton.layer.cornerRadius = 5.f;
    _detailButton.layer.borderColor = _COLOR_HEX(0x35b38b).CGColor;
    _detailButton.layer.borderWidth = 1.f;

    [_cancelButton addTarget:self action:@selector(actionCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [_detailButton addTarget:self action:@selector(actionDetailBtn) forControlEvents:UIControlEventTouchUpInside];

}

- (void)actionCancelBtn {

    self.actionCancel();
    
}

- (void)actionDetailBtn {
    
    self.actionDetail();
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
