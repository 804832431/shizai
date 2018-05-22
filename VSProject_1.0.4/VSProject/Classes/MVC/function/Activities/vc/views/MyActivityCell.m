//
//  MyActivityCell.m
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MyActivityCell.h"

@implementation MyActivityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)vp_updateUIWithModel:(id)model
{
    if ([model isKindOfClass:[MyActivityListModel class]]) {
        MyActivityListModel *m_model = (MyActivityListModel *)model;
        self.topLabel.text = [NSString stringWithFormat:@"活动名称：%@",m_model.activity.title];
        self.ordertimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",[NSDate timeMinutes:m_model.activityEnrollment.createTime.longLongValue]];
        
        NSString *status = m_model.activityEnrollment.status;
        switch (status.intValue) {
            case PRE_PAY:
                self.ordetStateLabel.text = @"订单状态：待支付";
                break;
                
            case WAITING_COMMIT:
                self.ordetStateLabel.text = @"订单状态：待确认";
                break;
                
            case SUCCESS:
                self.ordetStateLabel.text = @"订单状态：已确认";
                break;
                
            case FAILED:
                self.ordetStateLabel.text = @"订单状态：报名失败";
                break;
                
            default:
                self.ordetStateLabel.text = @"订单状态：待确认";
                break;
        }
    }
    
}

@end
