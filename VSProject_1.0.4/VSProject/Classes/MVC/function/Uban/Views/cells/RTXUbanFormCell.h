//
//  RTXUbanFormCell.h
//  VSProject
//
//  Created by XuLiang on 16/1/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@class RTXUbanFormCell;
@protocol RTXUbanFormCellDelegate <NSObject>

- (BOOL)textFieldShouldBeginEditing:(RTXUbanFormCell *)sender;
- (void)textFieldDidBeginEditing:(RTXUbanFormCell *)sender;
- (void)textFieldDidEndEditing:(RTXUbanFormCell *)sender;
- (BOOL)textField:(RTXUbanFormCell *)sender shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

@interface RTXUbanFormCell : VSBaseTableViewCell


@property (weak, nonatomic) IBOutlet UILabel *m_titleLbl;
@property (weak, nonatomic) IBOutlet VSTextField *m_contentTxt;
@property (strong, nonatomic) IBOutlet UIButton *m_button;

@property(nonatomic,assign)id<RTXUbanFormCellDelegate> delegate;

@end
