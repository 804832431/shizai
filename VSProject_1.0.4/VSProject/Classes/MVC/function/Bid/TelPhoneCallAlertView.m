//
//  TelPhoneCallAlertView.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TelPhoneCallAlertView.h"

@implementation TelPhoneCallAlertView

- (void)awakeFromNib{
    self.backgroundColor = ColorWithHex(0x000000, 0.5);
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
}


+ (void)showWithTelPHoneNum:(NSString *)tel{
    
    
    TelPhoneCallAlertView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
    view.telPhone = tel;
    view.telPhoneLabel.text = tel;
    
    UIWindow *window = [[UIApplication sharedApplication].delegate  window];
    [window addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    
    
}

- (IBAction)cancelAction:(id)sender {
    
    [self removeFromSuperview];
}

- (IBAction)okAction:(id)sender {
    
    [self removeFromSuperview];
    
    self.telPhone = [self.telPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.telPhone]]];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    if (touch.view != self.contentView) {
        [self removeFromSuperview];
    }
    
    
}

@end
