//
//  VVMapViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 10/11/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import "VVMapViewController.h"
#import "VVRoute.h"
#import <GoogleMaps/GoogleMaps.h>
#import "GMSMarker+ConstructorAdditions.h"

@interface VVMapViewController () <GMSMapViewDelegate>

@property (strong, nonatomic) IBOutlet GMSMapView *vanMapView;
@property (strong, nonatomic) NSString *routeBeingDisplayed;
@property (strong, nonatomic) NSOrderedSet *routes;

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
        
        [self.vanMapView clear];
        [self dropMarkersForRoute:_routeBeingDisplayed];
        [self addPolylineToRoute:_routeBeingDisplayed];
    }
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vanMapView.myLocationEnabled = YES;
    self.vanMapView.settings.myLocationButton = YES;
    
    // Drop pins on stops depending on which route is being displayed.
    [self dropMarkersForRoute:self.routeBeingDisplayed];
    
    // Add the appropriate polyline for the given route.
    [self addPolylineToRoute:self.routeBeingDisplayed];
    
    /*GMSMarker *vanMarker = [GMSMarker markerWithLatitude:36.148118 longitude:-86.806012 andTitle:@"Test"];
    vanMarker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
    vanMarker.map = self.vanMapView;*/
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
            sender.tintColor = [UIColor greenColor];
            self.routeBeingDisplayed = @"Green";
            break;
            
        default:
            break;
    }
}

#pragma mark - Helper Methods

- (void)repositionCamera {
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
}

@end