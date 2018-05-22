//
//  SinglePickerView.m
//  VSProject
//
//  Created by certus on 16/3/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SinglePickerView.h"

#define AccessoryHeight  170/3
#define PickerViewHeight 150

@implementation SinglePickerView

- (id)initWithFrame:(CGRect)frame pickerViewType:(PICKER_TYPE)pickerType{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _pickerType = pickerType;
        
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-(AccessoryHeight+PickerViewHeight), frame.size.width, AccessoryHeight+PickerViewHeight)];
        _baseView.backgroundColor = [UIColor whiteColor];
        
        _accessoryView = [[AccessoryView alloc]initWithFrame:CGRectMake(0, 0, _baseView.frame.size.width, AccessoryHeight)];
        [_accessoryView.cancelBtn addTarget:self action:@selector(actionCancel) forControlEvents:UIControlEventTouchUpInside];
        [_accessoryView.sureBtn addTarget:self action:@selector(actionSure) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_accessoryView];
        
        
        if (pickerType == PICKER_DATE) {
            _dataPickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 30,_baseView.frame.size.width, PickerViewHeight + 30)];
            _dataPickerView.datePickerMode = UIDatePickerModeDate;
            [_dataPickerView setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
            _dataPickerView.date = [NSDate date];
            [self translationDate:[NSDate date]];
            [_dataPickerView addTarget:self action:@selector(changeDatePicker:) forControlEvents:UIControlEventValueChanged];
            [_baseView insertSubview:_dataPickerView belowSubview:_accessoryView];

        }else {
            _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, AccessoryHeight,_baseView.frame.size.width, PickerViewHeight)];
            _pickerView.delegate = (id<UIPickerViewDelegate>)self;
            _pickerView.dataSource = (id<UIPickerViewDataSource>)self;
            [_baseView addSubview:_pickerView];
        }
        
        [_accessoryView setBackgroundColor:_baseView.backgroundColor];
    }
    
    return self;
}

#pragma mark -- Action

- (void)actionCancel {
    
    [self hide];
}

- (void)actionSure {
    
    [self hide];
    
    if (_delegate && [_delegate respondsToSelector:@selector(SinglePickerView:selectedValue:)]) {
        [_delegate SinglePickerView:self selectedValue:_selectedValue];
    }
}

#pragma mark -- public

- (void)changeDatePicker:(UIDatePicker *)picker {

    NSDate *date = picker.date;
    [self translationDate:date];
}

- (void)translationDate:(NSDate *)date {
    NSDateFormatter *dateFormat = [ [NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    _selectedValue = [dateFormat stringFromDate:date];

}
- (void)show {
    
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5f];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CATransition *transition = [CATransition animation];
        transition.duration = 0.4f;
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromLeft;
        [self addSubview:_baseView];
        
        [self.layer addAnimation:transition forKey:@"accessoryView"];
    });
    if (_pickerType != PICKER_DATE) {
        _selectedValue = [_dataList objectAtIndex:0];
    }

}

- (void)hide {
    
    self.backgroundColor = [UIColor clearColor];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4f;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromLeft;
    [_baseView removeFromSuperview];
    
    [self.layer addAnimation:transition forKey:@"accessoryView"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}

#pragma mark -- UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return _dataList.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 45;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 80)];
    titleLabel.numberOfLines = 0;
    titleLabel.font =[UIFont boldSystemFontOfSize:15.f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = _COLOR_HEX(0x333333);
    titleLabel.text = [_dataList objectAtIndex:row];
    [titleLabel sizeToFit];
    
    return titleLabel;
}

#pragma mark -- UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    _selectedValue = [_dataList objectAtIndex:row];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
