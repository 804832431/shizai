//
//  NotificationAgentCell.h
//  VSProject
//
//  Created by certus on 16/4/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAgentModel.h"

@interface NotificationAgentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *line4;

@property (strong, nonatomic) IBOutlet UILabel *orderLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *stateLabel;

@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) IBOutlet UIButton *detailButton;

@property (copy, nonatomic)void (^actionCancel) (void);

@property (copy, nonatomic)void (^actionDetail) (void);

@end
