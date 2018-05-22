//
//  WYMsgResultMeta.h
//  QlmGIS
//
//  Created by tiezhang on 14-10-21.
//  Copyright (c) 2014年 zhangtie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _QLMRESULT_STATUS
{
    QLMRESULT_STATUS_FAILED     = 0,
    QLMRESULT_STATUS_SUCCESS,
}QLMRESULT_STATUS;

@interface WYMsgResultMeta : NSObject

@property (nonatomic, readonly)BOOL  success;
@property (nonatomic, assign) QLMRESULT_STATUS status;
@property (nonatomic, strong) NSString *message;

+ (instancetype)resultWithAttributes:(NSDictionary *)attributes;

@end
