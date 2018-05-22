//
//  HomeAppView.h
//  VSProject
//
//  Created by apple on 12/28/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTXCAppModel.h"

@interface HomeAppView : UIView
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIImageView *appIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *appTitleLabel;

- (void)setDataSource:(RTXCAppModel *)appModel;

@end
