//
//  BidWebOperationView.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BidProject.h"

@interface BidWebOperationView : UIView

@property (nonatomic,strong) BidProject* data;

@property (nonatomic,assign) BOOL isCollectionList;//从收藏列表里来

@property (nonatomic,assign) BOOL isHomeList;//从首页列表来

@property (nonatomic,assign) BOOL isMyBidList;//从我的投标列表来

@property (weak, nonatomic) IBOutlet UIButton *bidButton;
@property (weak, nonatomic) IBOutlet UILabel *telPhontNumLabel;
- (IBAction)bidButtonAction:(id)sender;
- (IBAction)telPhoneAction:(id)sender;

@property (nonatomic,copy) void (^telPhoneCallBlock)(NSString *telPhone);
@property (nonatomic,copy) void (^bidButtonActionBlock)(id data,NSString *title);

@end
