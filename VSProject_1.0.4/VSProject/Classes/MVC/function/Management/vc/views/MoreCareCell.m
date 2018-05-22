//
//  MoreCareCell.m
//  EmperorComing
//
//  Created by certus on 15/8/19.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import "MoreCareCell.h"

@implementation MoreCareCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _selectedCare = NO;
        
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.userInteractionEnabled = NO;
        [_checkButton setImage:[UIImage imageNamed:@"weixuanzh"] forState:UIControlStateNormal];
        _checkButton.frame = CGRectMake(20, (self.bounds.size.height-30)/2, 30, 30);
        [self.contentView addSubview:_checkButton];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, (self.bounds.size.height-30)/2, 200, 30)];
        _nameLabel.numberOfLines = 2;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_nameLabel];

    }
    return  self;
}

- (void)setSelectedCare:(BOOL)selectedCare {

    _selectedCare = selectedCare;
    NSLog(@"_selectedCare=%d",_selectedCare);
    if (selectedCare) {
        [_checkButton setImage:[UIImage imageNamed:@"xuanzh"] forState:UIControlStateNormal];
    }else {
        [_checkButton setImage:[UIImage imageNamed:@"weixuanzh"] forState:UIControlStateNormal];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
