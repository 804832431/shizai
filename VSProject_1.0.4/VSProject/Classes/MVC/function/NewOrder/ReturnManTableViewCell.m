//
//  ReturnManTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/3.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ReturnManTableViewCell.h"

@implementation ReturnManTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setDto:(OrderDetailDTO *)dto{
    _dto = dto;
    
    for (OrderStatus *status in dto.orderStatusList) {
        
        if ([status.STATUS_ID isEqualToString: SZ_RETURN_REQUESTED]) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zi",status.STATUS_DATETIME]];
            
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            NSString *dateStr = [dateFormatter stringFromDate:date];
            
            self.createdTimeLabel.text = dateStr;
            
        }
        
        if ([status.STATUS_ID isEqualToString: SZ_RETURN_MAN_REFUND]) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zi",status.STATUS_DATETIME]];
            
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            NSString *dateStr = [dateFormatter stringFromDate:date];
            
            self.rejectedTimeLabel.text = dateStr;
            
        }
        
    }
    
}

@end
