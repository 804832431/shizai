//
//  RTXBapplicationsModel.m
//  VSProject
//
//  Created by XuLiang on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXBapplicationsModel.h"

@implementation RTXBapplicationsModel

-(instancetype)initwithDic:(NSDictionary *)dic{
    self.count       = [dic objectForKey:@"count"];
    self.hasNext     = [dic objectForKey:@"hasNext"];
    
    id arry = [dic objectForKey:@"applications"];
    NSMutableArray *applicationsArray = [[NSMutableArray alloc] init];
    if ([arry isKindOfClass:[NSDictionary class]])
    {
        RTXBapplicationInfoModel *model = [[RTXBapplicationInfoModel alloc] init];
        [model initwithDic:arry];
        [applicationsArray addObject:model];
    }else if ([arry isKindOfClass:[NSArray class]])
    {
        for (NSDictionary *dic in arry)
        {
            RTXBapplicationInfoModel *model = [[RTXBapplicationInfoModel alloc] init];
            [model initwithDic:dic];
            [applicationsArray addObject:model];
        }
    }
    self.applications = applicationsArray;
    
    return self;
}
@end
