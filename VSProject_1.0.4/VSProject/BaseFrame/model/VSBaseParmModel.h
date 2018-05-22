//
//  VSBaseParmModel.h
//  VSProject
//
//************************************整个项目的参数基类模型******************************************************/
//    @desc:
//          1.用于网络请求参数对象
//          2.提供统一序列化协议(vp_parmSerialize)
//************************************整个项目的参数基类模型******************************************************/
//
//  Created by user on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseModel.h"

@protocol VSBaseParmModelProtocol <NSObject>

@optional
//参数对象序列化成字典对象
- (NSDictionary*)vp_parmSerialize;

@end

@interface VSBaseParmModel : VSBaseModel<VSBaseParmModelProtocol>

+ (instancetype)createParmObj;

@end
