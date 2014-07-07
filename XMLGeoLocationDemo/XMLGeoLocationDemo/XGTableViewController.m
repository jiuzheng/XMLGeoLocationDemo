//
//  FirstViewController.m
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import "XGTableViewController.h"
#import "XGNetworkCommand.h"
#import "XGDataCache.h"
#import "XGTableViewCell.h"
#import "XGLocation.h"
#import "XGTabBarController.h"

@interface XGTableViewController ()

@end

@implementation XGTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    if (![XGDataCache sharedInstance].locationArray)
    {
        [XGNetworkCommand enqueueCommandWithCallback:^(BOOL success, NSDictionary *response) {
            if (success) {
                [[XGDataCache sharedInstance] updateWithDictionary:response];
                [self.tableView reloadData];
            }
        }];
    }

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

// The number of rows is equal to the number of earthquakes in the array.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [XGDataCache sharedInstance].locationArray.count;
}

- (XGTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kLocationCellID = @"LocationCellID";
  	XGTableViewCell *cell = (XGTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kLocationCellID];
    
    // Get the specific XGLocation
    XGLocation * location = [XGDataCache sharedInstance].locationArray[indexPath.row];
    
    [cell configureWithXGLocation:location];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.parentViewController isKindOfClass:[XGTabBarController class]])
    {
        [((XGTabBarController *)self.parentViewController) showOnMapLocationIndex:indexPath.row];
    }
}

@end
