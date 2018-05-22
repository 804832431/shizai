//
//  HomeRecommendTableViewCell.h
//  VSProject
//
//  Created by apple on 12/30/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceModel.h"

@interface HomeRecommendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *serviceImageView;
@property (weak, nonatomic) IBOutlet UILabel *serviceTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *customContentView;

- (void)setDataSource:(ServiceModel *)service;

@end
