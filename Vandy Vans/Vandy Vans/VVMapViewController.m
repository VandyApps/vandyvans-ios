//
//  VVMapViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 10/11/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import "VVMapViewController.h"
#import "VVRoute.h"
#import "VVVan.h"
#import "VVVanAnnotation.h"
#import "VVVanAnnotationView.h"
#import "VVAlertBuilder.h"

@import MapKit;

static NSTimeInterval const kUpdateInterval = 6.0;

@interface VVMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet MKMapView *vanMapView;
@property (strong, nonatomic) VVRoute *routeBeingDisplayed;
@property (nonatomic, copy) NSOrderedSet *routes;

@property (nonatomic, copy) NSArray *vanAnnotations;
@property (strong, nonatomic) NSTimer *updateTimer;

@property (nonatomic) BOOL vansAreRunning;
@property (nonatomic) BOOL routeIsSelected;

@end

@implementation VVMapViewController

@synthesize routeBeingDisplayed = _routeBeingDisplayed;

#pragma mark - Custom Getters

- (VVRoute *)routeBeingDisplayed {
    if (!_routeBeingDisplayed) {
        _routeBeingDisplayed = self.routes[0];
    }
    
    return _routeBeingDisplayed;
}

- (NSOrderedSet *)routes {
    if (!_routes) {
        _routes = [NSOrderedSet orderedSetWithObjects:[VVRoute routeWithRouteID:@"745"],
                   [VVRoute routeWithRouteID:@"746"],
                   [VVRoute routeWithRouteID:@"749"], nil];
    }
    
    return _routes;
}

#pragma mark - Custom Setter

- (void)setRouteBeingDisplayed:(VVRoute *)routeBeingDisplayed {
    if (![_routeBeingDisplayed isEqual:routeBeingDisplayed]) {
        _routeBeingDisplayed = routeBeingDisplayed;
        
        [self.vanMapView removeAnnotations:self.vanMapView.annotations];
        [self.vanMapView removeOverlay:[self.vanMapView.overlays firstObject]];
        
        [self displayAnnotationsForRoute:_routeBeingDisplayed];
        [self displayPolylineForRoute:_routeBeingDisplayed];
    }
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vansAreRunning = YES;
    self.routeIsSelected = NO;
    
    if (self.selectedRoute) {
        [self selectRoute:self.selectedRoute];
        self.routeIsSelected = YES;
    } else {
        // Drop pins on stops depending on which route is being displayed.
        [self displayAnnotationsForRoute:self.routeBeingDisplayed];
        
        // Add the appropriate polyline for the given route.
        [self displayPolylineForRoute:self.routeBeingDisplayed];
        
        [self displayVansAndScheduleUpdateTimer];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.barStyle = UIBarStyleDefault;
    
    if (!self.routeIsSelected && self.selectedRoute) {
        [self selectRoute:self.selectedRoute];
    }
    
    if (!self.updateTimer.isValid) {
        [self displayVansAndScheduleUpdateTimer];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.updateTimer invalidate];
    
    self.routeIsSelected = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

- (IBAction)routeTapped:(UISegmentedControl *)sender {
    [self.updateTimer invalidate];
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.routeBeingDisplayed = self.routes[0];
            break;
            
        case 1:
            self.routeBeingDisplayed = self.routes[1];
            break;
            
        case 2:
            self.routeBeingDisplayed = self.routes[2];
            break;
            
        default:
            break;
    }
    
    sender.tintColor = [self colorForRoute:self.routeBeingDisplayed];
    
    [self displayVansAndScheduleUpdateTimer];
}

#pragma mark - Helper Methods

- (void)displayAnnotationsForRoute:(VVRoute *)route {
    [VVRoute annotationsForRoute:route
             withCompletionBlock:^(NSArray *stops) {
                 [self.vanMapView addAnnotations:stops];
             }];
}

- (void)displayPolylineForRoute:(VVRoute *)route {
    [VVRoute polylineForRoute:route
          withCompletionBlock:^(MKPolyline *polyline) {
              [self.vanMapView addOverlay:polyline];
              
              MKMapRect mapRect = polyline.boundingMapRect;
              NSUInteger widthAdjustment = mapRect.size.width * 0.1;
              
              MKMapRect adjustedMapRect = MKMapRectMake(mapRect.origin.x - (widthAdjustment / 2), mapRect.origin.y, mapRect.size.width + widthAdjustment, mapRect.size.height);
              
              [self.vanMapView setVisibleMapRect:adjustedMapRect
                                        animated:YES];
          }];
}

- (void)displayVansAndScheduleUpdateTimer {
    [self displayVans];
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:kUpdateInterval
                                                        target:self
                                                      selector:@selector(displayVansWithTimer:)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)displayVans {
    NSDateComponents *currentDateComponents = [[NSCalendar autoupdatingCurrentCalendar] components:NSHourCalendarUnit
                                                                                          fromDate:[NSDate date]];
    
    // If it is between 5 AM and 5 PM, alert the user that the vans are not running.
    if (currentDateComponents.hour >= 5 && currentDateComponents.hour < 17) {
        self.vansAreRunning = NO;
        // If it has just turned 5 AM, clear any cached van annotations and clear the table view.
        if ([self.vanAnnotations count]) {
            [self.vanMapView removeAnnotations:self.vanAnnotations];
            self.vanAnnotations = nil;
        }
        
        [[VVAlertBuilder vansNotRunningAlertWithDelegate:self] show];
    } else {
        [VVRoute vansForRoute:self.routeBeingDisplayed
          withCompletionBlock:^(NSArray *vans) {
              NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:[vans count]];
              
              for (VVVan *van in vans) {
                  VVVanAnnotation *vanAnnotation = [VVVanAnnotation vanAnnotationWithTitle:[NSString stringWithFormat:@"%lu%% Full", (unsigned long)van.percentageFull]
                                                                             andCoordinate:van.coordinate];
                  
                  [annotations addObject:vanAnnotation];
              }
              
              [self.vanMapView removeAnnotations:self.vanAnnotations];
              self.vanAnnotations = [annotations copy];
              [self.vanMapView addAnnotations:self.vanAnnotations];
          }];
    }
}

