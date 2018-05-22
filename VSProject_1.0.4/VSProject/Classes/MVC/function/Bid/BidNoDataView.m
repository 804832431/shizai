//
//  BidNoDataView.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/23.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidNoDataView.h"

@implementation BidNoDataView

+ (instancetype) noDataViewWithType:(BidNoDataViewType) type{
    BidNoDataView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
    switch (type) {
        case BidNoDataViewTypeBid:
        {
            view.noDataImageView.image = [UIImage imageNamed:@"bg_icon_n"];
            view.noDataDescLabel.text = @"你当前没有参加投标项目";
            
            
        }
            break;
            
        case BidNoDataViewTypeCollection:
        {
            view.noDataImageView.image = [UIImage imageNamed:@"bg_icon_n_2"];
            view.noDataDescLabel.text = @"你当前没有收藏投标的项目";
            
            
        }
            break;
        case BidNoDataViewTypeAuth:
        {
            view.noDataImageView.image = [UIImage imageNamed:@"msg_icon_n"];
            view.noDataDescLabel.text = @"你当前没有企业申请记录";
            
            
        }
            break;
            
        case BidNoDataViewTypeDeposit:
        {
            view.noDataImageView.image = [UIImage imageNamed:@"bg_img_n2"];
            view.noDataDescLabel.text = @"暂无信息";
            
            
        }
            break;
            
            
        default:
            break;
    }
    
    return view;
    
}

- (IBAction)phoneButtonAction:(id)sender {
}
@end
