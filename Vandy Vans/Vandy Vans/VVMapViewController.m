//
//  VVMapViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 10/11/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import "VVMapViewController.h"
#import "VVRoute.h"

@import MapKit;

@interface VVMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *vanMapView;
@property (strong, nonatomic) VVRoute *routeBeingDisplayed;
@property (nonatomic, copy) NSOrderedSet *routes;

@property (nonatomic, copy) NSArray *blueAnnotations;
@property (nonatomic, copy) NSArray *redAnnotations;
@property (nonatomic, copy) NSArray *greenAnnotations;

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
    
    // Drop pins on stops depending on which route is being displayed.
    [self displayAnnotationsForRoute:self.routeBeingDisplayed];
    
    // Add the appropriate polyline for the given route.
    [self displayPolylineForRoute:self.routeBeingDisplayed];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.barStyle = UIBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

- (IBAction)routeTapped:(UISegmentedControl *)sender {
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