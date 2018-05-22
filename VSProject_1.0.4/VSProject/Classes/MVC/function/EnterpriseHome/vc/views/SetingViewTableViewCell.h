//
//  SetingViewTableViewCell.h
//  EmperorComing
//
//  Created by wbb on 15/10/5.
//  Copyright (c) 2015年 certus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetingViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (strong, nonatomic) IBOutlet UIImageView *arrow;
@property (strong, nonatomic) IBOutlet UIImageView *settingimageView;
@property (strong, nonatomic) IBOutlet UILabel *subLabel;

@end
