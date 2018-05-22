//
//  NewActivityCell.m
//  VSProject
//
//  Created by apple on 10/16/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "NewActivityCell.h"

@implementation NewActivityCell

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
    [self.activityImageView sd_setImageWithString:activityModel.largeImage placeholderImage:[UIImage imageNamed:@"activity_list_default"]];
    
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
        NSMutableAttributedString * stringPartOne = [[NSMutableAttributedString alloc] initWithString:activityModel.charge];
        NSDictionary * partOneAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        [stringPartOne setAttributes:partOneAttributes range:NSMakeRange(0,stringPartOne.length)];
        NSMutableAttributedString * stringPartTwo = [[NSMutableAttributedString alloc] initWithString:@"元/人"];
        NSDictionary * partTwoAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10]};
        [stringPartTwo setAttributes:partTwoAttributes range:NSMakeRange(0,stringPartTwo.length)];
        [stringPartOne appendAttributedString:stringPartTwo];
        [self.chargeLabel setAttributedText:stringPartOne];
    }
    
    //报名状态有逻辑
    //活动报名状态	NOT_START：即将报名，STARTED：报名中，COMPLETED：报名结束'
    //活动状态	DELETED，已删除，NOT_START：未开始，STARTED：已开始，COMPLETED：已结束',
    //发现入口只展示 @"报名中" @"即将开始报名" @"报名已结束"
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    NSString *str;
    if ([activityModel.encrollStatus isEqualToString:@"NOT_START"]) {
        str = @"即将开始报名";
        [self.enrollLabel setBackgroundColor:ColorWithHex(0xff8d30, 1.0)];
    } else if ([activityModel.encrollStatus isEqualToString:@"STARTED"]) {
        str = @"报名中";
        [self.enrollLabel setBackgroundColor:ColorWithHex(0xff4949, 1.0)];
    } else if ([activityModel.encrollStatus isEqualToString:@"COMPLETED"]) {
        str = @"报名已结束";
        [self.enrollLabel setBackgroundColor:ColorWithHex(0x535353, 1.0)];
    }
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    [self.widthOfEnrollLabel setConstant:textSize.width + 10];
    [self.enrollLabel setText:str];
    [self.enrollLabel.layer setCornerRadius:2.0];
    [self.enrollLabel setClipsToBounds:YES];
}

@end
