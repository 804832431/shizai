//
//  WeatherView.h
//  VSProject
//
//  Created by certus on 16/1/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherCell.h"
#import "WeatherModel.h"

#define TOPIMAGE_H      100
#define TOPIMAGE_EH      300

@interface WeatherView : UIView

@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)UIButton *bgButton;
@property (nonatomic,strong)WeatherCell *weatherItem;
@property (nonatomic,assign)BOOL hideWeather;
@property (nonatomic,strong)UIImageView *downImageView;

- (void)reloadWeatherData:(WeatherModel *)model;

@end

