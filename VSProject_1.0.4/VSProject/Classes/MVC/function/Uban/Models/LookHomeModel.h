//
//  LookHomeModel.h
//  VSProject
//
//  Created by certus on 16/4/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import "JSONModel.h"

@interface LookHomeModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*customerRequirement;
@property(nonatomic,strong)NSString <Optional>*customerType;
@property(nonatomic,strong)NSString <Optional>*id;
@property(nonatomic,strong)NSString <Optional>*showTime;
@property(nonatomic,strong)NSString <Optional>*ubanRentalId;

@end
