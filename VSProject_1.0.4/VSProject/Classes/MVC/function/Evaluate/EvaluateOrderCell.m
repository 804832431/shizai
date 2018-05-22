//
//  EvaluateOrderCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "EvaluateOrderCell.h"

@implementation EvaluateOrderCell

-  (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = _Colorhex(0x494949);
        _contentLabel.text = @"请您对本次服务做一个总体评价：";
        _contentLabel.frame = CGRectMake(12, 25, [UIScreen mainScreen].bounds.size.width, 20);
    }
    return _contentLabel;
}


- (CWStarRateView *)starView{
    if (_starView == nil) {
        _starView = [[CWStarRateView alloc] initWithFrame:CGRectMake((MainWidth - 225) /2, 55, 225, 40) numberOfStars:5];
        _starView.delegate = self;
    }
    return _starView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.starView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return self;
}

#pragma mark - delegate method
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    
    if (self.starBlock) {
        self.starBlock(newScorePercent * 5);
    }
    
}

@end












