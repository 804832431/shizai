//
//  ProjectTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface ProjectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (nonatomic,strong) Project *data;

@property (nonatomic,strong) NSIndexPath *indexPath;

@end
