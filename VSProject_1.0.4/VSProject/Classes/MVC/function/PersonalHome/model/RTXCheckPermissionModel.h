//
//  RTXCheckPermissionModel.h
//  VSProject
//
//  Created by XuLiang on 15/11/17.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseDataModel.h"

@interface RTXCheckPermissionModel : VSBaseNeedSaveDataModel

_PROPERTY_NONATOMIC_STRONG(NSString, hasPermissionToB);  //是否可以访问B端，true或者false

@end
