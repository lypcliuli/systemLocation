//
//  ViewController.m
//  SystemLocation
//
//  Created by LYPC on 16/9/13.
//  Copyright © 2016年 cattsoft. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 1.0;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationManager requestAlwaysAuthorization]; // 永久授权
        [self.locationManager requestWhenInUseAuthorization]; //使用中授权
    }
    [self.locationManager startUpdatingLocation];// 开启定位
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark CLLocationManagerDelegate
// 获取定位结果
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"经度：%f", newLocation.coordinate.longitude);
    NSLog(@"纬度：%f", newLocation.coordinate.latitude);
    NSLog(@"速度：%f 米/秒", newLocation.speed);
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSDictionary *locationInfo = [[NSDictionary alloc]init];
        for (CLPlacemark * placemark in placemarks) {
            locationInfo = [placemark addressDictionary];
        }
        NSLog(@"%@",locationInfo);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

