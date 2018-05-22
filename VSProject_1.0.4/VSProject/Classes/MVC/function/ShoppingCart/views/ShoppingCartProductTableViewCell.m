//
//  ShoppingCartProductTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/12.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ShoppingCartProductTableViewCell.h"
#import "UIColor+TPCategory.h"

@implementation ShoppingCartProductTableViewCell


- (UILabel *)bottomLineView{
    
    if (_bottomLineView == nil) {
        _bottomLineView = [[UILabel alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"虚线分割线1"]];
    }
    
    return _bottomLineView;
}

- (UILabel *)lastBottomLineview{
    
    if (_lastBottomLineview == nil) {
        _lastBottomLineview = [UILabel new];
        _lastBottomLineview.backgroundColor = [UIColor colorFromHexRGB:@"dbdbdb"];
    }
    
    return _lastBottomLineview;
}

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.contentImageView.layer.masksToBounds = YES;
    self.contentImageView.layer.cornerRadius = 6;
    self.contentImageView.layer.borderColor = [[UIColor colorFromHexRGB:@"DBDBDB"] CGColor];
    self.contentImageView.layer.borderWidth = 1;
    
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.lastBottomLineview];
    
    __weak typeof(&*self)weakSelf = self;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(weakSelf.contentView).offset(-1);
        make.height.mas_equalTo(1);
        make.leading.equalTo(weakSelf.contentView).offset(16);
        make.trailing.equalTo(weakSelf.contentView).offset(-16);
        
    }];
    
    [self.lastBottomLineview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.trailing.bottom.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(RETINA_1PX);
        
    }];
    
}

- (IBAction)chooseAction:(id)sender {
    
    if (self.block) {
        self.block(self);
    }
    
}

- (void)setData:(ProductDTO *)data{
    _data = data;
    
    self.contentTitle.text = data.productName;
    self.contentPrice.text = [NSString stringWithFormat:@"¥ %@",data.unitPrice];
    //    [self.contentImageView sd_setImageWithString:[NSString stringWithFormat:@"%@%@",PIC_SERVER_IP,data.smallImageUrl] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"]];
    [self.contentImageView sd_setImageWithString:[NSString stringWithFormat:@"%@",data.smallImageUrl] placeholderImage:[UIImage imageNamed:@"usercenter_defaultpic"]];
    [self.productNum setTitle:data.quantity forState:UIControlStateNormal];
    [self.productNum setTitleColor:[UIColor colorFromHexRGB:@"999999"] forState:UIControlStateNormal];
    
    
    if (self.selectedCategoryDTO == nil && self.selectedProductDTOList.count == 0) {
        self.chooseImageView.image = [UIImage imageNamed:@"全选"];
    }else if ([self.selectedProductDTOList containsObject:data]) {
        self.chooseImageView.image = [UIImage imageNamed:@"完成"];
    }else if([self.categoryDTO.categoryId isEqualToString:self.selectedCategoryDTO.categoryId]){
        self.chooseImageView.image = [UIImage imageNamed:@"全选"];
    }else{
        self.chooseImageView.image = [UIImage imageNamed:@"全选（不能）"];
    }
}

- (IBAction)reductionAction:(id)sender {
    if (self.reductionBlock) {
        self.reductionBlock(self.data);
    }
}

- (IBAction)addAction:(id)sender {
    
    if (self.addBlock) {
        self.addBlock(self.data);
    }
}
@end
