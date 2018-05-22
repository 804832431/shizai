//
//  TopicProductDTO.m
//  VSProject
//
//  Created by pangchao on 17/6/27.
//  Copyright © 2017年 user. All rights reserved.
//

#import "TopicProductDTO.h"

@implementation TopicProductDTO

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        self.productId = [dic strValue:@"productId"];
        self.mainTitle = [dic strValue:@"mainTitle"];
        self.subTile = [dic strValue:@"subTile"];
        self.photo = [dic strValue:@"photo"];
        self.productDetailUrl = [dic strValue:@"productDetailUrl"];
    }
    
    return self;
}

@end
