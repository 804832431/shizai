//
//  PolicySelectTimeView.h
//  VSProject
//
//  Created by apple on 7/3/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OnSelectedTimeBlock)(NSString *timeString);

@interface PolicySelectTimeView : UIView <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

_PROPERTY_NONATOMIC_STRONG(UITableView, timeTableView);
_PROPERTY_NONATOMIC_STRONG(NSString , selectedTime);

@property (nonatomic, strong) OnSelectedTimeBlock onSelectedTimeBlock;

@end
