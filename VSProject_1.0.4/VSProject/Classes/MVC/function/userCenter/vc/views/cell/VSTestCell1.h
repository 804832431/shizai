//
//  VSTestCell1.h
//  VSProject
//
//  Created by tiezhang on 15/1/15.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@class VSTestCell1;
@protocol VSTestCell1Delegate <NSObject>

@optional
- (void)demoClickedEvent:(VSTestCell1*)sender;

@end

@interface VSTestCell1 : VSBaseTableViewCell

_PROPERTY_NONATOMIC_WEAK(id<VSTestCell1Delegate>, delegate);

@end
