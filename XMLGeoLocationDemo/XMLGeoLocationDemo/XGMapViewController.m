//
//  SecondViewController.m
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

#import "XGMapViewController.h"
#import "XGLocation.h"
#import "XGDataCache.h"
#import "XGNetworkCommand.h"

@interface XGAnnotation : NSObject <MKAnnotation>
{
    CLLocation *_location;
    NSString *_title;
}

@property (nonatomic, strong) XGLocation *info;

@end

@implementation XGAnnotation

- (id)initWithLocation:(CLLocation *)location title:(NSString *)title
{
    self = [super init];
    if (self)
    {
        _location = location;
        _title = title;
    }
    return self;
}

#pragma mark - MKAnnotation

- (CLLocationCoordinate2D)coordinate
{
    return _location.coordinate;
}

- (NSString *)title
{
    return _title;
}

@end

@interface XGAnnotationView : MKPinAnnotationView

@end

@implementation XGAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIImage *pinImage = [UIImage imageNamed:@"pin_icon.png"];
        self.image = pinImage;
        
        self.canShowCallout = YES;
    }
    return self;
}

@end

@interface XGMapViewController ()

@property (nonatomic, strong) NSMutableArray * orderedMapAnnotations;

@end

@implementation XGMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.orderedMapAnnotations) {
        self.orderedMapAnnotations = [[NSMutableArray alloc] init];
    }
    
    // Some custom pin images
    self.mapView.delegate = self;
    
    if (![XGDataCache sharedInstance].locationArray)
    {
        [XGNetworkCommand enqueueCommandWithCallback:^(BOOL success, NSDictionary *response) {
            if (success) {
                [[XGDataCache sharedInstance] updateWithDictionary:response];
                
                [self refreshOnMapLocations:[XGDataCache sharedInstance].locationArray];
                [self selectMapAnnotationAtIndex:0];
            }
        }];
    }
    
    [self refreshOnMapLocations:[XGDataCache sharedInstance].locationArray];
}

- (void)refreshOnMapLocations:(NSArray *)locations
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.orderedMapAnnotations removeAllObjects];
    for (XGLocation *info in locations)
    {
        XGAnnotation *annotation = [[XGAnnotation alloc] initWithLocation:info.location title:info.address];
        [self.orderedMapAnnotations addObject:annotation];
        [self.mapView addAnnotation:annotation];
    }
}

- (void)selectMapAnnotationAtIndex:(NSUInteger)index
{
    XGAnnotation * annotation = self.orderedMapAnnotations[index];
    NSUInteger zoomLevel = 15;
    MKCoordinateSpan span = MKCoordinateSpanMake(0, 360 / pow(2, zoomLevel) * self.view.frame.size.width / 256);
    self.mapView.region = MKCoordinateRegionMake(annotation.coordinate, span);
    [self.mapView selectAnnotation:self.orderedMapAnnotations[index] animated:YES];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    XGAnnotationView *annotationView = nil;
    if ([annotation isKindOfClass:[XGAnnotation class]])
    {
        annotationView = (XGAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"XGAnnotationView"];
        if (!annotationView)
        {
            annotationView = [[XGAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"XGAnnotationView"];
        }
    }
    
    return annotationView;
}

@end
