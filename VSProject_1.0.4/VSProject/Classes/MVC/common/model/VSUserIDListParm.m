//
//  VSUserIDListParm.m
//  VSProject
//
//  Created by user on 15/3/3.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSUserIDListParm.h"

@implementation VSUserIDListParm

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.vm_pageIndex  = 1;
        self.vm_pageLength = KLISTREQUESTLENGTH;
    }
    return self;
}

@end
