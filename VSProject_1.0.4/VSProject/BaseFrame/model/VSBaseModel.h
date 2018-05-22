//
//  VSBaseModel.h
//  VSProject
//
//************************************整个项目的超基模型******************************************************/
//          此类可以派生出:VSBaseDataModel, VSBaseParmModel, VSBaseManager等
//************************************整个项目的超基模型******************************************************/
//
//
//  Created by user on 15/1/11.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
@protocol VSBaseModelProtocol <NSObject>


@end

@interface VSBaseModel : JSONModel<VSBaseModelProtocol>

@end
