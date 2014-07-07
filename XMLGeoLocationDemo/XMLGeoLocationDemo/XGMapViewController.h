//
//  SecondViewController.h
//  XMLGeoLocationDemo
//
//  Created by Jiuzheng Chen on 7/6/14.
//  Copyright (c) 2014 Jiuzheng Chen. All rights reserved.
//

@import MapKit;

@interface XGMapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (void)selectMapAnnotationAtIndex:(NSUInteger) index;

@end
