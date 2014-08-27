//
//  VVMapViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 10/11/12.
//  Copyright (c) 2012 VandyApps. All rights reserved.
//

#import "VVMapViewController.h"
#import "VVRoute.h"
#import "VVVan.h"
#import "VVVanAnnotationView.h"
#import "VVAlertBuilder.h"
#import "AWSMobileAnalytics+VandyVans.h"

@import MapKit;

static NSTimeInterval const kRunningHoursUpdateInterval = 6.0;
static NSTimeInterval const kOffHoursUpdateInterval = 15.0;

static NSString * const kOpenedMapEventType = @"OpenedMap";
static NSString * const kRouteTappedEventType = @"RouteTapped";
static NSString * const kVanIconTappedEventType = @"VanIconTapped";
static NSString * const kStopIconTappedEventType = @"StopIconTapped";

static NSString * const kRouteNameKey = @"RouteName";
static NSString * const kStopNameKey = @"StopName";

@interface VVMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet MKMapView *vanMapView;
@property (strong, nonatomic) VVRoute *routeBeingDisplayed;
@property (nonatomic, copy) NSOrderedSet *routes;

@property (nonatomic, copy) NSArray *vanAnnotations;
@property (strong, nonatomic) NSTimer *updateTimer;

@property (nonatomic) BOOL vansAreRunning;
@property (nonatomic) BOOL routeIsSelected;

@property (weak, nonatomic) id<AWSMobileAnalyticsEventClient> eventClient;

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
        _routes = [NSOrderedSet orderedSetWithObjects:[VVRoute routeWithRouteID:kBlackRouteID],
                   [VVRoute routeWithRouteID:kRedRouteID],
                   [VVRoute routeWithRouteID:kGoldRouteID], nil];
    }
    
    return _routes;
}

- (id<AWSMobileAnalyticsEventClient>)eventClient {
    if (!_eventClient) {
        AWSMobileAnalytics *analytics = [AWSMobileAnalytics vv_mobileAnalytics];
        _eventClient = analytics.eventClient;
    }
    
    return _eventClient;
}

#pragma mark - Custom Setter

- (void)setRouteBeingDisplayed:(VVRoute *)routeBeingDisplayed {
    if (![_routeBeingDisplayed isEqual:routeBeingDisplayed]) {
        _routeBeingDisplayed = routeBeingDisplayed;
        
        self.vanAnnotations = nil;
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
    
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"map-selected"];
    
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
    
    id<AWSMobileAnalyticsEvent> openedMapEvent = [self.eventClient createEventWithEventType:kOpenedMapEventType];
    [openedMapEvent addAttribute:self.routeBeingDisplayed.name
                          forKey:kRouteNameKey];
    
    [self.eventClient recordEvent:openedMapEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.barStyle = UIBarStyleDefault;
    
    if (!self.routeIsSelected && self.selectedRoute) {
        [self selectRoute:self.selectedRoute];
    }
    
    if (![self.updateTimer isValid]) {
        [self displayVansAndScheduleUpdateTimer];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
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
    
    id<AWSMobileAnalyticsEvent> routeTappedEvent = [self.eventClient createEventWithEventType:kRouteTappedEventType];
    [routeTappedEvent addAttribute:self.routeBeingDisplayed.name
                            forKey:kRouteNameKey];
    
    [self.eventClient recordEvent:routeTappedEvent];
    
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
    [self scheduleUpdateTimerForRunningHours];
}

- (void)scheduleUpdateTimerForRunningHours {
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:kRunningHoursUpdateInterval
                                                        target:self
                                                      selector:@selector(displayVansWithTimer:)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)scheduleUpdateTimerForOffHours {
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:kOffHoursUpdateInterval
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
        BOOL vansWereRunning = self.vansAreRunning;
        self.vansAreRunning = NO;
        // If it has just turned 5 AM, clear any cached van annotations and clear the table view.
        if ([self.vanAnnotations count]) {
            [self.vanMapView removeAnnotations:self.vanAnnotations];
            self.vanAnnotations = nil;
        }
        
        if (vansWereRunning) {
            [[VVAlertBuilder vansNotRunningAlertWithDelegate:self] show];
        }
        
        if (self.updateTimer && [self.updateTimer timeInterval] != kOffHoursUpdateInterval) {
            [self.updateTimer invalidate];
            [self scheduleUpdateTimerForOffHours];
        }
    } else {
        VVRoute *requestedRoute = self.routeBeingDisplayed;
        
        [VVRoute vansForRoute:requestedRoute
          withCompletionBlock:^(NSArray *vans) {
              if ([self.routeBeingDisplayed isEqual:requestedRoute]) {
              NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:[vans count]];
              
              for (VVVan *van in vans) {
                  [annotations addObject:van];
              }
              
              [self.vanMapView removeAnnotations:self.vanAnnotations];
              self.vanAnnotations = annotations;
              [self.vanMapView addAnnotations:self.vanAnnotations];
              }
          }];
        
        if (self.updateTimer && [self.updateTimer timeInterval] != kRunningHoursUpdateInterval) {
            [self.updateTimer invalidate];
            [self scheduleUpdateTimerForRunningHours];
        }
    }
}

- (void)displayVansWithTimer:(NSTimer *)timer {
    [self displayVans];
}

- (void)selectRoute:(VVRoute *)route {
    NSInteger selectedIndex;
    
    if ([route.name isEqualToString:@"Black"]) {
        selectedIndex = 0;
    } else if ([route.name isEqualToString:@"Red"]) {
        selectedIndex = 1;
    } else { // Gold
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
    
    if ([annotation isKindOfClass:[VVVan class]]) {
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

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view isKindOfClass:[VVVanAnnotationView class]]) {
        id<AWSMobileAnalyticsEvent> vanIconTappedEvent = [self.eventClient createEventWithEventType:kVanIconTappedEventType];
        
        [self.eventClient recordEvent:vanIconTappedEvent];
    } else if ([view isKindOfClass:[MKPinAnnotationView class]]) {
        id<AWSMobileAnalyticsEvent> stopIconTappedEvent = [self.eventClient createEventWithEventType:kStopIconTappedEventType];
        [stopIconTappedEvent addAttribute:[view.annotation title]
                                   forKey:kStopNameKey];
        
        [self.eventClient recordEvent:stopIconTappedEvent];
    }
}

#pragma mark - Helper Method

- (UIColor *)colorForRoute:(VVRoute *)route {
    UIColor *color;
    NSString *routeName = route.name;
    
    if ([routeName isEqualToString:@"Blue"]) {
        color = [UIColor blackColor];
    } else if ([routeName isEqualToString:@"Red"]) {
        color = [UIColor redColor];
    } else if ([routeName isEqualToString:@"Gold"]) {
        color = [UIColor colorWithRed:207/255.0f
                                green:181/255.0f
                                 blue:59/255.0f
                                alpha:1.0f];
    } else { // New route
        color = [UIColor blackColor];
    }
    
    return color;
}

@end