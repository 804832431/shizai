//
//  MyActivityCell.h
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyActivityListModel.h"

typedef enum : NSUInteger {
    PRE_PAY,
    WAITING_COMMIT,
    SUCCESS,
    FAILED,
} ACT_ORDER_STATUS;


@interface MyActivityCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *topButton;

@property (strong, nonatomic) IBOutlet UILabel *topLabel;

@property (strong, nonatomic) IBOutlet UILabel *ordertimeLabel;

@property (strong, nonatomic) IBOutlet UILabel *ordetStateLabel;

- (void)vp_updateUIWithModel:(id)model;

@end
