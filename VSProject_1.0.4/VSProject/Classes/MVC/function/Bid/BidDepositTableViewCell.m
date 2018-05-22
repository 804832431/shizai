//
//  BidDepositTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/10/31.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidDepositTableViewCell.h"

@implementation BidDepositTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setBidPro:(BidProject *)bidPro{
    _bidPro = bidPro;
    
    self.projectName.text = bidPro.projectName;
    self.needDeposit.text = [NSString stringWithFormat:@"投标保证金 ¥%@",bidPro.bidDeposit];
    self.payDeposit.text = [NSString stringWithFormat:@"¥ %@",bidPro.bidDeposit];
    
}

@end
