//
//  ActivityModel.h
//  VSProject
//
//  Created by certus on 16/1/20.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"

@interface ActivityModel : VSBaseNeedSaveDataModel

@property (nonatomic,strong)NSString <Optional>*charge;
@property (nonatomic,strong)NSString <Optional>*contact;
@property (nonatomic,strong)NSString <Optional>*contactNumber;
@property (nonatomic,strong)NSString <Optional>*createTime;
@property (nonatomic,strong)NSString <Optional>*a_description;
@property (nonatomic,strong)NSString <Optional>*detailImage;
@property (nonatomic,strong)NSString <Optional>*enrollmentTime;
@property (nonatomic,strong)NSString <Optional>*eventLocation;
@property (nonatomic,strong)NSString <Optional>*eventTime;
@property (nonatomic,strong)NSString <Optional>*id;
@property (nonatomic,strong)NSString <Optional>*listImage;
@property (nonatomic,strong)NSString <Optional>*personMax;
@property (nonatomic,strong)NSString <Optional>*status;
@property (nonatomic,strong)NSString <Optional>*title;

@end
