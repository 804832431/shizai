//
//  VSWalletDataInfo.h
//  VSProject
//
//  系统中用户钱包数据对象
//
//  Created by tiezhang on 15/2/26.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface VSWalletDataInfo : VSBaseDataModel

_PROPERTY_NONATOMIC_STRONG(NSString, vm_qingDouNum);    //剩余情豆数量

_PROPERTY_NONATOMIC_STRONG(NSString, vm_qingHuaNum);    //剩余情花数量

@end
