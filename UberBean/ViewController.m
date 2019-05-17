//
//  ViewController.m
//  UberBean
//
//  Created by Frank Chen on 2019-05-17.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()

@property(nonatomic,strong)MKMapView* mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
}

-(void)setupView{
    MKMapView* mapView = [[MKMapView alloc]initWithFrame:CGRectZero];
    mapView.translatesAutoresizingMaskIntoConstraints = 0;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    [NSLayoutConstraint activateConstraints:@[
                                          [mapView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0],
                                          [mapView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0],
                                          [mapView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0],
                                          [mapView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0],
                                              ]];
}


@end
