//
//  MessageListModel.m
//  VSProject
//
//  Created by certus on 16/1/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MessageListModel.h"

@implementation MessageListModel

+(JSONKeyMapper *)keyMapper {

    return [[JSONKeyMapper alloc]initWithDictionary:@{@"messageList.createTime":@"createTime",
                                                     @"messageList.id":@"id",
                                                     @"messageList.isRead":@"isRead",
                                                     @"messageList.message":@"message",
                                                     @"messageList.partyId":@"partyId",
                                                     @"messageList.redirectKey":@"redirectKey",
                                                     @"messageList.redirectValue":@"redirectValue",
                                                      }];
}

@end
