//
//  RTXRandomProductInfoModel.m
//  VSProject
//
//  Created by XuLiang on 15/11/16.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RTXRandomProductInfoModel.h"

@implementation RTXRandomProductInfoModel

- (instancetype) initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        
        self.m_description = value;
    }
}
@end
