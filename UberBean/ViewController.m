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
#import "Cafe.h"
#import "NetworkManager.h"
#import "CustomImageView.h"

@interface ViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

@property(nonatomic,strong)MKMapView* mapView;
@property(nonatomic,strong)CLLocationManager* locationManager;
@property(nonatomic,strong)NSString* apiKey;
@property(nonatomic,strong)NSMutableArray<Cafe*>* cafeObjects;
@property(nonatomic,strong)NetworkManager* networkManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.apiKey = @"blW9-941GsYiAaztlNda-pL4VWReQ1rYwjPqYJpac0zsWKOuPy9ptxPft42NLpTKu8qiehf7oznwC16QLclvxX95LiQjkxLeLK_rsH6PD-w25HkZUitNP-3BMA3fXHYx";
    self.cafeObjects = [[NSMutableArray alloc]init];
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

- (NetworkManager *)networkManager{
    if (!_networkManager) {
        _networkManager = [[NetworkManager alloc]init];
    }
    return _networkManager;
}

-(void)setupView{
    MKMapView* mapView = [[MKMapView alloc]initWithFrame:CGRectZero];
    mapView.translatesAutoresizingMaskIntoConstraints = 0;
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
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
    
    if (location !=nil) {
        [self.networkManager requestYelp:location withApiKey:self.apiKey withCompletionHandler:^(NSDictionary * _Nonnull json) {
            NSArray* cafeArray =  [json objectForKey:@"businesses"];
            
            for (NSDictionary* dict in cafeArray) {
                Cafe* cafe = [Cafe parseJson:dict];

                [self.cafeObjects addObject:cafe];
                [self.mapView addAnnotation:cafe];
                [self.mapView showAnnotations:self.cafeObjects animated:true];
            }
        }];
    }
    self.mapView.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.6, 0.6));
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager{
    NSLog(@"%@", self.cafeObjects);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didfail");
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        [self.locationManager requestLocation];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
   
    MKMarkerAnnotationView* markerView = (MKMarkerAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:@"MarkerView"];
    
    if (!markerView && ![annotation isKindOfClass:[MKUserLocation class]]) {
        markerView = [[MKMarkerAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"MarkerView"];
        markerView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoLight];
        markerView.leftCalloutAccessoryView = [[CustomImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        markerView.markerTintColor = [UIColor cyanColor];
        markerView.canShowCallout = YES;
    }
    
    return markerView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{

    CustomImageView*imageView = (CustomImageView*)view.leftCalloutAccessoryView;
    
    NSLog(@"%@", view.annotation.title);
    for (Cafe* cafe in self.cafeObjects) {
        if (view.annotation.title == cafe.title) {
             [imageView loadImageFromWeb:[NSURL URLWithString:cafe.imageUrl]];
        }
    }
    
}

@end
