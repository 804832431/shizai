//
//  TagsDTO.m
//  VSProject
//
//  Created by pch_tiger on 16/12/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TagsDTO.h"

@implementation TagsDTO

- (id)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        self.tagsId = [dic objectForKey:@"labelId"];
        if (self.tagsId == nil) {
            self.tagsId = @"";
        }
        self.tagsName = [dic objectForKey:@"labelName"];
        if (self.tagsName == nil) {
            self.tagsName = @"";
        }
        self.isMarking = [dic objectForKey:@"isMarking"];
        if (self.isMarking == nil) {
            self.isMarking = @"";
        }
    }
    return self;
}

@end
