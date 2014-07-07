//
//  XGDataModel.m
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import "XGDataCache.h"
#import "XGLocation.h"

@interface XGDataCache ()

@property (nonatomic, strong, readwrite) NSArray * locationArray;

@end

@implementation XGDataCache

+ (instancetype)sharedInstance
{
    static XGDataCache * instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XGDataCache alloc] init];
    });
    
    return instance;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
    NSArray * allLocations = dictionary[@"locations"][@"last_seen_at"];
    NSMutableArray * newLocationArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary * dict in allLocations)
    {
        XGLocation * newLocation = [[XGLocation alloc] initWithDictionary:dict];
        [newLocationArray addObject:newLocation];
    }
    
    self.locationArray = newLocationArray;
}

@end
