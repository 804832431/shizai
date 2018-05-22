//
//  CouponModel.h
//  VSProject
//
//  Created by certus on 16/4/18.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface CouponModel : JSONModel


@property(nonatomic,strong)NSString <Optional>*couponDesc;
@property(nonatomic,strong)NSString <Optional>*couponId;
@property(nonatomic,strong)NSString <Optional>*couponName;
@property(nonatomic,strong)NSString <Optional>*endTime;
@property(nonatomic,strong)NSString <Optional>*startTime;
@property(nonatomic,strong)NSNumber <Optional>*status;
@property(nonatomic,strong)NSString <Optional>*value;
@property(nonatomic,strong)NSString <Optional>*validCount;
@property(nonatomic,strong)NSString <Optional>*code;

@end
