//
//  ForgetAccountInfoCell.h
//  VSProject
//
//  Created by XuLiang on 15/10/29.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@class ForgetAccountInfoCell;

@protocol ForgetAccountInfoCellDelegate <NSObject>

- (void)infotextFieldDidEndEditing:(ForgetAccountInfoCell *)sender;

@end

@interface ForgetAccountInfoCell : VSBaseTableViewCell

- (NSString*)vs_infoText;
@property(nonatomic,assign)id<ForgetAccountInfoCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet VSTextField *vm_txtInfo;

@end
