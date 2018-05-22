//
//  BidCenterOpTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/23.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidCenterOpTableViewCell.h"

@interface BidCenterOpTableViewCell ()

@property (nonatomic,strong) UIView *shadowView;

@end

@implementation BidCenterOpTableViewCell

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
        
        if ([dto.bidStatus isEqualToString:@"NOT_START"] ) {
            
            self.bidBeginTime.textColor = _Colorhex(0x666666);
            self.bidEndTime.textColor = _Colorhex(0x666666);
            self.ToLabel.textColor = _Colorhex(0x666666);
            self.bidStatusLabel.textColor = _Colorhex(0x666666);
            
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_03"];
            
            self.bidStatusLabel.text = @"招标未开始";
            
        }else if([dto.bidStatus isEqualToString:@"COMPLETED"] ){
            
            self.bidBeginTime.textColor = _Colorhex(0x666666);
            self.bidEndTime.textColor = _Colorhex(0x666666);
            self.ToLabel.textColor = _Colorhex(0x666666);
            self.bidStatusLabel.textColor = _Colorhex(0x666666);
            
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_03"];
            
            self.bidStatusLabel.text = @"已过期";
            
        }else{
            
            self.bidBeginTime.textColor = _Colorhex(0xfaa45e);
            self.bidEndTime.textColor = _Colorhex(0xfaa45e);
            self.ToLabel.textColor = _Colorhex(0xff933e);
            self.bidStatusLabel.textColor = _Colorhex(0xff933e);
            
            self.bidStatusBgImageView.image = [UIImage imageNamed:@"list_img_calendar_n_01"];
            self.bidStatusLabel.text = @"招标中";
        }
    }
    
    
//    if (![dto.bidderProjectStatus isEqualToString:@"NOT_OPEN"] && [dto.canReturn isEqualToString:@"Y"]) {
//        
//        self.requestCallBackLabel.textColor = [UIColor colorWithRed:0 green:159/255.0 blue:112/255.0 alpha:1];
//      
//    }else{
//        
//          self.requestCallBackLabel.textColor = _Colorhex(0x999999);
//    }
    
    //申请退款逻辑
    if ([dto.canReturn isEqualToString:@"Y"]) {
        [self.requestCallBackLabel setHidden:NO];
        if ([dto.bidderProjectStatus isEqualToString:@"NOT_OPEN"]) {
            self.requestCallBackLabel.textColor = _Colorhex(0xbfbfbf);
//            [self.requestCallBackButton setEnabled:NO];
        } else {
            self.requestCallBackLabel.textColor = _Colorhex(0x999999);
//            [self.requestCallBackButton setEnabled:YES];
        }
    } else {
        [self.requestCallBackLabel setHidden:YES];
    }
    
//    // 申请退款布局
//    if ("Y".equals(tenderListItem.canReturn)) {
//        holder.applyRefoundRl.setVisibility(View.VISIBLE);
//        // 未开标文字置灰不可点击
//        if ("NOT_OPEN".equals(tenderListItem.bidderProjectStatus)) {
//            holder.applyRefoundTip.setTextColor(Color.parseColor("#bfbfbf"));
//            holder.applyRefoundRl.setEnabled(false);
//        } else {
//            holder.applyRefoundTip.setTextColor(Color.parseColor("#2f9f7e"));
//            holder.applyRefoundRl.setEnabled(true);
//        }
//    } else {
//        holder.applyRefoundRl.setVisibility(View.GONE);
//    }
    
}

- (IBAction)requestCallBackAction:(id)sender {
    if ([self.dto.canReturn isEqualToString:@"Y"]) {
        [self.requestCallBackLabel setHidden:NO];
        if ([self.dto.bidderProjectStatus isEqualToString:@"NOT_OPEN"]) {
            
        } else {
            if (self.requestDepositBackBlock) {
                self.requestDepositBackBlock(self.dto);
            }
        }
    } else {
        
    }
}
@end
