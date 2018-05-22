//
//  PolicyCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/27.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BPolicyCell.h"

@implementation BPolicyCell

- (UIImageView *)flagImageView{
    if (_flagImageView == nil) {
        _flagImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _flagImageView.contentMode = UIViewContentModeScaleAspectFit;
        _flagImageView.image = [UIImage imageNamed:@"最新政策－news－icon-拷贝"];
    }
    
    return _flagImageView;
}


-  (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = _Colorhex(0x434343);
        
    }
    
    return _contentLabel;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.contentView addSubview:self.flagImageView];
        [self.contentView addSubview:self.contentLabel];
        
        [self updateConstraintsForSubViews];
        
        self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 40 - 20;
    }
    
    return self;
    
}

- (void)updateConstraintsForSubViews{
    
    __weak typeof(self) weakSelf = self;
    
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(20);
        make.centerY.equalTo(weakSelf.contentView);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.flagImageView.mas_trailing).offset(5);
        make.trailing.equalTo(weakSelf.contentView).offset(-20);
        make.top.equalTo(weakSelf.contentView).offset(5);
    }];
}


- (void)setModel:(PolicyModel *)model{
    
    _model = model;
    
    self.contentLabel.text = model.title;
}

@end









