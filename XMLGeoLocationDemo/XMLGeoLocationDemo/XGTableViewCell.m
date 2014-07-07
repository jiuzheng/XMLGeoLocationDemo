//
//  XGTableViewCell.m
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import "XGTableViewCell.h"
#import "XGLocation.h"

@implementation XGTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithXGLocation:(XGLocation *)location
{
    self.backgroundColor = [UIColor clearColor];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
    self.timestampLabel.text = [dateFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:location.timeStamp]];
    self.addressLabel.text = location.address;
}

@end
