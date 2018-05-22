//
//  CompeleteActivityTableViewCell.h
//  VSProject
//
//  Created by apple on 1/5/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewActivityModel.h"

@interface CompeleteActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityTitle;

- (void)setDataSource:(NewActivityModel *)activityModel;

@end
