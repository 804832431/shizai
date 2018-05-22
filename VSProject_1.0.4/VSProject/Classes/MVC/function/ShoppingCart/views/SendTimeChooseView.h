//
//  SendTimeChooseView.h
//  VSProject
//
//  Created by 陈 海涛 on 15/11/15.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendTimeChooseView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIButton *bgButton;

@property (nonatomic,strong) UIPickerView *pickerView;

@property (nonatomic,strong) UILabel *showTitle;

@property (nonatomic,strong) NSArray *times;

@property (nonatomic,strong) NSString *selectedTime;

@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,strong)UIButton *cancelBtn;

@property (nonatomic,copy) void (^chooseTimeBlock)(NSString *selectedTime);

@property (nonatomic,strong) NSString *time;
@end
