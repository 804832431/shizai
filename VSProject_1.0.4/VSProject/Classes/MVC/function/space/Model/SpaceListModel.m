//
//  SpaceModel.m
//  VSProject
//
//  Created by pangchao on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpaceListModel.h"

@implementation SpaceListModel

- (id)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        self.spaceId = [dic objectForKey:@"spaceId"];
        self.spaceType = [dic objectForKey:@"spaceType"];
        self.title = [dic objectForKey:@"title"];
        self.picListUrl = [dic objectForKey:@"picListUrl"];
        self.isLargeImage = [dic objectForKey:@"isLargeImage"];
        self.roomInfo = [dic objectForKey:@"roomInfo"];
        self.singlePrice = [dic objectForKey:@"singlePrice"];
        self.isCollected = [dic objectForKey:@"isCollected"];
        self.spaceDetail = [dic objectForKey:@"spaceDetail"];
    }
    return self;
}

@end
