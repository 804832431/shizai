//
//  OrderDetailDTO.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/2.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderHeader.h"


/**======= <#description#> ========*/
@interface OrderDetailDTO : NSObject

/** <#description#> */
@property (nonatomic, copy) NSString* discountAmount;

/** <#description#> */
@property (nonatomic, copy) NSString* orderAdjustmentList;

/** <#description#> */
@property (nonatomic, copy) NSString* payDate;

/** <#description#> */
@property (nonatomic, copy) NSString* createDate;

/** <#description#> */
@property (nonatomic, strong) NSArray* orderStatusList;

/** <#description#> */
@property (nonatomic, strong) OrderHeader * orderHeader;

/** <#description#> */
@property (nonatomic, copy) NSString* trackingNum;

/** <#description#> */
@property (nonatomic, copy) NSString* postAddress;

/** <#description#> */
@property (nonatomic, copy) NSString* completedDate;

/** <#description#> */
@property (nonatomic, copy) NSString* orderSubTotal;

/** <#description#> */
@property (nonatomic, copy) NSString* orderShippingTotal;

/** <#description#> */
@property (nonatomic, copy) NSString* sentDate;

/** <#description#> */
@property (nonatomic, copy) NSString* errorMessage;

/** <#description#> */
@property (nonatomic, strong) NSArray* productList;

/** <#description#> */
@property (nonatomic, copy) NSString* returnReason;

/** <#description#> */
@property (nonatomic, copy) NSString* expressCompany;

/** <#description#> */
@property (nonatomic, copy) NSString* resultCode;

@end

/**======= <#description#> ========*/
@interface OrderStatus : NSObject

/** <#description#> */
@property (nonatomic, copy) NSString* ORDER_ID;

/** <#description#> */
@property (nonatomic, copy) NSString* ORDER_ITEM_SEQ_ID;

/** <#description#> */
@property (nonatomic, copy) NSString* LAST_UPDATED_STAMP;

/** <#description#> */
@property (nonatomic, copy) NSString* CHANGE_REASON;

/** <#description#> */
@property (nonatomic, copy) NSString* LAST_UPDATED_TX_STAMP;

/** <#description#> */
@property (nonatomic, assign) NSInteger  STATUS_DATETIME;

/** <#description#> */
@property (nonatomic, copy) NSString* CREATED_STAMP;

/** <#description#> */
@property (nonatomic, assign) NSInteger  STATUS_USER_LOGIN;

/** <#description#> */
@property (nonatomic, assign) NSInteger  ORDER_STATUS_ID;

/** <#description#> */
@property (nonatomic, copy) NSString* ORDER_PAYMENT_PREFERENCE_ID;

/** <#description#> */
@property (nonatomic, copy) NSString* CREATED_TX_STAMP;

/** <#description#> */
@property (nonatomic, copy) NSString* STATUS_ID;

@end



