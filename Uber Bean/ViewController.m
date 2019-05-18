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
#import "Cafe.h"


@interface ViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray<Cafe*> *cafes;
@property (nonatomic) CLLocation *myLocation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cafes = [NSMutableArray new];
    [self requestLocationPermission];
    self.locationManager.delegate = self;
    [self requestCafes];
}


-(void) requestCafes {
    NSString *key = @"8ejcA9KLdpfCPAAPUlYOojRvy6iKHB8ryuzWEyxvmpIIn26_VYN3a387cM70KjFd4fvoUpohPiJ2xA1AIo5dvpWNRSyR-w6kKu4E8ggE360EIh0fdjDxci8HsQzfXHYx";


    double latitude = self.myLocation.coordinate.latitude;
    double logitude = self.myLocation.coordinate.longitude;
    NSString *urlString = [[NSString alloc] initWithFormat: @"https://api.yelp.com/v3/businesses/search?term=cafe&latitude=%f&longitude=%f", latitude, logitude ];
    NSURL *url = [NSURL URLWithString:urlString];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *value = [NSString stringWithFormat:@"Bearer %@", key];
    [urlRequest addValue: value forHTTPHeaderField:@"Authorization"];

    NSURLSessionTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest
                                    completionHandler:^(NSData * _Nullable data,
                                                        NSURLResponse * _Nullable response,
                                                        NSError * _Nullable error) {
                                        if (error) { // 1
                                            // Handle the error
                                            NSLog(@"error: %@", error.localizedDescription);
                                            return;
                                        }

                                        NSError *jsonError = nil;

                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                        if (httpResponse.statusCode != 200) {
                                            NSLog(@"%@", httpResponse.description);
                                            return;
                                        }

                                        if (jsonError) {
                                            NSLog(@"Error parsing the JSON response: %@", jsonError);
                                            return;
                                        }
                                        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                             options:0
                                                                                               error:&jsonError];

                                        NSArray *objet = json[@"businesses"];

                                        for (NSDictionary *cafe in objet) {
                                            Cafe *newCafe = [[Cafe alloc] initWithJSON: cafe];
                                            [self.cafes addObject: newCafe];

                                        }

                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                            NSLog(@"%@", self.cafes);
                                             [self displayCafeOnTheMap];

                                        }];
                                    }];

    [task resume];
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
-(void)displayCafeOnTheMap{
    [self.mapView addAnnotation: (id) self.cafes];
    [self.mapView showAnnotations: (id) self.cafes animated: YES];

}
@end


