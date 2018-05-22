//
//  RTXOrganizationParm.m
//  VSProject
//
//  Created by XuLiang on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXOrganizationParm.h"

@implementation RTXOrganizationParm

//参数对象序列化成字典对象
- (NSDictionary*)vp_parmSerialize{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.organization_id forKey:@"organizationId"];
    [dic setValue:self.page forKey:@"page"];
    [dic setValue:self.row forKey:@"row"];
    return dic;
}

@end
