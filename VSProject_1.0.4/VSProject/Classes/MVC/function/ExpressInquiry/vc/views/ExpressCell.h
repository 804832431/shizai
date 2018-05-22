//
//  ExpressCell.h
//  VSProject
//
//  Created by certus on 15/12/1.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressCell : VSBaseTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *centerImageView;
@property (strong, nonatomic) IBOutlet UILabel *topHalfLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subLabel;

@end
