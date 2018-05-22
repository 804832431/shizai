//
//  AuthTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import "AuthTableViewCell.h"
#import "Masonry.h"

@interface AuthTableViewCell ()

@property (nonatomic,strong) UIView *shadowView;

@end

@implementation AuthTableViewCell

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)contentTitleLabel{
    if (_contentTitleLabel == nil) {
        _contentTitleLabel = [UILabel new];
        _contentTitleLabel.font = [UIFont systemFontOfSize:12];
        _contentTitleLabel.textColor = _Colorhex(0x2f9f7e);
        _contentTitleLabel.text = @"认证信息";
    }
    return _contentTitleLabel;
}

-(UILabel *)enterpriseName{
    if (_enterpriseName == nil) {
        _enterpriseName = [UILabel new];
        _enterpriseName.textColor = _Colorhex(0x444444);
        _enterpriseName.text = @"企业名称";
        _enterpriseName.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseName;
}
- (UILabel *)enterpriseLegalPerson{
    if (_enterpriseLegalPerson == nil) {
        _enterpriseLegalPerson = [UILabel new];
        _enterpriseLegalPerson.textColor = _Colorhex(0x444444);
        _enterpriseLegalPerson.text = @"法人姓名";
        _enterpriseLegalPerson.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseLegalPerson;
}

-(UILabel *)contactName{
    if (_contactName == nil) {
        _contactName = [UILabel new];
        _contactName.textColor = _Colorhex(0x444444);
        _contactName.text = @"联系人";
        _contactName.font = [UIFont systemFontOfSize:12];
    }
    return _contactName;
}
- (UILabel *)contactNumber{
    if (_contactNumber == nil) {
        _contactNumber = [UILabel new];
        _contactNumber.textColor = _Colorhex(0x444444);
        _contactNumber.text = @"联系方式";
        _contactNumber.font = [UIFont systemFontOfSize:12];
    }
    return _contactNumber;
}

- (UILabel *)enterpriseIdentity{
    if (_enterpriseIdentity == nil) {
        _enterpriseIdentity = [UILabel new];
        _enterpriseIdentity.textColor = _Colorhex(0x444444);
        _enterpriseIdentity.text = @"企业工商注册号";
        _enterpriseIdentity.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseIdentity;
}

-(UIView *)sepLineView{
    if (_sepLineView == nil) {
        _sepLineView = [UIView new];
        _sepLineView.backgroundColor = _Colorhex(0xc5c5c5);
    }
    return _sepLineView;
}

-(UILabel *)resultTileLabel{
    if (_resultTileLabel == nil) {
        _resultTileLabel = [UILabel new];
        _resultTileLabel.font = [UIFont systemFontOfSize:13];
        _resultTileLabel.textColor = _Colorhex(0x2f9f7e);
        _resultTileLabel.text = @"认证结果";
    }
    return _resultTileLabel;
}
- (UILabel *)resultContentLabel{
    if (_resultContentLabel == nil) {
        _resultContentLabel = [UILabel new];
        _resultContentLabel.textColor = _Colorhex(0x777777);
        _resultContentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _resultContentLabel;
}

-(UIImageView *)resultImageView{
    if (_resultImageView == nil) {
        _resultImageView = [UIImageView new];
    }
    return _resultImageView;
}



- (UILabel *)processTime{
    if (_processTime == nil) {
        _processTime = [UILabel new];
        _processTime.textColor = _Colorhex(0x444444);
        _processTime.text = @"拒绝时间";
        _processTime.font = [UIFont systemFontOfSize:12];
    }
    return _processTime;
}

- (UILabel *)rejectReason{
    if (_rejectReason == nil) {
        _rejectReason = [UILabel new];
        _rejectReason.textColor = _Colorhex(0x444444);
        _rejectReason.text = @"拒绝理由";
        _rejectReason.font = [UIFont systemFontOfSize:12];
    }
    return _rejectReason;
}



-(UILabel *)enterpriseNameContent{
    if (_enterpriseNameContent == nil) {
        _enterpriseNameContent = [UILabel new];
        _enterpriseNameContent.textColor = _Colorhex(0x777777);
        _enterpriseNameContent.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseNameContent;
}
- (UILabel *)enterpriseLegalPersonContent{
    if (_enterpriseLegalPersonContent == nil) {
        _enterpriseLegalPersonContent = [UILabel new];
        _enterpriseLegalPersonContent.textColor = _Colorhex(0x777777);
        _enterpriseLegalPersonContent.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseLegalPersonContent;
}

-(UILabel *)contactNameContent{
    if (_contactNameContent == nil) {
        _contactNameContent = [UILabel new];
        _contactNameContent.textColor = _Colorhex(0x777777);
        _contactNameContent.font = [UIFont systemFontOfSize:12];
    }
    return _contactNameContent;
}
- (UILabel *)contactNumberContent{
    if (_contactNumberContent == nil) {
        _contactNumberContent = [UILabel new];
        _contactNumberContent.textColor = _Colorhex(0x777777);
        _contactNumberContent.font = [UIFont systemFontOfSize:12];
    }
    return _contactNumberContent;
}

- (UILabel *)enterpriseIdentityContent{
    if (_enterpriseIdentityContent == nil) {
        _enterpriseIdentityContent = [UILabel new];
        _enterpriseIdentityContent.textColor = _Colorhex(0x777777);
        _enterpriseIdentityContent.font = [UIFont systemFontOfSize:12];
    }
    return _enterpriseIdentityContent;
}

- (UILabel *)processTimeContent{
    if (_processTimeContent == nil) {
        _processTimeContent = [UILabel new];
        _processTimeContent.textColor = _Colorhex(0x777777);
        _processTimeContent.font = [UIFont systemFontOfSize:12];
    }
    return _processTimeContent;
}

- (UILabel *)rejectReasonContent{
    if (_rejectReasonContent == nil) {
        _rejectReasonContent = [UILabel new];
        _rejectReasonContent.textColor = _Colorhex(0xfbac57);
        _rejectReasonContent.font = [UIFont systemFontOfSize:12];
        _rejectReasonContent.numberOfLines = 0;
        
        _rejectReasonContent.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 120;
    }
    return _rejectReasonContent;
}

- (UIView *)shadowView{
    if (_shadowView == nil) {
        _shadowView = [UIView new];
        _shadowView.backgroundColor = [UIColor whiteColor];
        
        _shadowView.layer.cornerRadius = 5;
        
        _shadowView.layer.shadowColor = [[UIColor blackColor] CGColor];
        
        _shadowView.layer.shadowOffset = CGSizeMake(5, 5);
        //阴影透明度
        _shadowView.layer.shadowOpacity = 0.5;
        //阴影圆角度数
        _shadowView.layer.shadowRadius = 5.0;
    }
    return _shadowView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = _Colorhex(0xf1f1f1);
        
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.contentTitleLabel];
        [self.bgView addSubview:self.enterpriseName];
        [self.bgView addSubview:self.enterpriseLegalPerson];
        [self.bgView addSubview:self.contactName];
        [self.bgView addSubview:self.contactNumber];
        [self.bgView addSubview:self.enterpriseIdentity];
        [self.bgView addSubview:self.sepLineView];
        [self.bgView addSubview:self.resultTileLabel];
        [self.bgView addSubview:self.resultContentLabel];
        [self.bgView addSubview:self.resultImageView];
        [self.bgView addSubview:self.processTime];
        [self.bgView addSubview:self.rejectReason];
        [self.bgView addSubview:self.enterpriseNameContent];
        [self.bgView addSubview:self.enterpriseLegalPersonContent];
        [self.bgView addSubview:self.contactNameContent];
        [self.bgView addSubview:self.contactNumberContent];
        [self.bgView addSubview:self.enterpriseIdentityContent];
        [self.bgView addSubview:self.processTimeContent];
        [self.bgView addSubview:self.rejectReasonContent];
        
        [self.contentView insertSubview:self.shadowView belowSubview:self.bgView];
        
        
        [self updateConstraintsForSubViews];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}




- (void)updateConstraintsForSubViews{
    
    __weak typeof(self) weakSelf = self;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView);
        make.leading.equalTo(weakSelf.contentView).offset(10);
        make.trailing.equalTo(weakSelf.contentView).offset(-10);
        make.bottom.equalTo(weakSelf.contentView).offset(-10);
    }];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.bgView.mas_bottom).offset(-5);
        make.height.equalTo(@4);
    }];
    
    [self.contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView).offset(10);
        make.top.equalTo(weakSelf.bgView).offset(5);
    }];
    
    [self.enterpriseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.contentTitleLabel.mas_bottom).offset(5);
    }];
    
    [self.enterpriseNameContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.enterpriseName);
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
    }];
    
    [self.enterpriseLegalPerson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.enterpriseName.mas_bottom).offset(5);
    }];
    
    [self.enterpriseLegalPersonContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.enterpriseLegalPerson);
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
        
    }];
    
    [self.contactName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.enterpriseLegalPerson.mas_bottom).offset(5);
    }];
    
    [self.contactNameContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contactName);
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
    }];
    
    [self.contactNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.contactName.mas_bottom).offset(5);
    }];
    
    [self.contactNumberContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contactNumber);
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
    }];
    
    [self.enterpriseIdentity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.contactNumber.mas_bottom).offset(5);
    }];
    
    [self.enterpriseIdentityContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.enterpriseIdentity);
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
    }];
    
    [self.sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView).offset(10);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
        make.top.equalTo(weakSelf.enterpriseIdentity.mas_bottom).offset(5);
        make.height.equalTo(@1);
    }];
    
    [self.resultTileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.sepLineView.mas_bottom).offset(5);
    }];
    
    [self.resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.resultTileLabel);
        make.width.equalTo(@17);
        make.height.equalTo(@17);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
    }];
    
    [self.resultContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.resultImageView);
        make.trailing.equalTo(weakSelf.resultImageView.mas_leading).offset(-5);
    }];
    
    [self.processTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.resultTileLabel.mas_bottom).offset(5);
    }];
    
    [self.processTimeContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.centerY.equalTo(weakSelf.processTime);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
    }];
    
    [self.rejectReason mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentTitleLabel);
        make.top.equalTo(weakSelf.processTime.mas_bottom).offset(5);
    }];
    
    [self.rejectReasonContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView).offset(100);
        make.top.equalTo(weakSelf.rejectReason);
        make.trailing.equalTo(weakSelf.bgView).offset(-10);
    }];
    
}

