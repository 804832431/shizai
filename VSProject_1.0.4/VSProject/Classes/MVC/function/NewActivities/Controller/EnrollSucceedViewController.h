//
//  EnrollSucceedViewController.h
//  VSProject
//
//  Created by apple on 10/17/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "NewActivityModel.h"

@interface EnrollSucceedViewController : VSBaseViewController <UITableViewDelegate,UITableViewDataSource>
_PROPERTY_NONATOMIC_STRONG(NewActivityModel, a_model);
_PROPERTY_NONATOMIC_STRONG(NSDictionary, enrollment);
@property (weak, nonatomic) IBOutlet UITableView *activityTableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@end
