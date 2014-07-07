//
//  XGDataModel.h
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGDataCache : NSObject

@property (nonatomic, readonly) NSArray * locationArray;

+ (instancetype)sharedInstance;

- (void)updateWithDictionary:(NSDictionary *)dictionary;

@end
