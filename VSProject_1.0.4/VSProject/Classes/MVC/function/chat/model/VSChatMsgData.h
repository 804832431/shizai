//
//  VSChatMsgData.h
//  VSProject
//
//  Created by tiezhang on 15/3/2.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface VSChatMsgData : VSBaseDataModel

_PROPERTY_NONATOMIC_ASSIGN(NSInteger, vm_msgId);//消息id

_PROPERTY_NONATOMIC_STRONG(NSString, vm_sourceUID); //发送人id

_PROPERTY_NONATOMIC_STRONG(NSString, vm_sourceName); //发送人名字

_PROPERTY_NONATOMIC_STRONG(NSString, vm_desUID);    //接收人id

_PROPERTY_NONATOMIC_STRONG(NSString, vm_desName);    //接收人名字

_PROPERTY_NONATOMIC_STRONG(NSString, vm_msgContent);    //消息内容

_PROPERTY_NONATOMIC_STRONG(NSString, vm_msgTime);   //消息时间

@end
