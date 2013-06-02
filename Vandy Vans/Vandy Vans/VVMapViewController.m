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
#import <GoogleMaps/GoogleMaps.h>
#import "GMSMarker+ConstructorAdditions.h"

@interface VVMapViewController () <GMSMapViewDelegate>

@property (strong, nonatomic) IBOutlet GMSMapView *vanMapView;
@property (strong, nonatomic) NSString *routeBeingDisplayed;
@property (strong, nonatomic) NSOrderedSet *routes;
@property (strong, nonatomic) BSModalPickerView *routePickerView;

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

- (BSModalPickerView *)routePickerView {
    if (!_routePickerView) {
        _routePickerView = [[BSModalPickerView alloc] initWithValues:[self.routes array]];
        _routePickerView.selectedValue = self.routeBeingDisplayed;
    }
    
    return _routePickerView;
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
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    // Google Analytics
    self.trackedViewName = @"Map View";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

- (IBAction)routePressed:(UIBarButtonItem *)sender {
    sender.enabled = NO;
    
    [self.routePickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
        if (madeChoice) {
            self.routeBeingDisplayed = [self.routePickerView selectedValue];
        }
        
        sender.enabled = YES;
    }];
}

#pragma mark - Helper Methods

- (void)repositionCamera {
    GMSPolyline *polyline = self.vanMapView.polylines[0];
    GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate fitBounds:[[GMSCoordinateBounds alloc] initWithPath:polyline.path]];
    [self.vanMapView animateWithCameraUpdate:cameraUpdate];
}

- (void)dropMarkersForRoute:(NSString *)routeName {
    dispatch_queue_t dispatchQueue = dispatch_queue_create("org.VandyMobile.Vandy-Vans.DropMarkers", 0);
    dispatch_async(dispatchQueue, ^{
        NSArray *routeMarkers = [VVRoute markersForRouteColor:[VVRoute routeColorForRouteName:routeName]];
        
        [routeMarkers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            GMSMarker *marker = obj;
            dispatch_async(dispatch_get_main_queue(), ^{
                marker.map = self.vanMapView;
            });
        }];
    });
}

- (void)addPolylineToRoute:(NSString *)routeName {
    dispatch_queue_t dispatchQueue = dispatch_queue_create("org.VandyMobile.Vandy-Vans.AddPolyline", 0);
    dispatch_async(dispatchQueue, ^{
        GMSPolyline *polyline = [VVRoute polylineForRouteColor:[VVRoute routeColorForRouteName:routeName]];
        dispatch_async(dispatch_get_main_queue(), ^{
            polyline.map = self.vanMapView;
            
            [self repositionCamera];
        });
    });
}

@end