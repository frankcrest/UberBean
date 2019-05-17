//
//  ViewController.m
//  UberBean
//
//  Created by Frank Chen on 2019-05-17.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property(nonatomic,strong)MKMapView* mapView;
@property(nonatomic,strong)CLLocationManager* locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.locationManager requestWhenInUseAuthorization];
    
    [self setupView];
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

-(void)setupView{
    MKMapView* mapView = [[MKMapView alloc]initWithFrame:CGRectZero];
    mapView.translatesAutoresizingMaskIntoConstraints = 0;
    mapView.showsUserLocation = YES;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    [NSLayoutConstraint activateConstraints:@[
                                          [mapView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0],
                                          [mapView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0],
                                          [mapView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0],
                                          [mapView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0],
                                              ]];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"getting location");
    CLLocation* location = locations[0];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didfail");
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        [self.locationManager requestLocation];
    }
}

@end
