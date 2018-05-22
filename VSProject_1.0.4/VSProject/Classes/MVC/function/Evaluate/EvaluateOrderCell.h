//
//  EvaluateOrderCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/7/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

@interface EvaluateOrderCell : UITableViewCell<CWStarRateViewDelegate>

@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,strong)CWStarRateView *starView;

@property (nonatomic,copy) void (^starBlock)(NSInteger score);


@end
