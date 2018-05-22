//
//  ShoppingCartInfoDTO.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ShoppingCartInfoDTO.h"
#import "CartItemDTO.h"

@implementation ShoppingCartInfoDTO


- (instancetype) initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"cartItems"]) {
        
        NSMutableArray *tmpArr = [NSMutableArray array];
        NSArray *arr = (NSArray *)value;
        
        for (NSDictionary *dic  in arr) {
            CartItemDTO *dto = [[CartItemDTO alloc] initWithDictionary:dic error:nil];
            if (dto) {
                [tmpArr addObject:dto];
            }
        }
        
        self.cartItemsList = [NSArray arrayWithArray:tmpArr];
    }
}

@end
