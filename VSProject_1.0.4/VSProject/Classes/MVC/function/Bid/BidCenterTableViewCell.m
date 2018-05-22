//
//  BidCenterTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/23.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidCenterTableViewCell.h"

@interface BidCenterTableViewCell ()

@property (nonatomic,strong) UIView *shadowView;

@end

@implementation BidCenterTableViewCell

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
    
    
    /*
     DELETED，已删除，
     NOT_START：未开始，
     STARTED：已开始，
     COMPLETED：已结束
     */

    /*
     未开标：NOT_OPEN
     已中标：WIN
     未中标：NOT_WIN
     流标：FAILING
     */
    
    
    if (self.isMyBidList) {
        
        if ([dto.bidderProjectStatus isEqualToString:@"NOT_OPEN"]) {
            self.bidBeginTime.textColor = _Colorhex(0x93CD82);
            self.bidEndTime.textColor = _Colorhex(0x93CD82);
            self.ToLabel.textColor = _Colorhex(0x93CD82);
            self.bidStatusLabel.textColor = _Colorhex(0x93CD82);
            
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_01"];
            self.bidStatusLabel.text = @"未开标";
            
        }
        
        if ([dto.bidderProjectStatus isEqualToString:@"WIN"]) {
            
            self.bidBeginTime.textColor = _Colorhex(0xfaa45e);
            self.bidEndTime.textColor = _Colorhex(0xfaa45e);
            self.ToLabel.textColor = _Colorhex(0xfaa45e);
            self.bidStatusLabel.textColor = _Colorhex(0xfaa45e);
            
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_02"];
            self.bidStatusLabel.text = @"中标";
        }
        
        if ([dto.bidderProjectStatus isEqualToString:@"NOT_WIN"]) {
            self.bidBeginTime.textColor = _Colorhex(0x666666);
            self.bidEndTime.textColor = _Colorhex(0x666666);
            self.ToLabel.textColor = _Colorhex(0x666666);
            self.bidStatusLabel.textColor = _Colorhex(0x666666);
            
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_03"];
            self.bidStatusLabel.text = @"未中标";
            
        }
        
        if ([dto.bidderProjectStatus isEqualToString:@"FAILING"]) {
            self.bidBeginTime.textColor = _Colorhex(0x666666);
            self.bidEndTime.textColor = _Colorhex(0x666666);
            self.ToLabel.textColor = _Colorhex(0x666666);
            self.bidStatusLabel.textColor = _Colorhex(0x666666);
            
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_03"];
            self.bidStatusLabel.text = @"流标";
        }
        
    }else{
        
        
        if ([dto.bidStatus isEqualToString:@"DELETED"] || [dto.bidStatus isEqualToString:@"COMPLETED"]) {
            self.bidStatusLabel.text = @"已结束";
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_03"];
            self.bidBeginTime.textColor = _Colorhex(0x666666);
            self.bidEndTime.textColor = _Colorhex(0x666666);
            self.ToLabel.textColor = _Colorhex(0x666666);
            self.bidStatusLabel.textColor = _Colorhex(0x666666);
            //        holder.bottomLayout.setVisibility(View.VISIBLE);
            if ([dto.resultStatus isEqualToString:@"COMPLETED"]) {
                //            holder.tenderWinner.setText("中标单位：" + tenderListItem.bidderCorp);
                //            holder.tenderWinner.setTextColor(Color.parseColor("#fe9f67"));
                self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_02"];
            } else {
                if ([dto.resultStatus isEqualToString:@"NOT_OPEN"]) {
                    //                holder.tenderWinner.setText("中标单位：未公布中标结果");
                } else if ([dto.resultStatus isEqualToString:@"FAILING"]) {
                    //                holder.tenderWinner.setText("中标单位：流标");
                } else {
                    //                holder.tenderWinner.setText("中标单位：");
                }
                //            holder.tenderWinner.setTextColor(Color.parseColor("#606060"));
                self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_03"];
            }
        } else if ([dto.bidStatus isEqualToString:@"NOT_START"]) {
            self.bidStatusLabel.text = @"招标未开始";
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_03"];
            self.bidBeginTime.textColor = _Colorhex(0xc6c6c6);
            self.bidEndTime.textColor = _Colorhex(0xc6c6c6);
            self.ToLabel.textColor = _Colorhex(0xc6c6c6);
            self.bidStatusLabel.textColor = _Colorhex(0xc6c6c6);
        } else if ([dto.bidStatus isEqualToString:@"STARTED"]) {
            self.bidStatusLabel.text = @"招标中";
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_01"];
            self.bidBeginTime.textColor = _Colorhex(0x666666);
            self.bidEndTime.textColor = _Colorhex(0x666666);
            self.ToLabel.textColor = _Colorhex(0x666666);
            self.bidStatusLabel.textColor = _Colorhex(0x666666);
            //        holder.bottomLayout.setVisibility(View.GONE);
        }
    }
}

@end
