//
//  BidderManager.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bidder.h"
#import "AuthedEnterprise.h"

@interface BidderManager : NSObject

@property (nonatomic,strong) AuthedEnterprise *authedEnterPrise;

+ (instancetype) shareInstance;

@end
