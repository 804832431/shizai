//
//  RefundRejectedTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/2.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RefundRejectedTableViewCell.h"
#import "OrderDetailDTO.h"
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"

@implementation RefundRejectedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setDto:(OrderDetailDTO *)dto{
    _dto = dto;
    
    for (OrderStatus *status in dto.orderStatusList) {
        
        if ([status.STATUS_ID isEqualToString: SZ_RETURN_MAN_REFUND]) {
            self.rejectResonLabel.text = status.CHANGE_REASON;
            
            break;
        }
        
    }
    
}

- (IBAction)playCall:(id)sender {
    PXAlertView *alertView = [PXAlertView showAlertWithTitle:@"提示" message:@"您确定要拨打客服电话吗？" cancelTitle:@"取消" otherTitle:@"确定" completion:^(BOOL cancelled, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008230087"]];
        }
    }];
    
    [alertView setBackgroundColor:[UIColor whiteColor]];
    [alertView setTitleColor:[UIColor grayColor]];
    [alertView setMessageColor:[UIColor grayColor]];
    [alertView setCancelButtonTextColor:[UIColor grayColor]];
    [alertView setOtherButtonTextColor:[UIColor grayColor]];
}
@end
