//
//  MeConfigDTO.m
//  VSProject
//
//  Created by pangchao on 16/12/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MeConfigDTO.h"

@implementation MeConfigDTO

- (id)init {
    
    self = [super init];
    if (self) {
        self.iconName = @"";
        self.iconUrl = @"";
        self.title = @"";
        self.arrowImageName = @"";
        self.directUrl = @"";
    }
    return self;
}

@end
