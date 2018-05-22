//
//  OrderDetailProductTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "OrderDetailProductTableViewCell.h"
#import "UIColor+TPCategory.h"

@implementation OrderDetailProductTableViewCell

- (UIImageView *)productImageView{
    
    if (_productImageView == nil) {
        _productImageView = [UIImageView new];
        _productImageView.image = [UIImage imageNamed:@""];
        _productImageView.layer.masksToBounds = YES;
        _productImageView.layer.cornerRadius = 6;
        _productImageView.layer.borderColor = [[UIColor colorFromHexRGB:@"dbdbdb"] CGColor];
        _productImageView.layer.borderWidth = 1;
    }
    
    return _productImageView;
}

- (UILabel *)productName{
    
    if (_productName == nil) {
        _productName = [UILabel new];
        _productName.font = [UIFont systemFontOfSize:12];
        _productName.textColor = [UIColor colorFromHexRGB:@"343434"];
    }
    
    return _productName;
}

- (UILabel *)productPrice{
    
    if (_productPrice == nil) {
        _productPrice = [UILabel new];
        _productPrice.font = [UIFont systemFontOfSize:10];
        _productPrice.textColor = [UIColor colorFromHexRGB:@"343434"];
    }
    
    return _productPrice;
}

- (UILabel *)productCount{
    
    if (_productCount == nil) {
        _productCount = [UILabel new];
        _productCount.font = [UIFont systemFontOfSize:12];
        _productCount.textColor = [UIColor colorFromHexRGB:@"343434"];
    }
    
    return _productCount;
}

- (UILabel *)bottomView{
    
    if (_bottomView == nil) {
        _bottomView = [UILabel new];
        _bottomView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
        
    }
    
    return _bottomView;
}

- (UILabel *)firstTopView{
    
    if (_firstTopView == nil) {
        _firstTopView = [UILabel new];
        _firstTopView.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    
    return _firstTopView;
}

- (UILabel *)productAttributelabel{
    if (_productAttributelabel == nil) {
        _productAttributelabel = [UILabel new];
        _productAttributelabel.font = [UIFont systemFontOfSize:13];
        _productAttributelabel.textColor = [UIColor colorFromHexRGB:@"7c7c7c"];
    }
    return _productAttributelabel;
}

#pragma mark -

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.productName];
        [self.contentView addSubview:self.productImageView];
        [self.contentView addSubview:self.productPrice];
        [self.contentView addSubview:self.productCount];
        [self.contentView addSubview:self.bottomView];
        [self.contentView addSubview:self.firstTopView];
        [self.contentView addSubview:self.productAttributelabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self updateConstraintsForSubviews];
    }
    
    
    return self;
}

- (void)setProdcut:(OrderProduct *)prodcut{
    
    _prodcut = prodcut;
    
    self.productName.text = prodcut.productName;
    if (prodcut.productAttribute.length > 0) {
        self.productCount.text = [NSString stringWithFormat:@"   x %@",prodcut.quantity];
    }else{
        self.productCount.text = [NSString stringWithFormat:@"x %@",prodcut.quantity];
    }
    
    //    self.productCount.text = [NSString stringWithFormat:@"x %@",prodcut.quantity];
    self.productName.text = [NSString stringWithFormat:@"%@",prodcut.productName];
    self.productPrice.text = [NSString stringWithFormat:@"¥ %@",prodcut.unitPrice];
    //    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PIC_SERVER_IP,prodcut.smallImageUrl]] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"]];
    
    [self.productImageView sd_setImageWithString:[NSString stringWithFormat:@"%@",prodcut.smallImageUrl] placeholderImage:[UIImage  imageNamed:@"usercenter_defaultpic"]];
    self.productAttributelabel.text = prodcut.productAttribute;
}


- (void)updateConstraintsForSubviews{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.firstTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.height.mas_equalTo(46);
    }];
    
    [self.productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.productImageView.mas_trailing).offset(13);
        make.top.equalTo(weakSelf.productImageView);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
    }];
    
    [self.productAttributelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.productName);
        make.top.equalTo(weakSelf.productName.mas_bottom).offset(10);
    }];
    
    [self.productCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.productAttributelabel.mas_trailing);
        make.top.equalTo(weakSelf.productName.mas_bottom).offset(10);
    }];
    
    [self.productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        make.height.mas_equalTo(RETINA_1PX);
    }];
    
    
}

@end
