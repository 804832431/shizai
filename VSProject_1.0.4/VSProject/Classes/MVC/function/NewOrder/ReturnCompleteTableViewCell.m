//
//  ReturnCompleteTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/3.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ReturnCompleteTableViewCell.h"

@implementation ReturnCompleteTableViewCell

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
            
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%li",status.STATUS_DATETIME]];
            
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            NSString *dateStr = [dateFormatter stringFromDate:date];
            
            self.createdTimeLabel.text = dateStr;
            
        }
        
        if ([status.STATUS_ID isEqualToString: SZ_RETURN_ACCEPTED]) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%li",status.STATUS_DATETIME]];
            
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            NSString *dateStr = [dateFormatter stringFromDate:date];
            
            self.acceptTimeLabel.text = dateStr;
            
        }
        
        if ([status.STATUS_ID isEqualToString: SZ_RETURN_COMPLETED]) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%li",status.STATUS_DATETIME]];
            
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            NSString *dateStr = [dateFormatter stringFromDate:date];
            
            self.completeTimeLabel.text = dateStr;
            
        }
        
    }
    
}


- (void)setReturnStatusList:(NSArray *)returnStatusList{
    _returnStatusList = returnStatusList;
    for (NSDictionary *status in returnStatusList) {
        
        if ([status[@"returnStatus"] isEqualToString: @"RETURN_REQUESTED"]) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",status[@"statusTime"]]];
            
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            NSString *dateStr = [dateFormatter stringFromDate:date];
            
            self.createdTimeLabel.text = dateStr;
            
        }
        
        if ([status[@"returnStatus"]  isEqualToString: @"RETURN_ACCEPTED"]) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",status[@"statusTime"]]];
            
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            NSString *dateStr = [dateFormatter stringFromDate:date];
            
            self.acceptTimeLabel.text = dateStr;
            
        }
        
        if ([status[@"returnStatus"] isEqualToString:@"RETURN_COMPLETED"]) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",status[@"statusTime"]]];
            
            [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
            NSString *dateStr = [dateFormatter stringFromDate:date];
            
            self.completeTimeLabel.text = dateStr;
            
        }
        
    }
    
    
}
@end
