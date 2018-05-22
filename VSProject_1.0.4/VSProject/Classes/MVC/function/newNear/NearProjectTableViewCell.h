//
//  NearProjectTableViewCell.h
//  VSProject
//
//  Created by pangchao on 17/6/27.
//  Copyright © 2017年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface NearProjectTableViewCell : UITableViewCell

@property (nonatomic, strong) Project *project;

- (void)setDataSource:(Project *)data;

@end
