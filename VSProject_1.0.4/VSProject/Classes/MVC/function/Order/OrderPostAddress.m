//
//  OrderPostAddress.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/23.
//  Copyright © 2015年 user. All rights reserved.
//

#import "OrderPostAddress.h"

@implementation OrderPostAddress


- (instancetype) initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
