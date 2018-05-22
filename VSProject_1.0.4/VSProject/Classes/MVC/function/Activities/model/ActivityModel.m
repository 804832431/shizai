
//
//  ActivityModel.m
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

+ (JSONKeyMapper *)keyMapper {

    return [[JSONKeyMapper alloc]initWithDictionary:@{@"charge":@"charge",
                                                      @"contact":@"contact",
                                                      @"contactNumber":@"contactNumber",
                                                      @"createTime":@"createTime",
                                                      @"description":@"a_description",
                                                      @"detailImage":@"detailImage",
                                                      @"enrollmentTime":@"enrollmentTime",
                                                      @"eventLocation":@"eventLocation",
                                                      @"eventTime":@"eventTime",
                                                      @"id":@"id",
                                                      @"listImage":@"listImage",
                                                      @"personMax":@"personMax",
                                                      @"status":@"status",
                                                      @"title":@"title"
                                                      }];
}
@end
