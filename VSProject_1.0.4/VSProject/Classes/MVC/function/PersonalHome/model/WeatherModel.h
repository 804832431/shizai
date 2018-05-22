//
//  WeatherModel.h
//  VSProject
//
//  Created by certus on 16/1/19.
//  Copyright © 2016年 user. All rights reserved.
//

#import "VSBaseNeedSaveDataModel.h"

@interface WeatherModel : VSBaseNeedSaveDataModel

@property (nonatomic,strong)NSString <Optional>*backgroundImageURL;
@property (nonatomic,strong)NSString <Optional>*pm25;
@property (nonatomic,strong)NSString <Optional>*projectName;
@property (nonatomic,strong)NSString <Optional>*temp;
@property (nonatomic,strong)NSString <Optional>*tempNow;
@property (nonatomic,strong)NSString <Optional>*weather;
@property (nonatomic,strong)NSString <Optional>*weatherIconURL;

@end