- (void)displayVansWithTimer:(NSTimer *)timer {
    [self displayVans];
}

- (void)selectRoute:(VVRoute *)route {
    NSInteger selectedIndex;
    
    if ([route.name isEqualToString:@"Blue"]) {
        selectedIndex = 0;
    } else if ([route.name isEqualToString:@"Red"]) {
        selectedIndex = 1;
    } else { // Green
        selectedIndex = 2;
    }
    
    if (self.segmentedControl.selectedSegmentIndex != selectedIndex) {
        self.segmentedControl.selectedSegmentIndex = selectedIndex;
        [self routeTapped:self.segmentedControl];
    }
}

#pragma mark - Map View Delegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKOverlayRenderer *renderer;
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *polylineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.strokeColor = [self colorForRoute:self.routeBeingDisplayed];
        polylineRenderer.lineWidth = 3.0f;
        
        renderer = polylineRenderer;
    }
    
    return renderer;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString * const VanAnnotationIdentifier = @"vanAnnotation";
    static NSString * const StopAnnotationIdentifier = @"stopAnnotation";
    
    MKAnnotationView *annotationView;
    
    if ([annotation isKindOfClass:[VVVanAnnotation class]]) {
        annotationView = [self.vanMapView dequeueReusableAnnotationViewWithIdentifier:VanAnnotationIdentifier];
        
        if (!annotationView) {
            annotationView = [[VVVanAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:VanAnnotationIdentifier];
        }
    } else if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        annotationView = [self.vanMapView dequeueReusableAnnotationViewWithIdentifier:StopAnnotationIdentifier];
        
        if (!annotationView) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:StopAnnotationIdentifier];
        }
        
        annotationView.canShowCallout = YES;
        ((MKPinAnnotationView *)annotationView).animatesDrop = YES;
    }
    
    return annotationView;
}

#pragma mark - Helper Method

- (UIColor *)colorForRoute:(VVRoute *)route {
    UIColor *color;
    
    if ([route.name isEqualToString:@"Blue"]) {
        color = [UIColor blueColor];
    } else if ([route.name isEqualToString:@"Red"]) {
        color = [UIColor redColor];
    } else if ([route.name isEqualToString:@"Green"]) {
        color = [UIColor colorWithRed:51/255.0f
                                green:189/255.0f
                                 blue:50/255.0f
                                alpha:1.0f];
    } else { // New route
        color = [UIColor blackColor];
    }
    
    return color;
}

@end