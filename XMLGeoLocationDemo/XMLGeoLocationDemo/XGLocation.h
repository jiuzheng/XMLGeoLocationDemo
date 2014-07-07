//
//  XGLocation.h
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

@import Foundation;
@import MapKit;
@import CoreLocation;

@interface XGLocation : NSObject

@property (nonatomic, strong) NSString *                address;
@property (nonatomic, assign) CLLocationCoordinate2D    coordinates;
@property (nonatomic, assign) NSTimeInterval            timeStamp;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
