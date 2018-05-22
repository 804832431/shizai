//
//  categoryId categoryName categoryId categoryName Category.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/20.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CategoryDTO.h"
#import "ProductDTO.h"


@implementation CategoryDTO

- (instancetype) initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"prodList"]) {
        
        NSMutableArray *tmpArr = [NSMutableArray array];
        NSArray *arr = (NSArray *)value;
        
        for (NSDictionary *dic  in arr) {
            ProductDTO *dto = [[ProductDTO alloc] initWithDictionary:dic error:nil];
            if (dto) {
                [tmpArr addObject:dto];
            }
        }
        
        self.prodsList = [NSArray arrayWithArray:tmpArr];
    }
    
    if ([key isEqualToString:@"orderType"]) {
        self.orderTypeId = value;
    }
}

@end
