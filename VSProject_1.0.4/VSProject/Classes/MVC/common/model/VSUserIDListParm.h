//
//  VSUserIDListParm.h
//  VSProject
//
//  Created by user on 15/3/3.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSUserIDParm.h"

@interface VSUserIDListParm : VSUserIDParm

//页码default 1
_PROPERTY_NONATOMIC_ASSIGN(NSInteger, vm_pageIndex);

//每页长度default 50
_PROPERTY_NONATOMIC_ASSIGN(NSInteger, vm_pageLength);

@end
