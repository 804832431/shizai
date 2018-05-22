//
//  BidListTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidListTableViewCell.h"

@interface BidListTableViewCell ()

@property (nonatomic,strong) UIView *shadowView;

@end

@implementation BidListTableViewCell

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

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //    self.nameWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width - 130;
    
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        self.nameWidthConstraint.constant = 180;
    }else{
        self.nameWidthConstraint.constant = 220;
    }
    
    
    __weak typeof(self) weakSelf = self;
    
    self.contentView.backgroundColor = _Colorhex(0xf0eff5);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    
    [self.contentView insertSubview:self.shadowView belowSubview:self.bgView];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.bgView.mas_bottom).offset(-5);
        make.height.equalTo(@4);
    }];
    
}


- (void)setDto:(BidProject *)dto{
    _dto = dto;
    
    self.nameLabel.text = dto.projectName;
    self.bidTypeLabel.text = dto.projectType;
    self.bidMoneyLabel.text = dto.projectBudget;
    self.bidAddressLabel.text = dto.area;
    self.bidMoneyTypeLabel.text = dto.capitalSource;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    
    NSDate *beginDate = [formatter dateFromString:dto.bidBeginTime];
    NSDate *endDate = [formatter dateFromString:dto.bidEndTime];
    
    formatter.dateFormat = @"MM-dd";
    
    self.bidBeginTime.text = [formatter stringFromDate:beginDate];
    self.bidEndTime.text = [formatter stringFromDate:endDate];
    
    
    if ([dto.bidStatus isEqualToString:@"DELETED"] || [dto.bidStatus isEqualToString:@"COMPLETED"]) {
        self.bidStatusLabel.text = @"已结束";
        self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_03"];
        self.bidBeginTime.textColor = _Colorhex(0x666666);
        self.bidEndTime.textColor = _Colorhex(0x666666);
        self.ToLabel.textColor = _Colorhex(0x666666);
        self.bidStatusLabel.textColor = _Colorhex(0x666666);
        [self hideTender:NO];
        if ([dto.resultStatus isEqualToString:@"COMPLETED"]) {
            [self.tenderWinnerLabel setText:[NSString stringWithFormat:@"中标单位：%@",dto.bidderCorp]];
            [self.tenderWinnerLabel setTextColor:_Colorhex(0xfe9f67)];
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_02"];
        } else {
            if ([dto.resultStatus isEqualToString:@"NOT_OPEN"]) {
                [self.tenderWinnerLabel setText:@"中标单位：未公布中标结果"];
            } else if ([dto.resultStatus isEqualToString:@"FAILING"]) {
                [self.tenderWinnerLabel setText:@"中标单位：流标"];
            } else {
                [self.tenderWinnerLabel setText:@"中标单位："];
            }
            [self.tenderWinnerLabel setTextColor:_Colorhex(0x606060)];
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_03"];
        }
    } else if ([dto.bidStatus isEqualToString:@"NOT_START"]) {
        self.bidStatusLabel.text = @"招标未开始";
        self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_03"];
        self.bidBeginTime.textColor = _Colorhex(0xc6c6c6);
        self.bidEndTime.textColor = _Colorhex(0xc6c6c6);
        self.ToLabel.textColor = _Colorhex(0xc6c6c6);
        self.bidStatusLabel.textColor = _Colorhex(0xc6c6c6);
        [self hideTender:YES];
    } else if ([dto.bidStatus isEqualToString:@"STARTED"]) {
        self.bidStatusLabel.text = @"招标中";
        self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_01"];
        self.bidBeginTime.textColor = _Colorhex(0x666666);
        self.bidEndTime.textColor = _Colorhex(0x666666);
        self.ToLabel.textColor = _Colorhex(0x666666);
        self.bidStatusLabel.textColor = _Colorhex(0x666666);
        [self hideTender:YES];
    }
}

- (void)hideTender:(BOOL)hide {
    if (hide) {
        [self.bottomLine setHidden:YES];
        [self.tenderHigh setConstant:0.01f];
    } else {
        
    }
}

@end
