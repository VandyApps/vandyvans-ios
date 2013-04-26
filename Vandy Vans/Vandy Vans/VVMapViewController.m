//
//  VVMapViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 10/11/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import "VVMapViewController.h"
#import <BSModalPickerView/BSModalPickerView.h>
#import "VVRoute.h"

@interface VVMapViewController () <GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *vanMapView;
@property (strong, nonatomic) NSString *routeBeingDisplayed;
@property (strong, nonatomic) NSOrderedSet *routes;

@end

@implementation VVMapViewController

@synthesize vanMapView = _vanMapView;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vanMapView.myLocationEnabled = YES;
    self.vanMapView.settings.myLocationButton = YES;
    
    self.vanMapView.camera = [GMSCameraPosition cameraWithLatitude:36.14381 longitude:-86.801643 zoom:14.7];
    
    // Drop pins on stops depending on which route is being displayed.
    [self dropMarkersForRoute:self.routeBeingDisplayed];
    
    // Add the appropriate polyline for the given route.
    [self addPolylineToRoute:self.routeBeingDisplayed];
    
    //[self repositionCamera];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (IBAction)routePressed:(UIBarButtonItem *)sender {
    sender.enabled = NO;
    
    BSModalPickerView *routePickerView = [[BSModalPickerView alloc] initWithValues:[self.routes array]];
    routePickerView.selectedValue = self.routeBeingDisplayed;
    [routePickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
        if (self.routeBeingDisplayed != [routePickerView selectedValue]) {
            self.routeBeingDisplayed = [routePickerView selectedValue];
            
            [self.vanMapView clear];
            [self dropMarkersForRoute:self.routeBeingDisplayed];
            [self addPolylineToRoute:self.routeBeingDisplayed];
            
            [self repositionCamera];
        }
        
        sender.enabled = YES;
    }];
}

- (void)repositionCamera {
    GMSPolyline *polyline = self.vanMapView.polylines[0];
    GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate fitBounds:[[GMSCoordinateBounds alloc] initWithPath:polyline.path]];
    [self.vanMapView animateWithCameraUpdate:cameraUpdate];
}

- (void)dropMarkersForRoute:(NSString *)routeName {
    NSArray *routeMarkers = [VVRoute markersForRouteName:routeName];
    
    for (GMSMarker *marker in routeMarkers) {
        marker.map = self.vanMapView;
    }
}

- (void)addPolylineToRoute:(NSString *)routeName {
    [VVRoute polylineForRouteName:routeName].map = self.vanMapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end