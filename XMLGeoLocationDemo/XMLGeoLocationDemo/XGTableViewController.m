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

@interface XGTableViewController ()

@end

@implementation XGTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [XGNetworkCommand enqueueCommandWithCallback:^(BOOL success, NSDictionary *response) {
        if (success) {
            [[XGDataCache sharedInstance] updateWithDictionary:response];
        }
    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
