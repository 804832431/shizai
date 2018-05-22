//
//  DriveTimePickerView.h
//  Modify by Thomas on 15-12-03.


#import <UIKit/UIKit.h>

@protocol DriveTimePickerViewDelegate <NSObject>

- (void)cancelTimeChoose;
- (void)selectTime;

@end

@interface DriveTimePickerView : UIView

@property (nonatomic, strong) UIPickerView *m_timePicker;
@property (nonatomic, weak) id<DriveTimePickerViewDelegate>m_delegate;

@end
