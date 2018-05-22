//
//  NewActivityModel.h
//  VSProject
//
//  Created by apple on 10/12/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"

@interface NewActivityModel : VSBaseNeedSaveDataModel

@property (nonatomic,copy)NSString <Optional>*activityId;	//活动id
@property (nonatomic,copy)NSString <Optional>*title;	//标题
@property (nonatomic,copy)NSString <Optional>*orderId;   //订单ID
@property (nonatomic,copy)NSString <Optional>*largeImage;	//大图
@property (nonatomic,copy)NSString <Optional>*smallImage;	//小图
@property (nonatomic,copy)NSString <Optional>*activityLocation;	//活动地点
@property (nonatomic,copy)NSString <Optional>*enrollStartTime;	//报名开始时间
@property (nonatomic,copy)NSString <Optional>*enrollEndTime;	//报名结束时间
@property (nonatomic,copy)NSString <Optional>*activityStartTime;	//活动开始时间
@property (nonatomic,copy)NSString <Optional>*activityEndTime;	//活动结束时间
@property (nonatomic,copy)NSString <Optional>*chargeType;	//费用类型	"free：免费 charge：收费"
@property (nonatomic,copy)NSString <Optional>*charge;	//费用（元/人）
@property (nonatomic,copy)NSString <Optional>*userEncrollStatus;	//用户报名状态	"HAS_ENCROLL:已报名 NOT_ENCROLL:未报名"
@property (nonatomic,copy)NSString <Optional>*encrollStatus;	//活动报名状态	NOT_START：即将报名，STARTED：报名中，COMPLETED：报名结束'
@property (nonatomic,copy)NSString <Optional>*activityStatus;	//活动状态	DELETED，已删除，NOT_START：未开始，STARTED：已开始，COMPLETED：已结束',
@property (nonatomic,copy)NSString <Optional>*isCollected;	//"是否已收藏 Y:是 N:否
@property (nonatomic,copy)NSString <Optional>*isCompleteEncrollInfo;	 //是否已完善报名信息	"Y:是 N:否"
@property (nonatomic,copy)NSString <Optional>*activityDetail;	//活动详情url

@end
