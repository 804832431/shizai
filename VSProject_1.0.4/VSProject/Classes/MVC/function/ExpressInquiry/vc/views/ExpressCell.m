//
//  ExpressCell.m
//  VSProject
//
//  Created by certus on 15/12/1.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ExpressCell.h"

@implementation ExpressCell

- (void)awakeFromNib {
    // Initialization code
    _titleLabel.numberOfLines = 0;
}

- (void)vp_updateUIWithModel:(id)model {

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
