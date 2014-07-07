//
//  XGLocation.m
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import "XGLocation.h"

@implementation XGLocation

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _address = dict[@"address"][@"text"];
        _coordinates.latitude = [dict[@"lat"][@"text"] doubleValue];
        _coordinates.longitude = [dict[@"lon"][@"text"] doubleValue];
        _timeStamp = [dict[@"timestamp"][@"text"] doubleValue];
    }
    
    return self;
}

@end
