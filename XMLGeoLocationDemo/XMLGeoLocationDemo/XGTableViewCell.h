//
//  XGTableViewCell.h
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XGLocation;
@interface XGTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

- (void)configureWithXGLocation:(XGLocation *)location;

@end
