//
//  XGTabBarController.m
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import "XGTabBarController.h"
#import "XGMapViewController.h"

NSString * const kUserViewPreference = @"user_view_preference";

@interface XGTabBarController ()

@end

@implementation XGTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSelectedIndex:[[[NSUserDefaults standardUserDefaults] objectForKey:kUserViewPreference] integerValue]];
    // Do any additional setup after loading the view.
}

- (void)showOnMapLocationIndex:(NSUInteger)locationIndex
{
    for (UIViewController * vc in self.viewControllers)
    {
        if ([vc isKindOfClass:[XGMapViewController class]])
        {
            [self setSelectedViewController:vc];
            [((XGMapViewController *)vc) selectMapAnnotationAtIndex:locationIndex];
        }
    }
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    for (NSUInteger i = 0; i < self.tabBar.items.count; i++)
    {
        if (self.tabBar.items[i] == item)
        {
            // record user's last choice
            [[NSUserDefaults standardUserDefaults] setObject:@(i) forKey:kUserViewPreference];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    int breakHere = 0;
}
*/

@end
