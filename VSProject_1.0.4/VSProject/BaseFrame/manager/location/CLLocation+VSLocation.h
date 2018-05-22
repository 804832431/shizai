//
//  CLLocation+VSLocation.h
//  VSProject
//
//  Created by tiezhang on 15/4/19.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (VSLocation)

//从地图坐标转化到火星坐标
- (CLLocation*)locationMarsFromEarth;

//从火星坐标转化到百度坐标
- (CLLocation*)locationBaiduFromMars;

//从百度坐标到火星坐标
- (CLLocation*)locationMarsFromBaidu;

@end
