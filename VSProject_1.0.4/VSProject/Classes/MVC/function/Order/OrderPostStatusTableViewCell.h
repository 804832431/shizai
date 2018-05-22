//
//  orderPostStatusTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPostStatusTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *vTopLineView;

@property (nonatomic,strong) UIImageView *vImageVIew;

@property (nonatomic,strong) UILabel *vBottomLineView;

@property (nonatomic,strong) UILabel *orderStatusTitle;

@property (nonatomic,strong) UILabel *orderStatusTime;

@property (nonatomic,strong) UILabel *bottomLineView;

@property (nonatomic,assign) BOOL isLastCell;

@property (nonatomic,assign) BOOL isFirstCell;


@end
