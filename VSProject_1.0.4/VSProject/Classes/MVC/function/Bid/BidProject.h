//
//  BidProject.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BidProject : NSObject

@property (nonatomic,strong)NSString* bidProjectId ;//招标项目id
@property (nonatomic,strong)NSString* projectName	;//招标项目名称
@property (nonatomic,strong)NSString* capitalSource	;//资金来源
@property (nonatomic,strong)NSString* projectType	;//项目类型
@property (nonatomic,strong)NSString* area	;//项目所在地区
@property (nonatomic,strong)NSString* projectBudget	;//项目预算
@property (nonatomic,strong)NSString* bidBeginTime	;//招标开始时间
@property (nonatomic,strong)NSString* bidEndTime	;//招标结束时间

/*
 DELETED，已删除，
 NOT_START：未开始，
 STARTED：已开始，
 COMPLETED：已结束
 */
@property (nonatomic,strong)NSString* bidStatus	;//招标状态


/*
 UNAPPLY：未申请过
 UNRESOLVED：待认证，
 PASS：已通过，
 REJECT：已拒绝
 */
@property (nonatomic,strong)NSString* bidderAuthStatus;// 投标商认证状态	认证状态;

/*
 未开标：NOT_OPEN
 已中标：WIN
 未中标：NOT_WIN
 流标：FAILING
 */
@property (nonatomic,strong)NSString* bidderProjectStatus;//投标商投标项目状态	中标状态：

/*
 Y:是;
 N:否
 */
@property (nonatomic,strong)NSString* isCollected ;//用户是否已收藏该项目	是否已收藏

@property (nonatomic,strong)NSString* projectUrl;//招标url





@property (nonatomic,strong)NSString* bidDeposit;//投标保证金
@property (nonatomic,strong)NSString* orderId;//订单id
@property (nonatomic,strong)NSString* canReturn;//是否可以申请退款	Y:是; N:否

/*
 退款申请中：
 RETURN_REQUESTED；
 已同意：
 RETURN_ACCEPTED，
 已退款：
 RETURN_COMPLETED
 */
@property (nonatomic,strong)NSString* returnStatus;//退款状态

@property (nonatomic,strong)NSString *paymentType;//支付方式，EXT_ALIPAY：支付宝， EXT_WECHATPAY：微信

//中标单位
@property (nonatomic,strong)NSString *bidderCorp;
/*项目本身状态 
 NOT_OPEN：未开标，COMPLETED：已完成，FAILING：流标
 */
@property (nonatomic,strong)NSString *resultStatus;

@end
