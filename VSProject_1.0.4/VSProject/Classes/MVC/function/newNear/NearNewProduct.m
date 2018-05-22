//
//  NearNewProduct.m
//  VSProject
//
//  Created by 陈 海涛 on 16/7/29.
//  Copyright © 2016年 user. All rights reserved.
//

#import "NearNewProduct.h"

@implementation NearNewProduct

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"promotionTypes"]) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            PromotionType *type = [[PromotionType alloc] initWithDictionary:dic error:nil];
            [arr addObject:type];
        }
        
        self.thepromotionTypes = [NSArray arrayWithArray:arr];
    }
}

@end


@implementation PromotionType

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}
@end