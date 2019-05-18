//
//  Cafe.h
//  Uber Bean
//
//  Created by Luiz on 5/17/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cafe : NSObject
@property (nonatomic) NSString *id;
@property (nonatomic,strong) NSString * name;
@property (nonatomic, strong) NSDictionary * location;
@property ( nonatomic) double latitude;
@property (nonatomic) double longitude;
@property ( nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * image;

- (instancetype)initWithJSON: (NSDictionary *) json;
@end

NS_ASSUME_NONNULL_END
