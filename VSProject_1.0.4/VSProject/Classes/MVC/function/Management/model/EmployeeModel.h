//
//  EmployeeModel.h
//  VSProject
//
//  Created by certus on 16/3/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmployeeModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*companyId;

@property(nonatomic,strong)NSString <Optional>*id;

@property(nonatomic,strong)NSString <Optional>*name;

@property(nonatomic,strong)NSString <Optional>*partyId;

@property(nonatomic,strong)NSString <Optional>*role;

@property(nonatomic,strong)NSString <Optional>*userLoginId;

@end
