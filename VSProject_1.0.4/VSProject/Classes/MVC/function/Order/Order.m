//
//  Order.m
//  VSProject
//
//  Created by 陈 海涛 on 15/11/23.
//  Copyright © 2015年 user. All rights reserved.
//

#import "Order.h"

@implementation Order


- (instancetype) initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    
    self = [super init];
    
    if (self) {
        
        self.orderHeader = [[OrderHeader alloc] initWithDictionary:dict[@"orderHeader"] error:nil];
        NSArray *arr = dict[@"productList"];
        if (arr == nil) {
            arr = dict[@"orderProduct"];
        }
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            OrderProduct *p  = [[OrderProduct alloc] initWithDictionary:dic  error:nil];
            [list addObject:p];
        }
        self.orderProductList = list;
        self.postAddress = [[OrderPostAddress alloc] initWithDictionary:dict[@"postAddress"] error:nil];
        
        self.trackingNum = dict[@"trackingNum"];//	快递单号
        self.expressCompany = dict[@"expressCompany"];//	快递公司
        self.createDate = dict[@"createDate"];//	下单时间
        self.sentDate = dict[@"sentDate"];//	发货时间（未发货，该值为空）
        self.completedDate = dict[@"completedDate"];//	收货时间（未收货，该值为空）
        self.returnReason = dict[@"returnReason"];//	退货理由(未申请退货，该值为空)
        self.orderStatusList = dict[@"orderStatusList"];//	订单状态列表(只提供给后端使用)
        self.orderAdjustmentList = dict[@"orderAdjustmentList"];//	订单调整列表(只提供给后端使用)
        self.orderSubTotal = dict[@"orderSubTotal"];//	订单总额优惠前(商品未打折,不含运费,只提供给后端使用)
        self.orderShippingTotal = dict[@"orderShippingTotal"];//	运费(只提供给后端使用)
        self.discountAmount = dict[@"discountAmount"];//	订单优惠额
        self.payDate = dict[@"payDate"];//	支付日期
        
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}



@end
