//
//  ViewController.m
//  Uber Bean
//
//  Created by Luiz on 5/17/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

#import "ViewController.h"
@import MapKit;
@import CoreLocation;


@interface ViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestLocationPermission];
    self.locationManager.delegate = self;

}

-(void) requestLocationPermission {
    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
    self.mapView.showsUserLocation = YES;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    CLLocation *location = locations[0];

    MKCoordinateRegion region =MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.06, 0.06));



    [self.mapView setRegion: region animated:YES];


     NSLog(@"%@", locations[0]);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {

    if(status == kCLAuthorizationStatusAuthorizedWhenInUse ||
       status == kCLAuthorizationStatusAuthorizedAlways){
         [self.locationManager requestLocation];
    }
}
@end


