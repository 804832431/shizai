//
//  SinglePickerView.h
//  VSProject
//
//  Created by certus on 16/3/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessoryView.h"

typedef enum : NSUInteger {
    PICKER_NORMAL=0,
    PICKER_DATE,
} PICKER_TYPE;

@class SinglePickerView;

@protocol SinglePickerViewDelegate <NSObject>

- (void)SinglePickerView:(SinglePickerView *)pickerView selectedValue:(NSString *)selectedValue;

@end
@interface SinglePickerView : UIView

@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)UIDatePicker *dataPickerView;
@property (nonatomic,strong)UIView *baseView;
@property (nonatomic,strong)NSString *selectedValue;
@property (nonatomic,strong)NSArray *dataList;
@property (nonatomic,strong)AccessoryView *accessoryView;
@property (nonatomic,assign)id <SinglePickerViewDelegate>delegate;
@property (nonatomic,assign)PICKER_TYPE pickerType;

- (id)initWithFrame:(CGRect)frame pickerViewType:(PICKER_TYPE)pickerType;
- (void)show;
- (void)hide;

@end
