//
//  XGTabBarController.h
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kUserViewPreference;

@interface XGTabBarController : UITabBarController

- (void)showOnMapLocationIndex:(NSUInteger)locationIndex;

@end
