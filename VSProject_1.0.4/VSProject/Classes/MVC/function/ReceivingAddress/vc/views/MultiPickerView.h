//
//  MultiPickerView.h
//  VSProject
//
//  Created by certus on 15/11/9.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessoryView.h"

@class MultiPickerView;
@protocol MultiPickerViewDelegate <NSObject>

- (void)MultiPickerView:(MultiPickerView *)pickerView leftValue:(NSString *)leftValue middleValue:(NSString *)middleValue rightValue:(NSString *)rightValue;
- (void)MultiPickerView:(MultiPickerView *)pickerView requestLocations:(NSString *)type dataId:(NSString *)dataId;

@end
@interface MultiPickerView : UIView {

    NSString *leftValue;
    NSString *middleValue;
    NSString *rightValue;
}

@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)UIView *baseView;
@property (nonatomic,strong)NSArray *leftArray;
@property (nonatomic,strong)NSArray *middleArray;
@property (nonatomic,strong)NSArray *rightArray;
@property (nonatomic,strong)AccessoryView *accessoryView;
@property (nonatomic,assign)id <MultiPickerViewDelegate>delegate;

- (void)show;
- (void)hide;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
