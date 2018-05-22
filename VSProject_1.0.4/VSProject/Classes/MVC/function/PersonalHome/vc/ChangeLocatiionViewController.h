//
//  ChangeLocatiionViewController.h
//  VSProject
//
//  Created by certus on 15/11/10.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseViewController.h"

typedef void(^ResetHomeLayout)(void);

@interface ChangeLocatiionViewController : VSBaseViewController

@property (strong, nonatomic) IBOutlet UIButton *sureButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ResetHomeLayout resetLayout;

@end
