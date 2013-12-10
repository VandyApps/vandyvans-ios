//
//  VVRoute.m
//  Vandy Vans
//
//  Created by Seth Friedman on 2/28/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVRoute.h"
#import "VVSyncromaticsClient.h"

@import MapKit;

@implementation VVRoute

+ (void)annotationsForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(NSArray *stops))completionBlock {
    [[VVSyncromaticsClient sharedClient] fetchStopsForRouteColor:routeColor
                                             withCompletionBlock:^(NSArray *stops, NSError *error) {
                                                 if (stops) {
                                                     completionBlock(stops);
                                                 } else {
                                                     NSLog(@"ERROR: %@", error);
                                                 }
                                             }];
}

+ (void)polylineForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(MKPolyline *polyline))completionBlock {
    [[VVSyncromaticsClient sharedClient] fetchPolylineForRouteColor:routeColor
                                                withCompletionBlock:^(MKPolyline *polyline, NSError *error) {
                                                    if (polyline) {
                                                        completionBlock(polyline);
                                                    } else {
                                                        NSLog(@"ERROR: %@", error);
                                                    }
                                                }];
}

+ (void)vansForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(NSArray *vans))completionBlock {
    [[VVSyncromaticsClient sharedClient] fetchVansForRouteColor:routeColor
                                            withCompletionBlock:^(NSArray *vans, NSError *error) {
                                                if (vans) {
                                                    completionBlock(vans);
                                                } else {
                                                    NSLog(@"ERROR: %@", error);
                                                }
                                            }];
}

+ (NSInteger)routeIDForRouteColor:(VVRouteColor)routeColor {
    NSInteger routeID;
    
    switch (routeColor) {
        case VVRouteColorBlue:
            routeID = 745;
            break;
            
        case VVRouteColorRed:
            routeID = 746;
            break;
            
        default: // Green
            routeID = 749;
            break;
    }
    
    return routeID;
}

+ (VVRouteColor)routeColorForRouteName:(NSString *)routeName {
    VVRouteColor routeColor;
    
    if ([routeName isEqualToString:@"Blue"]) {
        routeColor = VVRouteColorBlue;
    } else if ([routeName isEqualToString:@"Red"]) {
        routeColor = VVRouteColorRed;
    } else { // Green
        routeColor = VVRouteColorGreen;
    }
    
    return routeColor;
}

@end