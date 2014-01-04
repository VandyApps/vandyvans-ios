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
            self.routeBeingDisplayed = self.routes[0];
            break;
            
        case 1:
            sender.tintColor = [UIColor redColor];
            self.routeBeingDisplayed = self.routes[1];
            break;
            
        case 2:
            sender.tintColor = [UIColor colorWithRed:51/255.0f
                                               green:189/255.0f
                                                blue:50/255.0f
                                               alpha:1.0f];
            self.routeBeingDisplayed = self.routes[2];
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
              [self.vanMapView setVisibleMapRect:polyline.boundingMapRect
                                        animated:YES];
          }];
}

#pragma mark - Map View Delegate

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKOverlayRenderer *renderer;
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *polylineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.strokeColor = [UIColor blueColor];
        polylineRenderer.lineWidth = 3.0f;
        
        renderer = polylineRenderer;
    }
    
    return renderer;
}

@end