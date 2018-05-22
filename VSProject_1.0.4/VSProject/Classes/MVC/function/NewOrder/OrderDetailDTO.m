//
//  OrderDetailDTO.m
//  VSProject
//
//  Created by 陈 海涛 on 16/9/2.
//  Copyright © 2016年 user. All rights reserved.
//

#import "OrderDetailDTO.h"
#import "ProductDTO.h"

@implementation OrderDetailDTO

+ (NSDictionary *)objectClassInArray{
    return @{@"orderStatusList" : [OrderStatus class],@"productList" : [ProductDTO class]};
}
@end


@implementation OrderStatus

@end