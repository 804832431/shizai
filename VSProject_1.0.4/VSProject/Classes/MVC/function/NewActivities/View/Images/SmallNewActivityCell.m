//
//  SmallNewActivityCell.m
//  VSProject
//
//  Created by apple on 10/18/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "SmallNewActivityCell.h"

@implementation SmallNewActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSource:(NewActivityModel *)activityModel {
    [self.titleLabel setText:activityModel.title];
    [self.addressLabel setText:activityModel.activityLocation];
    [self.activityImageView sd_setImageWithString:activityModel.smallImage placeholderImage:[UIImage imageNamed:@"activity_list_default"]];
    
    //时间处理
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //转化string到date
    NSDate *date = [dateFormatter dateFromString:activityModel.activityStartTime];
    //输出格式为：09.14 14:00
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [displayFormatter setDateFormat:@"MM.dd HH:mm"];
    NSString *dateString = [displayFormatter stringFromDate:date];
    NSLog(@"%@",dateString);
    [self.timeLabel setText:dateString];
    
    //费用状态逻辑 //费用类型	"free：免费 charge：收费"  费用（元/人）
    if ([activityModel.chargeType isEqualToString:@"free"]) {
        [self.chargeLabel setText:@"免费"];
    } else if ([activityModel.chargeType isEqualToString:@"charge"]) {
        [self.chargeLabel setText:[NSString stringWithFormat:@"￥%@",activityModel.charge]];
    }
}

@end
