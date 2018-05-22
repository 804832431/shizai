//
//  ForgetAccountbtnCell.h
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@class ForgetAccountbtnCell;

@protocol ForgetAccountbtnCellDelegate <NSObject>

- (void)textFieldDidEndEditing:(ForgetAccountbtnCell *)sender;
- (void)actionSendCaptcha:(ForgetAccountbtnCell *)sender;
- (BOOL)textField:(ForgetAccountbtnCell *)sender shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (void)textFieldDidBeginEditing:(ForgetAccountbtnCell *)sender;
@end

@interface ForgetAccountbtnCell : VSBaseTableViewCell

- (NSString*)vs_infoText;
@property (weak, nonatomic) IBOutlet VSTextField *vm_txtInfo;
@property (weak, nonatomic) IBOutlet UIButton *vm_getcodeBtn;
@property(nonatomic,assign)id<ForgetAccountbtnCellDelegate> delegate;

- (void)updateLeftImage:(NSString *)imageName;

@end
