//
//  NSOperationQueue+VSOperationQueue.h
//  VSProject
//
//  Created by tiezhang on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationQueue (VSOperationQueue)

+(dispatch_queue_t)findCurrentQueue;

+(dispatch_queue_t)mainqueue;

@end
