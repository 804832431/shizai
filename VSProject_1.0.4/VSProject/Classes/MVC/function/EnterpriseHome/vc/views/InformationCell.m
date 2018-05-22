//
//  InformationCell.m
//  VSProject
//
//  Created by certus on 15/11/3.
//  Copyright © 2015年 user. All rights reserved.
//

#import "InformationCell.h"

@implementation InformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _headImageView = [[UIImageView alloc]init];
        _headImageView.backgroundColor = _COLOR_CLEAR;
        _headImageView.layer.borderColor = _COLOR_HEX(0xdbdbdb).CGColor;
        _headImageView.layer.borderWidth = 1.f;
        _headImageView.layer.cornerRadius = 5;
        _headImageView.clipsToBounds = YES;
        [self addSubview:_headImageView];
        [_headImageView setHidden:YES];

        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(50/3, 0, 80, 150/3)];
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.textAlignment =NSTextAlignmentLeft;
        _leftLabel.textColor = _COLOR_HEX(0x222222);
        _leftLabel.font = FONT_TITLE(15);
        [self addSubview:_leftLabel];

        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth-80/3-7-200, 0, 200, 150/3)];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.textAlignment =NSTextAlignmentRight;
        _rightLabel.textColor = _COLOR_HEX(0x666666);
        _rightLabel.font = FONT_TITLE(15);
        [self addSubview:_rightLabel];

        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MainWidth-50/3-7, (144/3-13)/2, 7, 13)];
        _arrow.image = [UIImage imageNamed:@"usercenter_08"];
        _arrow.backgroundColor = _COLOR_CLEAR;
        [self addSubview:_arrow];

        //line
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,MainWidth, 1)];
        line.backgroundColor = _COLOR_HEX(0xdbdbdb);
        [self addSubview:line];
        
        //line
        _bottomline = [[UILabel alloc] init];
        _bottomline.backgroundColor = _COLOR_HEX(0xdbdbdb);
        [self addSubview:_bottomline];
        [_bottomline setHidden:YES];

    }
    
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _bottomline.frame = CGRectMake(0, GetHeight(self)-1, MainWidth, 1);
    _headImageView.frame = CGRectMake(MainWidth-80/3-7-50, GetHeight(self)/2-50/2, 50, 50);
    _arrow.frame = CGRectMake(MainWidth-50/3-7, (GetHeight(self)-13)/2, 7, 13);

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
