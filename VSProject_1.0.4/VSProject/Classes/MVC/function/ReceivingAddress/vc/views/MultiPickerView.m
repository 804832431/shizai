//
//  MultiPickerView.m
//  VSProject
//
//  Created by certus on 15/11/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import "MultiPickerView.h"

#define AccessoryHeight  170/3
#define PickerViewHeight 150


@implementation MultiPickerView

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-(AccessoryHeight+PickerViewHeight), frame.size.width, AccessoryHeight+PickerViewHeight)];
        _baseView.backgroundColor = [UIColor whiteColor];

        _accessoryView = [[AccessoryView alloc]initWithFrame:CGRectMake(0, 0, _baseView.frame.size.width, AccessoryHeight)];
        [_accessoryView.cancelBtn addTarget:self action:@selector(actionCancel) forControlEvents:UIControlEventTouchUpInside];
        [_accessoryView.sureBtn addTarget:self action:@selector(actionSure) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:_accessoryView];
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, AccessoryHeight,_baseView.frame.size.width, PickerViewHeight)];
        _pickerView.delegate = (id<UIPickerViewDelegate>)self;
        _pickerView.dataSource = (id<UIPickerViewDataSource>)self;
        [_baseView addSubview:_pickerView];

        [_accessoryView setBackgroundColor:_pickerView.backgroundColor];
    }
    
    return self;
}

#pragma mark -- Action

- (void)actionCancel {

    [self hide];
}

- (void)actionSure {
    
    [self hide];
    
    if (_delegate && [_delegate respondsToSelector:@selector(MultiPickerView:leftValue:middleValue:rightValue:)]) {
        [_delegate MultiPickerView:self leftValue:leftValue middleValue:middleValue rightValue:rightValue];
    }

}

#pragma mark -- public

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
    [self requestLocations:@"province" dataId:@"000"];

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

    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    switch (component) {
        case 0:
            return _leftArray.count;
            break;
            
        case 1:
            return _middleArray.count;
            break;

        case 2:
            return _rightArray.count;
            break;

        default:
            return 0;
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {

    return 45;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {

    NSString *title = @"";
    switch (component) {
        case 0:
        {
            NSDictionary *dic = [_leftArray objectAtIndex:row];
            title = [dic objectForKey:@"province"];
        }
            break;
            
        case 1:
        {
            
            NSDictionary *dic = [_middleArray objectAtIndex:row];
            title = [dic objectForKey:@"city"];
        }
            break;
            
        case 2:
        {
            
            NSDictionary *dic = [_rightArray objectAtIndex:row];
            title = [dic objectForKey:@"area"];
            
        }
            break;
            
        default:
            break;
    }
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 80)];
    titleLabel.numberOfLines = 0;
    titleLabel.font =[UIFont boldSystemFontOfSize:15.f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = _COLOR_HEX(0x333333);
    titleLabel.text = title;
    [titleLabel sizeToFit];

    return titleLabel;
}

#pragma mark -- UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
        
            if (_leftArray.count > row) {
                NSDictionary *dic = [_leftArray objectAtIndex:row];
                NSString *dataeId = [dic objectForKey:@"provinceId"];
                leftValue = [dic objectForKey:@"province"];
                [self requestLocations:@"city" dataId:dataeId];
            }

            _middleArray = nil;
            [_pickerView reloadComponent:1];
            _rightArray = nil;
            [_pickerView reloadComponent:2];
            middleValue = nil;
            rightValue = nil;

        }
            break;
           
        case 1:
        {
            
            if (_middleArray.count > row) {
                NSDictionary *dic = [_middleArray objectAtIndex:row];
                NSString *dataeId = [dic objectForKey:@"cityId"];
                middleValue = [dic objectForKey:@"city"];
                [self requestLocations:@"area" dataId:dataeId];
            }
            _rightArray = nil;
            [_pickerView reloadComponent:2];
            rightValue = nil;

        }
            break;

        default:
        {
            if (_rightArray.count > row) {
                NSDictionary *dic = [_rightArray objectAtIndex:row];
                rightValue = [dic objectForKey:@"area"];
            }
        }

            break;
    }

}

#pragma mark -- Request

//请求省市区
- (void)requestLocations:(NSString *)type dataId:(NSString *)dataId{
    
    if (_delegate && [_delegate respondsToSelector:@selector(MultiPickerView:requestLocations:dataId:)]) {
        [_delegate MultiPickerView:self requestLocations:type dataId:dataId];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
