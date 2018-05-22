//
//  AuthedEnterprise.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bidder.h"

@interface AuthedEnterprise : NSObject

/*
 认证状态，
 UNAPPLY：未申请过
 UNRESOLVED：待认证，
 PASS：已通过，
 REJECT：已拒绝
 */
@property (nonatomic,strong) NSString *authStatus;

@property (nonatomic,strong) Bidder *bidder;

@end
