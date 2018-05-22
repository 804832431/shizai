//
//  RentalModel.h
//  VSProject
//
//  Created by certus on 16/4/1.
//  Copyright © 2016年 user. All rights reserved.
//

#import "JSONModel.h"

@interface RentalModel : JSONModel

@property(nonatomic,strong)NSString <Optional>*beginTime;
@property(nonatomic,strong)NSString <Optional>*buildingName;
@property(nonatomic,strong)NSString <Optional>*buildingNumber;
@property(nonatomic,strong)NSString <Optional>*contact;
@property(nonatomic,strong)NSString <Optional>*contactNumber;
@property(nonatomic,strong)NSString <Optional>*createTime;
@property(nonatomic,strong)NSString <Optional>*floorNumber;
@property(nonatomic,strong)NSString <Optional>*id;
@property(nonatomic,strong)NSString <Optional>*partyId;
@property(nonatomic,strong)NSString <Optional>*paymentMethod;
@property(nonatomic,strong)NSString <Optional>*price;
@property(nonatomic,strong)NSString <Optional>*remarks;
@property(nonatomic,strong)NSString <Optional>*rentFreePeriod;
@property(nonatomic,strong)NSString <Optional>*roomArea;
@property(nonatomic,strong)NSString <Optional>*roomNumber;
@property(nonatomic,strong)NSString <Optional>*status;

@end
