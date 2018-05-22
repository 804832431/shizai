//
//  SpaceProjectModel.m
//  VSProject
//
//  Created by pangchao on 2017/10/24.
//  Copyright © 2017年 user. All rights reserved.
//

#import "SpaceProjectModel.h"

@implementation SpaceProjectModel

- (id)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        self.projectId = [dic strValue:@"projectId"];
        self.title = [dic strValue:@"title"];
        self.projectUrl = [dic strValue:@"projectUrl"];
        self.areaInfo = [dic strValue:@"areaInfo"];
        self.projectDetail = [dic strValue:@"projectDetail"];
        self.trafficInfo = [dic strValue:@"trafficInfo"];
        self.singlePrice = [dic strValue:@"singlePrice"];
        self.isCollected = [dic strValue:@"isCollected"];
        
    }
    return self;
}

@end
