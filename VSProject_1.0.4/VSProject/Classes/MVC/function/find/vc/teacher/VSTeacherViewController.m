//
//  VSTeacherViewController.m
//  VSProject
//
//  Created by tiezhang on 15/4/19.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "VSTeacherViewController.h"
#import "VSLocationManager.h"
//#import "CLLocation+VSLocation.h"

@interface VSTeacherViewController ()<VSLocationDelegate>

_PROPERTY_NONATOMIC_STRONG(VSLocationManager, vm_locationManager);

@property (weak, nonatomic) IBOutlet UILabel *vm_addressText;

@property (weak, nonatomic) IBOutlet VSButton *vm_btnRefreshAddress;
- (IBAction)vm_refreshAddress:(id)sender;

@end

@implementation VSTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self vs_setTitleText:@"导师天地"];
    [self.vm_addressText setTextColor:kColor_333333];
    self.vm_addressText.font = kSysFont_12;
    
    [self.tableView setBackgroundColor:[UIColor redColor]];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(-34));
        
    }];

    [self.vm_locationManager location];
}

- (IBAction)vm_refreshAddress:(id)sender
{
    [self.vm_locationManager location];
}

#pragma mark -- MapViewDelegate
- (void)locationDidSuccesed:(VSLocationManager *)locationManager
{
    [self.vm_locationManager stopLocation];
    CLLocation *errLoc = [[CLLocation alloc]initWithLatitude:self.vm_locationManager.coordinate.latitude longitude:self.vm_locationManager.coordinate.longitude];
//    CLLocation *trueLoc = [[errLoc locationMarsFromEarth] locationBaiduFromMars];
//    [self reverseGeocodeLocation:trueLoc];
}

- (void)locationDidFailed:(VSLocationManager *)location error:(NSError *)error
{
    
}


- (void)reverseGeocodeLocation:(CLLocation *)location
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
        
        [clGeoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark * placeMark in placemarks)
            {
                NSDictionary *addressDic    = placeMark.addressDictionary;
                
                NSString *state             = [addressDic objectForKey:@"State"];
                NSString *city              = [addressDic objectForKey:@"City"];
                NSString *subLocality       = [addressDic objectForKey:@"SubLocality"];
                NSString *street            = [addressDic objectForKey:@"Street"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSMutableString *address = [NSMutableString string];
                    [address appendString:@"当前位置:"];
                    [address appendFormat:@"%@", state];
                    if (city && city.length > 0) {
                        [address appendFormat:@"%@", city];
                    }
                    [address appendFormat:@"%@", subLocality];
                    [address appendFormat:@"%@", [NSString strToShowText:street]];
                    DBLog(@"%@", address);
                    self.vm_addressText.text = address;
                });
                
            }
        }];
    });
    
    
    
}

#pragma mark -- getter
_GETTER_ALLOC_BEGIN(VSLocationManager, vm_locationManager)
{
    _vm_locationManager.delegate = self;
}
_GETTER_END(vm_locationManager)


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
