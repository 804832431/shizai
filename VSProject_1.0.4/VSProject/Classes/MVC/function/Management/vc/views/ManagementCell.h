//
//  ManagementCell.h
//  VSProject
//
//  Created by certus on 16/3/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagementCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *m_account;
@property (strong, nonatomic) IBOutlet UILabel *m_name;
@property (strong, nonatomic) IBOutlet UIButton *m_editButton;
@property (strong, nonatomic) IBOutlet UIButton *m_deleteButton;

@end
