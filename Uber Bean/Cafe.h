//
//  Cafe.h
//  Uber Bean
//
//  Created by Luiz on 5/17/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

NS_ASSUME_NONNULL_BEGIN

@interface Cafe : NSObject <MKAnnotation>
@property (nonatomic) NSString *ID;
@property (nonatomic,strong) NSString * name;
@property (nonatomic, strong) NSDictionary * location;
@property ( nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property ( nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;

- (instancetype)initWithJSON: (NSDictionary *) json;
@end

NS_ASSUME_NONNULL_END
