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
@property (strong, nonatomic) NSString *routeBeingDisplayed;
@property (strong, nonatomic) NSOrderedSet *routes;

@property (strong, nonatomic) NSArray *blueAnnotations;
@property (strong, nonatomic) NSArray *redAnnotations;
@property (strong, nonatomic) NSArray *greenAnnotations;

@end

@implementation VVMapViewController

@synthesize routeBeingDisplayed = _routeBeingDisplayed;

#pragma mark - Custom Getters

- (NSString *)routeBeingDisplayed {
    if (!_routeBeingDisplayed) {
        _routeBeingDisplayed = @"Blue";
    }
    
    return _routeBeingDisplayed;
}

- (NSOrderedSet *)routes {
    if (!_routes) {
        _routes = [NSOrderedSet orderedSetWithObjects:@"Blue", @"Red", @"Green", nil];
    }
    
    return _routes;
}

#pragma mark - Custom Setter

- (void)setRouteBeingDisplayed:(NSString *)routeBeingDisplayed {
    if (_routeBeingDisplayed != routeBeingDisplayed) {
        _routeBeingDisplayed = routeBeingDisplayed;
        
        /*[self.vanMapView clear];
        [self dropMarkersForRoute:_routeBeingDisplayed];
        [self addPolylineToRoute:_routeBeingDisplayed];*/
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
            sender.tintColor = [UIColor blueColor];
            self.routeBeingDisplayed = @"Blue";
            break;
            
        case 1:
            sender.tintColor = [UIColor redColor];
            self.routeBeingDisplayed = @"Red";
            break;
            
        case 2:
            sender.tintColor = [UIColor colorWithRed:51/255.0f
                                               green:189/255.0f
                                                blue:50/255.0f
                                               alpha:1.0f];
            self.routeBeingDisplayed = @"Green";
            break;
            
        default:
            break;
    }
}

#pragma mark - Helper Methods

/*- (void)repositionCamera {
    GMSPolyline *polyline = self.vanMapView.polylines[0];
    GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate fitBounds:[[GMSCoordinateBounds alloc] initWithPath:polyline.path]];
    [self.vanMapView animateWithCameraUpdate:cameraUpdate];
}

- (void)dropMarkersForRoute:(NSString *)routeName {
    NSArray *routeMarkers = [VVRoute markersForRouteColor:[VVRoute routeColorForRouteName:routeName]];
    
    for (GMSMarker *marker in routeMarkers) {
        marker.map = self.vanMapView;
    }
}

- (void)addPolylineToRoute:(NSString *)routeName {
    GMSPolyline *polyline = [VVRoute polylineForRouteColor:[VVRoute routeColorForRouteName:routeName]];
    polyline.map = self.vanMapView;
        
    [self repositionCamera];
}*/

- (void)displayAnnotationsForRoute:(NSString *)routeName {
    [VVRoute annotationsForRouteColor:[VVRoute routeColorForRouteName:routeName]
                  withCompletionBlock:^(NSArray *stops) {
                      [self.vanMapView addAnnotations:stops];
                  }];
}

- (void)displayPolylineForRoute:(NSString *)routeName {
    [VVRoute polylineForRouteColor:[VVRoute routeColorForRouteName:routeName]
               withCompletionBlock:^(MKPolyline *polyline) {
                   [self.vanMapView addOverlay:polyline];
               }];
}

#pragma mark - Map View Delegate

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKOverlayRenderer *renderer;
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        ((MKPolylineRenderer *)renderer).strokeColor = [UIColor blueColor];
        ((MKPolylineRenderer *)renderer).lineWidth = 3.0f;
    }
    
    return renderer;
}

@end