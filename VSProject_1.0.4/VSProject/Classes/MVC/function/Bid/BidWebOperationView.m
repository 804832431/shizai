//
//  BidWebOperationView.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BidWebOperationView.h"
#import "BidderManager.h"

@implementation BidWebOperationView



- (IBAction)bidButtonAction:(UIButton *)sender {
    if (self.bidButtonActionBlock) {
        self.bidButtonActionBlock(self.data,[sender currentTitle]);
    }
}

- (IBAction)telPhoneAction:(id)sender {
    if (self.telPhoneCallBlock) {
        self.telPhoneCallBlock(self.telPhontNumLabel.text);
    }
}



- (void)setData:(BidProject *)data{
    _data = data;
    
    
    
    /*
     未开标：NOT_OPEN
     已中标：WIN
     未中标：NOT_WIN
     流标：FAILING
     */
    
    if (self.isHomeList || self.isCollectionList) {
        
        
        
        if ([data.bidStatus isEqualToString:@"NOT_START"]) {
            [self.bidButton setTitleColor:_Colorhex(0xC3C3C3) forState:UIControlStateNormal];
            [self.bidButton setTitle:@"招标未开始" forState:UIControlStateNormal];
            self.bidButton.enabled = NO;
        } else if ([data.bidStatus isEqualToString:@"STARTED"]) {
            if (![data.bidderProjectStatus isEqualToString:@""]) {
                [self.bidButton setTitleColor:_Colorhex(0xC3C3C3) forState:UIControlStateNormal];
                [self.bidButton setTitle:@"已投标" forState:UIControlStateNormal];
                self.bidButton.enabled = NO;
            } else {
                [self.bidButton setTitleColor:_Colorhex(0xFD5C19) forState:UIControlStateNormal];
                [self.bidButton setTitle:@"立即投标" forState:UIControlStateNormal];
                self.bidButton.enabled = YES;
            }
        } else if ([data.bidStatus isEqualToString:@"DELETED"] || [data.bidStatus isEqualToString:@"COMPLETED"]) {
            if (![data.bidderProjectStatus isEqualToString:@""]) {
                if ([data.bidderProjectStatus isEqualToString:@"FAILING"]) {
                    [self.bidButton setTitle:@"流标" forState:UIControlStateNormal];
                } else if ([data.bidderProjectStatus isEqualToString:@"NOT_WIN"]) {
                    [self.bidButton setTitle:@"未中标" forState:UIControlStateNormal];
                } else if ([data.bidderProjectStatus isEqualToString:@"NOT_OPEN"]) {
                    [self.bidButton setTitle:@"未开标" forState:UIControlStateNormal];
                } else if ([data.bidderProjectStatus isEqualToString:@"WIN"]) {
                    [self.bidButton setTitle:@"中标" forState:UIControlStateNormal];
                }
                [self.bidButton setTitleColor:_Colorhex(0xc3c3c3) forState:UIControlStateNormal];
                self.bidButton.enabled = NO;
                
            } else {
                [self.bidButton setTitleColor:_Colorhex(0xc3c3c3) forState:UIControlStateNormal];
                [self.bidButton setTitle:@"已过期" forState:UIControlStateNormal];
                self.bidButton.enabled = NO;
            }
        }
        
    } else {
        
        //我的投标页
        if ([data.bidderProjectStatus isEqualToString:@"FAILING"]) {
            [self.bidButton setTitle:@"流标" forState:UIControlStateNormal];
        } else if ([data.bidderProjectStatus isEqualToString:@"NOT_WIN"]) {
            [self.bidButton setTitle:@"未中标" forState:UIControlStateNormal];
        } else if ([data.bidderProjectStatus isEqualToString:@"NOT_OPEN"]) {
            [self.bidButton setTitle:@"未开标" forState:UIControlStateNormal];
        } else if ([data.bidderProjectStatus isEqualToString:@"WIN"]) {
            [self.bidButton setTitle:@"中标" forState:UIControlStateNormal];
        }
        [self.bidButton setTitleColor:_Colorhex(0xc3c3c3) forState:UIControlStateNormal];
        self.bidButton.enabled = NO;
    }
}

@end
