//
//  MessageModel.h
//  VSProject
//
//  Created by certus on 16/1/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"

@interface MessageModel : VSBaseNeedSaveDataModel

@property (nonatomic,strong)NSString <Optional>*createTime;
@property (nonatomic,strong)NSString <Optional>*id;
@property (nonatomic,strong)NSString <Optional>*isRead;
@property (nonatomic,strong)NSString <Optional>*message;
@property (nonatomic,strong)NSString <Optional>*partyId;
@property (nonatomic,strong)NSString <Optional>*redirectKey;
@property (nonatomic,strong)NSString <Optional>*redirectValue;

@end
