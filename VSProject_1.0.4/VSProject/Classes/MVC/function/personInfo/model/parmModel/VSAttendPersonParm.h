//
//  VSAttendPersonParm.h
//  VSProject
//
//  Created by tiezhang on 15/3/3.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSUserIDParm.h"

@interface VSAddAttendPersonParm : VSUserIDParm

_PROPERTY_NONATOMIC_STRONG(NSString, vm_attendUID); //被关注人ID

@end

@interface VSDelAttendPersonParm : VSUserIDParm

_PROPERTY_NONATOMIC_STRONG(NSString, vm_delAttendUID);

@end
