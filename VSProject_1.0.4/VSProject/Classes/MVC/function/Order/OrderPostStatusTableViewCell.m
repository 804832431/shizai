//
//  orderPostStatusTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import "OrderPostStatusTableViewCell.h"
#import "UIColor+TPCategory.h"

@implementation OrderPostStatusTableViewCell

- (UILabel *)vTopLineView{
    
    if (_vTopLineView == nil) {
        _vTopLineView = [UILabel new];
        _vTopLineView.backgroundColor = [UIColor colorFromHexRGB:@"c9caca"];
    }
    
    return _vTopLineView;
}

- (UILabel *)vBottomLineView{
    
    if (_vBottomLineView == nil) {
        _vBottomLineView = [UILabel new];
        _vBottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"c9caca"];
    }
    
    return _vBottomLineView;
}

- (UIImageView *)vImageVIew{
    
    if (_vImageVIew == nil) {
        _vImageVIew = [UIImageView new];
        _vImageVIew.layer.cornerRadius = 5;
        _vImageVIew.layer.masksToBounds = YES;
        _vImageVIew.backgroundColor = [UIColor colorFromHexRGB:@"949494"];
    }
    
    return _vImageVIew;
}



- (UILabel *)orderStatusTitle{
    
    if (_orderStatusTitle == nil) {
        _orderStatusTitle = [UILabel new];
        _orderStatusTitle.font = [UIFont systemFontOfSize:13.0];
        _orderStatusTitle.textColor = [UIColor colorFromHexRGB:@"949494"];
    }
    
    return _orderStatusTitle;
}

- (UILabel *)orderStatusTime{
    
    if (_orderStatusTime == nil) {
        _orderStatusTime = [UILabel new];
        _orderStatusTime.font = [UIFont systemFontOfSize:12.0];
        _orderStatusTime.textColor = [UIColor colorFromHexRGB:@"949494"];
    }
    return _orderStatusTime;
}

- (UILabel *)bottomLineView{
    
    if (_bottomLineView == nil) {
        
        _bottomLineView = [UILabel new];
        _bottomLineView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    
    return _bottomLineView;
}

#pragma mark -

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.vTopLineView];
        [self.contentView addSubview:self.vImageVIew];
        [self.contentView addSubview:self.vBottomLineView];
        [self.contentView addSubview:self.orderStatusTitle];
        [self.contentView addSubview:self.orderStatusTime];
        [self.contentView addSubview:self.bottomLineView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updateConstraintsForSubviews];
    }
  
    
    return self;
}


- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.vImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(33);
        make.top.equalTo(weakSelf.contentView).offset(22);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    [self.vTopLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.vImageVIew);
        make.top.equalTo(weakSelf.contentView);
        make.bottom.equalTo(weakSelf.vImageVIew.mas_top);
        make.width.equalTo(@1);
        
    }];
    
    
    
    [self.vBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.vImageVIew);
        make.top.equalTo(weakSelf.vImageVIew.mas_bottom);
        make.bottom.equalTo(weakSelf.contentView);
        make.width.equalTo(@1);
        
    }];
    
    [self.orderStatusTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.vImageVIew.mas_trailing).offset(38);
        make.centerY.equalTo(weakSelf.vImageVIew);
        
    }];
    
    [self.orderStatusTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.orderStatusTitle);
        make.top.equalTo(weakSelf.orderStatusTitle.mas_bottom).offset(10);
        
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weakSelf.orderStatusTitle);
        make.bottom.trailing.equalTo(weakSelf.contentView).offset(-16);
        make.height.mas_equalTo(RETINA_1PX);
        
    }];
    
}


#pragma mark -

- (void)setIsLastCell:(BOOL)isLastCell{
    _isLastCell = isLastCell;
    
    __weak typeof(&*self) weakSelf = self;
    
    if (isLastCell) {
        
        [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(weakSelf.contentView);
            make.bottom.trailing.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(RETINA_1PX);
        }];
        
        weakSelf.vBottomLineView.hidden = YES;
        
    }else{
        
        [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(weakSelf.orderStatusTitle);
            make.trailing.equalTo(weakSelf.contentView).offset(-16);
            make.bottom.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(RETINA_1PX);
        }];
        weakSelf.vBottomLineView.hidden = NO;
    }
    
    
}

- (void)setIsFirstCell:(BOOL)isFirstCell{
    
    _isLastCell = isFirstCell;
    
    if (isFirstCell) {
        self.vTopLineView.hidden = YES;
        self.vImageVIew.backgroundColor = [UIColor colorFromHexRGB:@"35b38d"];
        
    }else{
        
        self.vTopLineView.hidden = NO;
        self.vImageVIew.backgroundColor = [UIColor colorFromHexRGB:@"949494"];
    }
}

@end
