//
//  MessageListModel.h
//  VSProject
//
//  Created by certus on 16/1/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"
#import "MessageModel.h"

@interface MessageListModel : VSBaseNeedSaveDataModel

@property (nonatomic,strong)NSString <Optional>*count;
@property (nonatomic,strong)NSString <Optional>*hasNext;
//@property (nonatomic,strong)NSArray <MessageModel *>*messageList;
_PROPERTY_NONATOMIC_STRONG(NSArray, __dataitem_typeof__(MessageModel) messageList);           //地址数组

@end
