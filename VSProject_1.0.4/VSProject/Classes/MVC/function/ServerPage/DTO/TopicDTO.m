//
//  TopicDTO.m
//  VSProject
//
//  Created by pangchao on 17/6/27.
//  Copyright © 2017年 user. All rights reserved.
//

#import "TopicDTO.h"

@implementation TopicDTO

- (instancetype)initWithDic:(NSDictionary *)dic {

    self = [super init];
    if (self) {
        
        self.name = [dic strValue:@"name"];
        self.desc = [dic strValue:@"desc"];
        self.projectList = [NSMutableArray array];
        NSArray *projectList = [dic arrayValue:@"productList"];
        for (NSDictionary *dic in projectList) {
            TopicProductDTO *projectDTO = [[TopicProductDTO alloc] initWithDic:dic];
            
            [self.projectList addObject:projectDTO];
        }
    }
    
    return self;
}

@end
