//
//  NotificationAgentViewController.h
//  VSProject
//
//  Created by certus on 16/3/27.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseViewController.h"
#import "Order.h"


typedef NS_ENUM(NSUInteger, kNotificationAgentType) {
    kAgenStatusAll,//全部订单
    kAgenStatusSubmit,//待处理
    kAgenStatusProcessing,//处理中
    kAgenStatusConfirm,//预约成功
    kAgenStatusReject,//预约失败
    kAgenStatusCanceled//已取消
};

@interface NotificationAgentViewController : VSBaseViewController<UIAlertViewDelegate>

@property (nonatomic,assign) kNotificationAgentType orderType;

@property (nonatomic,assign) NSInteger index;//选中segmentView index

@property (nonatomic,strong) Order *cancelOrder;

- (void)refresh;

@end
