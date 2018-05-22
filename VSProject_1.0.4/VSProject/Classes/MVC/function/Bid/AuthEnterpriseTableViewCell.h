//
//  AuthEnterpriseTableViewCell.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthEnterpriseTableViewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIView *bgView;

@property (nonatomic,strong) IBOutlet UILabel *contentTitleLabel;

@property (nonatomic,strong) IBOutlet UITextField *contentTextField;

@property (nonatomic,strong) NSMutableDictionary *dic;


@end
