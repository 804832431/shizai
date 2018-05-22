//
//  EnterpriseModel.m
//  VSProject
//
//  Created by pangchao on 16/12/30.
//  Copyright © 2016年 user. All rights reserved.
//

#import "EnterpriseModel.h"

@implementation EnterpriseModel

- (id)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        self.name = [dic objectForKey:@"name"];
        self.image = [dic objectForKey:@"image"];
        self.logo = [dic objectForKey:@"logo"];
        self.themeColor = [dic objectForKey:@"themeColor"];
        self.enterpriseDetail = [dic objectForKey:@"enterpriseDetail"];
    }
    return self;
}

@end
