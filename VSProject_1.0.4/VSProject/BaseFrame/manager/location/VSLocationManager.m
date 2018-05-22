//
//  VSLocationManager.m
//  VSProject
//
//  Created by user on 15/2/27.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSLocationManager.h"
#import "CLLocation+YCLocation.h"

const double a = 6378245.0;
const double ee = 0.00669342162296594323;
const double pi = 3.14159265358979324;

@interface VSLocationManager ()
{
    double _timeLocationBegin;
}

@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation VSLocationManager

DECLARE_SINGLETON(VSLocationManager)

- (void)dealloc
{
    [_locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1000;
    }
    return self;
}

- (void)location
{
    
    // 启用GPS埋点
    //    [VSStartupManager sharedInstance].configure.isUploadTimeWithGPS = YES;
    _timeLocationBegin = CFAbsoluteTimeGetCurrent();
    if (__IOS_VERSION__ > 8.0) {
        [_locationManager requestAlwaysAuthorization];
    }

    [_locationManager startUpdatingLocation];
}

- (BOOL)locatingEnabled
{
    return [CLLocationManager locationServicesEnabled];
}
- (void)stopLocation
{
    [_locationManager stopUpdatingLocation];
}

#pragma mark -  CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [self finishLocation];
    
    _coordinate = newLocation.coordinate;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks)
        {
            _province = placemark.administrativeArea;
            _city = placemark.locality ;
        }
        
        if (_province == nil)
        {
            _province = @"广东省";
            _city = @"广州市";
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(locationDidSuccesed:)]) {
            [self.delegate locationDidSuccesed:self];
        }
        
    }];
    //火星坐标转成百度坐标
    CLLocation * earthLoction = [newLocation locationMarsFromEarth];
    CLLocation *baiduLocation = [earthLoction locationBaiduFromMars];

    NSString *latitude = [[NSString alloc] initWithFormat:@"%f",baiduLocation.coordinate.latitude];
    NSString *longitude = [[NSString alloc] initWithFormat:@"%f",baiduLocation.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_locationManager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [_locationManager stopUpdatingLocation];
    
    [self finishLocation];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationDidFailed:error:)])
    {
        [self.delegate locationDidFailed:self error:error];
    }
}

#pragma mark -- LocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    switch (status)
    {
            
        case kCLAuthorizationStatusNotDetermined:
            
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [self.locationManager requestWhenInUseAuthorization];
            }
            
            break;
            
        default:
            
            break;
            
    }
    
    
}

- (void)finishLocation
{
    //    double currentTime = CFAbsoluteTimeGetCurrent();
    //    [VSStartupManager sharedInstance].configure.timeByLocation = (currentTime - _timeLocationBegin) * 1000;
    
    
}


//判断是不是在中国
- (BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location
{
    if (location.longitude < 72.004 || location.longitude > 137.8347 || location.latitude < 0.8293 || location.latitude > 55.8271)
        return YES;
    return NO;
}

@end
