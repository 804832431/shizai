//
//  ExpressInquiryViewController.h
//  VSProject
//
//  Created by certus on 15/12/1.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseViewController.h"

@interface ExpressInquiryViewController : VSBaseViewController

@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UITextField *companyTextField;
@property (strong, nonatomic) IBOutlet UIButton *companyButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *baseLabel;

@end
