//
//  VSBaseParmModel.m
//  VSProject
//
//  Created by user on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseParmModel.h"

@implementation VSBaseParmModel

+ (VSBaseParmModel*)createParmObj
{
    VSBaseParmModel *parm = [[[self class] alloc]init];
    return parm;
}

@end
