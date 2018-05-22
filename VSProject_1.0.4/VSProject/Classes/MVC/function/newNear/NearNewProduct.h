//
//  NearNewProduct.h
//  VSProject
//
//  Created by 陈 海涛 on 16/7/29.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseDataModel.h"



@interface PromotionType : VSBaseDataModel

@property (nonatomic,strong)NSNumber*  promotionType;//促销类型，1:折扣，2:满减，3:赠送，4:免费
@property (nonatomic,strong)NSString*  promotionDes;//描述
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end




@protocol  PromotionType;


@interface NearNewProduct : NSObject

@property (nonatomic,strong)NSString*  productId	;//产品id
@property (nonatomic,strong)NSString* productName	;//产品名称
@property (nonatomic,strong)NSString* merchantId	;//商家id
@property (nonatomic,strong)NSString* merchantName	;//商家名称
@property (nonatomic,strong)NSNumber* avgEvaluation	;//评价（小数点后一位,对商家的评价均分）
@property (nonatomic,strong)NSNumber* price	;//价格
@property (nonatomic,strong)NSNumber* promotionPrice;//之前的价格
@property (nonatomic,strong)NSNumber* dealedCount	;//成交笔数（截止到昨天已成交总和）
@property (nonatomic,strong)NSString* smallImageUrl	;//商品列表图片
@property (nonatomic,strong)NSString* productDetailUrl;//产品详情
@property (nonatomic,strong)NSString* orderType;//订单类型
@property (nonatomic,strong)NSArray<PromotionType> * thepromotionTypes;//折扣类型


- (instancetype)initWithDictionary:(NSDictionary *)dict ;

@end