- (void)setDto:(AuthHistoryDTO *)dto{
    _dto = dto;
    
    
    self.enterpriseNameContent.text = dto.enterpriseName;
    self.enterpriseLegalPersonContent.text = dto.enterpriseLegalPerson;
    self.contactNameContent.text = dto.contactName;
    self.contactNumberContent.text = dto.contactNumber;
    self.enterpriseIdentityContent.text = dto.enterpriseIdentity;
    
    NSDateFormatter *dateFormmatter = [[NSDateFormatter alloc] init];
    [dateFormmatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [dateFormmatter dateFromString:dto.processTime];
    
    [dateFormmatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *dateStr = [dateFormmatter stringFromDate:date];
    
    
    self.processTimeContent.text = dateStr;
    self.rejectReasonContent.text = dto.rejectReason;
    
    if ([dto.status isEqualToString:@"REJECT"]) {
        self.resultContentLabel.text = @"认证失败";
        self.resultImageView.image = [UIImage imageNamed:@"list_icon_02"];
    }else if ([dto.status isEqualToString:@"UNRESOLVED"]) {
        self.resultContentLabel.text = @"认证申请中";
        self.resultImageView.image = [UIImage imageNamed:@"msg_icon_n"];
    }else if ([dto.status isEqualToString:@"PASS"]) {
        self.resultContentLabel.text = @"认证已通过";
        self.resultImageView.image = [UIImage imageNamed:@"list_icon_01"];
    }
}

@end













