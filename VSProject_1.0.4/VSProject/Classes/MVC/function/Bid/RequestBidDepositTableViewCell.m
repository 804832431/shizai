//
//  BidDepositTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/10/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import "RequestBidDepositTableViewCell.h"

@implementation RequestBidDepositTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.requestBackButton.layer.cornerRadius = 5;
    self.requestBackButton.layer.masksToBounds = YES;
    
}

- (void)setBidPro:(BidProject *)bidPro{
    _bidPro = bidPro;
    
    self.projectName.text = bidPro.projectName;
    self.needDeposit.text = [NSString stringWithFormat:@"投标保证金 ¥%@",bidPro.bidDeposit];
    self.payDeposit.text = [NSString stringWithFormat:@"¥ %@",bidPro.bidDeposit];
    
    if ([bidPro.canReturn isEqualToString:@"Y"]) {
        self.requestBackButton.hidden = NO;
    }else{
        self.requestBackButton.hidden = YES;
    }
    
}

- (IBAction)requestBackButtonAction:(id)sender {
    
    if (self.requestBidDepositBlock) {
        self.requestBidDepositBlock();
    }
}
@end
