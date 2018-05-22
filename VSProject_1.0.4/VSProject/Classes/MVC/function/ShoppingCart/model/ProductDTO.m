//
//  ProductDTO.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ProductDTO.h"

@implementation ProductDTO

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
