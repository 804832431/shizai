//
//  NSOperationQueue+VSOperationQueue.m
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "NSOperationQueue+VSOperationQueue.h"

@implementation NSOperationQueue (VSOperationQueue)

+ (dispatch_queue_t) findCurrentQueue
{
    dispatch_queue_t currentQueue = dispatch_get_current_queue();
    dispatch_queue_t rqueue;
    if (currentQueue == dispatch_get_main_queue())
    {
        dispatch_queue_t q= dispatch_queue_create("com.vs.http", nil);
        rqueue = q;
    }else{
        rqueue = currentQueue;
    }
    return rqueue;
}

+ (dispatch_queue_t) mainqueue
{
    return dispatch_get_main_queue();
}

@end
