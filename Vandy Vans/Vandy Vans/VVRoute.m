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

@interface VVRoute ()

- (NSString *)routeNameForRouteColor:(VVRouteColor)routeColor;
- (VVRouteColor)routeColorForRouteID:(NSString *)routeID;

@end

@implementation VVRoute

#pragma mark - Designated Initializer

- (instancetype)initWithRouteID:(NSString *)routeID {
    self = [super init];
    
    if (self) {
        _routeColor = [self routeColorForRouteID:routeID];
        _name = [self routeNameForRouteColor:_routeColor];
        _routeID = routeID;
    }
    
    return self;
}

#pragma mark - Factory Method

+ (instancetype)routeWithRouteID:(NSString *)routeID {
    return [[self alloc] initWithRouteID:routeID];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    return (self.routeColor == [object routeColor]) && [self.name isEqualToString:[object name]] && (self.routeID == [object routeID]);
}

#pragma mark - Class Methods

+ (void)annotationsForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *stops))completionBlock {
    [[VVSyncromaticsClient sharedClient] fetchStopsForRoute:route
                                        withCompletionBlock:^(NSArray *stops, NSError *error) {
                                            if (stops) {
                                                completionBlock(stops);
                                            } else {
                                                NSLog(@"ERROR: %@", error);
                                            }
                                        }];
}

+ (void)polylineForRoute:(VVRoute *)route withCompletionBlock:(void (^)(MKPolyline *polyline))completionBlock {
    [[VVSyncromaticsClient sharedClient] fetchPolylineForRoute:route
                                           withCompletionBlock:^(MKPolyline *polyline, NSError *error) {
                                               if (polyline) {
                                                   completionBlock(polyline);
                                               } else {
                                                   NSLog(@"ERROR: %@", error);
                                               }
                                           }];
}

+ (void)vansForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *vans))completionBlock {
    [[VVSyncromaticsClient sharedClient] fetchVansForRoute:route
                                       withCompletionBlock:^(NSArray *vans, NSError *error) {
                                           if (vans) {
                                               completionBlock(vans);
                                           } else {
                                               NSLog(@"ERROR: %@", error);
                                           }
                                       }];
}

#pragma mark - Helper Methods

- (NSString *)routeNameForRouteColor:(VVRouteColor)routeColor {
    NSString *routeName;
    
    switch (routeColor) {
        case VVRouteColorBlue:
            routeName = @"Blue";
            break;
            
        case VVRouteColorRed:
            routeName = @"Red";
            break;
            
        case VVRouteColorGreen:
            routeName = @"Green";
            break;
            
        default:
            break;
    }
    
    return routeName;
}

- (VVRouteColor)routeColorForRouteID:(NSString *)routeID {
    VVRouteColor routeColor;
    
    if ([routeID isEqualToString:@"745"]) {
        routeColor = VVRouteColorBlue;
    } else if ([routeID isEqualToString:@"746"]) {
        routeColor = VVRouteColorRed;
    } else { // Green
        routeColor = VVRouteColorGreen;
    }
    
    return routeColor;
}

@end