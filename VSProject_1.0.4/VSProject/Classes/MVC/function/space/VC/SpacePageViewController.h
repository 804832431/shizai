//
//  SpacePageViewController.h
//  VSProject
//
//  Created by pangchao on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import "VSBaseViewController.h"

typedef enum
{
    SPACE_LEASE_TYPE = 1,
    CONFERENCE_ROOM_TYPE = 2,
    MOBILE_STATION_TYPE = 3,
    SPACE_ACQUISITION = 4,
    SPACE_LEASE_TYPE_OLD = 5,
} SPACE_TYPE;

@interface SpacePageViewController : VSBaseViewController

@property (nonatomic, assign) SPACE_TYPE spaceType;

@property (nonatomic, strong) NSString *classId;

@end
