//
//  WYMsgResultMeta.m
//  QlmGIS
//
//  Created by tiezhang on 14-10-21.
//  Copyright (c) 2014年 zhangtie. All rights reserved.
//

#import "WYMsgResultMeta.h"

//解析字典
#ifndef PUGetElemForKeyFromDict
#define PUGetElemForKeyFromDict(__key, __dict)   [QlmUtil getElementForKey:__key fromDict:__dict]
#endif

#ifndef PUGetObjFromDict
#define PUGetObjFromDict(__key, __dict, __class) [QlmUtil getElementForKey:__key fromDict:__dict forClass:__class]
#endif

@implementation WYMsgResultMeta

+ (instancetype)resultWithAttributes:(NSDictionary *)attributes
{
    return [[[self class] alloc]initWithDict:attributes];

}

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.status  = (QLMRESULT_STATUS)[PUGetElemForKeyFromDict(@"status", dict) integerValue];
        self.message = PUGetElemForKeyFromDict(@"msg", dict);
    }
    return self;
}

- (BOOL)success
{
    return (self.status == QLMRESULT_STATUS_SUCCESS);
}

@end
