//
//  ServerProductDTO.m
//  VSProject
//
//  Created by pch_tiger on 16/12/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ServerProductDTO.h"

@implementation ServerProductDTO

- (id)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        self.appName = [dic objectForKey:@"appName"];
        self.productName = [dic objectForKey:@"productName"];
        self.listImageUrl = [dic objectForKey:@"listImageUrl"];
        self.productType = [dic objectForKey:@"productType"];
        self.price = [dic objectForKey:@"price"];
        self.dealedCount = [dic objectForKey:@"dealedCount"];
        self.subCount = [dic objectForKey:@"subCount"];
        self.productDetail = [dic objectForKey:@"productDetailUrl"];
    }
    return self;
}

@end
