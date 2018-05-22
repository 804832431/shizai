//
//  VSLoginInfoCell.h
//  VSProject
//
//  Created by user on 15/3/1.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@class VSAccountInfoCell;
@protocol VSAccountInfoCellDelegate <NSObject>

- (void)textFieldDidEndEditing:(VSAccountInfoCell *)sender;
- (BOOL)textField:(VSAccountInfoCell *)sender shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (void)textFieldDidBeginEditing:(VSAccountInfoCell *)sender;

@end

@interface VSAccountInfoCell : VSBaseTableViewCell
@property (weak, nonatomic) IBOutlet VSTextField *vm_txtInfo;

@property(nonatomic,assign)id<VSAccountInfoCellDelegate> delegate;

- (NSString*)vs_infoText;

- (void)updateLeftImage:(NSString *)imageName;

@end
