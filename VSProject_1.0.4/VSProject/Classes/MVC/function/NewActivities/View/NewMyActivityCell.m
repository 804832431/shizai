//
//  MyActivityCell.m
//  VSProject
//
//  Created by apple on 10/18/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "NewMyActivityCell.h"

@implementation NewMyActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSource:(NewActivityModel *)activityModel {
    [self.realContentView.layer setShadowOffset:CGSizeMake(0, 5)];
    [self.realContentView.layer setShadowRadius:5];
    [self.realContentView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.realContentView.layer setShadowOpacity:0.1];
    
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
        [self.chargeLabel setText:[NSString stringWithFormat:@"%@元/人",activityModel.charge]];
    }
    
    if ([activityModel.activityStatus isEqualToString:@"STARTED"]) {
        //活动进行中，只提示未报名和已报名.
        self.activityStatusLabel.text = @"活动进行中";
        self.activityStatusLabel.textColor = ColorWithHex(0x2f9f7e, 1.0);
    } else if ([activityModel.activityStatus isEqualToString:@"NOT_START"]) {
        self.activityStatusLabel.text = @"活动即将开始";
        self.activityStatusLabel.textColor = ColorWithHex(0xff6326, 1.0);
        
        //活动还未开始，先判断活动的报名状态，再判断用户自己的报名状态
        if ([activityModel.encrollStatus isEqualToString:@"NOT_START"]) {
            //还未开始报名
        } else if ([activityModel.encrollStatus isEqualToString:@"STARTED"]) {
            //报名中,判断用户是否报名
            if ([activityModel.userEncrollStatus isEqualToString:@"HAS_ENCROLL"]) {
                //用户已报名，判断用户是否完善了信息
                if ([activityModel.isCompleteEncrollInfo isEqualToString:@"Y"]) {

                } else if ([activityModel.isCompleteEncrollInfo isEqualToString:@"N"]) {
                    [self.enrollLabel setHidden:NO];
                }
            } else if ([activityModel.userEncrollStatus isEqualToString:@"NOT_ENCROLL"]) {
                //用户还未报名
            }
        } else if ([activityModel.encrollStatus isEqualToString:@"COMPLETED"]) {
            //报名已结束，判断用户是否报名
            if ([activityModel.userEncrollStatus isEqualToString:@"HAS_ENCROLL"]) {

            } else if ([activityModel.userEncrollStatus isEqualToString:@"NOT_ENCROLL"]) {

            }
        }
    } else if ([activityModel.activityStatus isEqualToString:@"COMPLETED"]) {
        self.activityStatusLabel.text = @"活动已结束";
        self.activityStatusLabel.textColor = ColorWithHex(0x666666, 1.0);
    }
}

@end
