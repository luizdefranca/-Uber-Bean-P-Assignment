//
//  Cafe.m
//  Uber Bean
//
//  Created by Luiz on 5/17/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

#import "Cafe.h"

@implementation Cafe
- (instancetype)initWithJSON: (NSDictionary *) json{
    self = [super init];
    if (self) {

        _location = json[@"location"];
        if(json[@"name"]){
            _name = json[@"name"];
        } else {
            _name = @"Unknown";
        }

        _ID = json[@"id"];
        NSDictionary *coordinates = json[@"coordinates"];

        NSNumber * latitude = coordinates[@"latitude"];
        NSNumber * logitude = coordinates[@"longitude"];
        _longitude = [logitude doubleValue];
        _latitude = [latitude doubleValue];
        _image = json[@"image_url"];
        NSArray *categories = json[@"categories"];

        _category = categories[0][@"title"];
        _price = json[@"price"];
        _coordinate = CLLocationCoordinate2DMake(_latitude, _longitude);
        _title = _name;
        _subtitle = _location[@"address1"];
    }
    return self;
}
-(NSString *) description{
    return [[NSString alloc] initWithFormat: @"name - %@ | coordinate - %f - %f  | title - %@ | subtitle - %@", _name, _coordinate.longitude, _coordinate.latitude, _title, _subtitle];
}
@end
