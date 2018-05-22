//
//  SendTimeChooseView.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/15.
//  Copyright © 2015年 user. All rights reserved.
//

#import "SendTimeChooseView.h"
#import "UIColor+TPCategory.h"


@implementation SendTimeChooseView

- (UIView *)bgView{
    
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor colorFromHexRGB:@"ffffff"];
    }
    
    return _bgView;
}

- (UIButton *)bgButton{
    
    if (_bgButton == nil) {
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.backgroundColor = [UIColor clearColor];
        [_bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _bgButton;
}

- (void)bgButtonAction{
    
    [self removeFromSuperview];
    
}

- (UIPickerView *)pickerView{
    
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    
    return _pickerView;
}

- (UILabel *)showTitle{
    
    if (_showTitle == nil) {
        _showTitle = [UILabel new];
        _showTitle.text = @"请选择配送时间";
        _showTitle.textAlignment = NSTextAlignmentCenter;
        _showTitle.textColor = [UIColor colorFromHexRGB:@"666666"];
        _showTitle.backgroundColor = [UIColor colorFromHexRGB:@"eeeeee"];
        _showTitle.font = [UIFont systemFontOfSize:12];
    }
    
    return _showTitle;
}

- (UIButton *)cancelBtn{
    
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(20, (50-28)/2, 50, 28);
        [_cancelBtn setTitleColor:_COLOR_HEX(0x35b38d) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelBtn;
}

- (UIButton *)sureBtn{
    
    if (_sureBtn == nil) {
        
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-28-40, (50-28)/2, 50, 28);
        [_sureBtn setTitleColor:_COLOR_HEX(0x35b38d) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _sureBtn;
}

- (void)cancelBtnAction{
    
    [self removeFromSuperview];
    
}

- (void)sureBtnAction{
    
    if (self.chooseTimeBlock) {
        self.chooseTimeBlock(self.time);
    }
    
    [self removeFromSuperview];
}

#pragma mark -

- (instancetype) init{
    
    self = [super init];
    
    if (self) {
        
        [self addSubview:self.pickerView];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.bgButton];
        [self addSubview:self.bgView];
        
        
        [self.bgView addSubview:self.showTitle];
        [self.bgView addSubview:self.pickerView];
        
        [self.bgView addSubview:self.cancelBtn];
        [self.bgView addSubview:self.sureBtn];
        
        self.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.6];
        
        [self updateConstraintsForSubViews];
        
        NSDate *now = [NSDate date];
        
        NSDate *today = [self theDay:0];
        NSDate *todayTwo = [self theDayHour:14 fromNSDate:today];
        NSDate *todayOne = [self theDayHour:13 fromNSDate:today];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        
        NSString *hour = [formatter stringFromDate:now];
        
        if ([now compareToDate:todayOne]) {
            NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:@[@"14:00－15:00",
                                                                      @"15:00－16:00",
                                                                      @"16:00－17:00",
                                                                      @"17:00－18:00",
                                                                      @"18:00－19:00",
                                                                      @"19:00－20:00",
                                                                      @"20:00－21:00"]];
            
            NSMutableArray *delteArr = [NSMutableArray array];
            for (NSString *str  in tmpArr) {
                if ([hour compare:str] == NSOrderedDescending) {
                    [delteArr addObject:str];
                }
            }
            
            if (delteArr.count > 0) {
                [tmpArr removeObjectsInArray:delteArr];
            }
            
            self.times =  tmpArr;
            
            
        }else{
            
            NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:@[
                                                                      @"11:00－12:00",
                                                                      @"12:00－13:00",
                                                                      @"13:00－14:00"
                                                                      ]];
            NSMutableArray *delteArr = [NSMutableArray array];
            for (NSString *str  in tmpArr) {
                if ([hour compare:str] == NSOrderedDescending) {
                    [delteArr addObject:str];
                }
            }
            
            if (delteArr.count > 0) {
                [tmpArr removeObjectsInArray:delteArr];
            }
            
            self.times =  tmpArr;
            
            
        }
        
        if (self.times.count ==0) {
            self.time = @"";
        }else{
            self.time = self.times.firstObject;
        }
        
        if (self.times.count == 0 ) {
            self.times = @[@""];
        }
    }
    
    
    
    return self;
}


- (void)updateConstraintsForSubViews{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(weakSelf);
        make.height.equalTo(@250).priority(MASLayoutPriorityDefaultHigh);
    }];
    
    [self.bgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.bgView.mas_top);
    }];
    
    [self.showTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(weakSelf.bgView);
        make.height.equalTo(@50);
    }];
    
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf.bgView);
        make.top.equalTo(weakSelf.showTitle.mas_bottom);
    }];
    
    
    
}

#pragma mark -

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSLog(@"%zi",self.times.count);
    return self.times.count;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.times[row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (row <= self.times.count -1) {
        self.time = self.times[row];
    }
    
    
    
    
}



- (CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}


- (NSDate *)theDay:(NSInteger)dayNum
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setDay:dayNum];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMdd"];
    
    NSString *result = [formatter stringFromDate:newdate];
    
    NSDate *resultDate = [formatter dateFromString:result];
    
    return resultDate;
}

- (NSDate *)theDayHour:(NSInteger)hourNum fromNSDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitHour fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setHour:hourNum];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMddHHmmSS"];
    
    return newdate;
}


@end
