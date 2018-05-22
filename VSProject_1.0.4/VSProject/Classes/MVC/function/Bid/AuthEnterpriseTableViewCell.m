//
//  AuthEnterpriseTableViewCell.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import "AuthEnterpriseTableViewCell.h"

@interface AuthEnterpriseTableViewCell ()

@property (nonatomic, strong) NSString *key;

@end

@implementation AuthEnterpriseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.borderWidth = 1.0;
    self.bgView.layer.borderColor = ColorWithHex(0xa0a0a0,1.0).CGColor;
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentTextField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
}

- (void)textChanged{
    if (self.dic) {
        NSString *str = self.contentTextField.text;
        
        [self.dic setObject:str  forKey:self.key];
    }
}

- (void)setDic:(NSMutableDictionary *)dic{
    _dic = dic;
    
    if ([[dic allKeys].firstObject isEqualToString:@"企业工商注册号"]) {
//        [self.contentTextField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    
    self.contentTitleLabel.text = dic.allKeys.firstObject;
    self.key = dic.allKeys.firstObject;
    self.contentTextField.text = [dic valueForKey:dic.allKeys.firstObject];
}

@end
