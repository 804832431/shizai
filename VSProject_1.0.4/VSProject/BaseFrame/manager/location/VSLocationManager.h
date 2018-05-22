//
//  VSLocationManager.h
//  VSProject
//
//  Created by user on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSBaseManager.h"
#import <CoreLocation/CoreLocation.h>

@class VSLocationManager;
@protocol VSLocationDelegate <NSObject>
- (void)locationDidSuccesed:(VSLocationManager *)locationManager;

- (void)locationDidFailed:(VSLocationManager *)location error:(NSError *)error;
@end


@interface VSLocationManager : VSBaseManager<CLLocationManagerDelegate>

/*!
 *  执行定位
 */
- (void)location;

@property(nonatomic, weak) id <VSLocationDelegate> delegate;

/*!
 *  省份名
 */
@property(nonatomic, strong, readonly) NSString *province;

/*!
 *  城市名
 */
@property(nonatomic, strong, readonly) NSString *city;

/*!
 *  经纬度
 */
@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;

/*!
 *  是否允许定位
 */
@property(nonatomic, assign) BOOL locatingEnabled;

/*!
 *  停止定位 用于定位超过5s的时候停止定位
 */
- (void)stopLocation;

//判断是否已经超出中国范围 
- (BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;

@end
