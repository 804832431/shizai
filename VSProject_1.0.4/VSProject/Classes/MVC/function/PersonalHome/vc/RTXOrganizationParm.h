//
//  RTXOrganizationParm.h
//  VSProject
//
//  Created by XuLiang on 15/11/18.
//  Copyright © 2015年 user. All rights reserved.
//

#import "VSBaseParmModel.h"

@interface RTXOrganizationParm : VSBaseParmModel

_PROPERTY_NONATOMIC_STRONG(NSString, organization_id);
_PROPERTY_NONATOMIC_STRONG(NSString, page);
_PROPERTY_NONATOMIC_STRONG(NSString, row);
//参数对象序列化成字典对象
- (NSDictionary*)vp_parmSerialize;
@end
