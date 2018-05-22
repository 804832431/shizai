//
//  CityAreaModel.h
//  VSProject
//
//  Created by apple on 11/8/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"
#import "AreaModel.h"

@interface CityAreaModel : VSBaseNeedSaveDataModel

@property (nonatomic,copy)NSString <Optional>*cityId;
@property (nonatomic,copy)NSString <Optional>*cityName;
@property (nonatomic,strong)NSArray <AreaModel *>*areaList;

@end
