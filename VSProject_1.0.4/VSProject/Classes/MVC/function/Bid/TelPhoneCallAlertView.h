//
//  TelPhoneCallAlertView.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TelPhoneCallAlertView : UIView

@property (nonatomic,weak)IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *telPhoneLabel;

@property (nonatomic,strong) NSString *telPhone;

+ (void)showWithTelPHoneNum:(NSString *)tel;

- (IBAction)cancelAction:(id)sender;
- (IBAction)okAction:(id)sender;

@end
