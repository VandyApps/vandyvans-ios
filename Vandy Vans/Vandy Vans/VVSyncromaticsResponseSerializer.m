//
//  VVSyncromaticsResponseSerializer.m
//  Vandy Vans
//
//  Created by Seth Friedman on 12/9/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVSyncromaticsResponseSerializer.h"
#import "VVArrivalTime.h"
#import "VVVan.h"

@import MapKit;

@implementation VVSyncromaticsResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error {
    id responseObject = [super responseObjectForResponse:response
                                                    data:data
                                                   error:error];
    
    if ([response.URL.lastPathComponent isEqualToString:@"Waypoints"]) {
        NSArray *coordinateResponseArray = responseObject;
        NSUInteger coordinateResponseArrayCount = [coordinateResponseArray count];
        
        CLLocationCoordinate2D coordinates[coordinateResponseArrayCount];
        
        for (NSUInteger i = 0; i < coordinateResponseArrayCount; ++i) {
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([coordinateResponseArray[i][@"Latitude"] doubleValue],
                                                                           [coordinateResponseArray[i][@"Longitude"] doubleValue]);
            coordinates[i] = coordinate;
        }
        
        responseObject = [MKPolyline polylineWithCoordinates:coordinates
                                                       count:coordinateResponseArrayCount];
    } else if ([response.URL.lastPathComponent isEqualToString:@"Stops"]) {
        NSArray *stopResponseArray = responseObject;
        
        NSMutableArray *stops = [NSMutableArray arrayWithCapacity:[stopResponseArray count]];
        
        for (NSDictionary *stop in stopResponseArray) {
            MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
            pointAnnotation.title = stop[@"Name"];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake([stop[@"Latitude"] doubleValue],
                                                                    [stop[@"Longitude"] doubleValue]);
            
            [stops addObject:pointAnnotation];
        }
        
        responseObject = [stops copy];
    } else if ([response.URL.lastPathComponent isEqualToString:@"Vehicles"]) {
        NSArray *vehicleResponseArray = responseObject;
        
        NSMutableArray *vans = [NSMutableArray arrayWithCapacity:[vehicleResponseArray count]];
        
        for (NSDictionary *van in vehicleResponseArray) {
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([van[@"Latitude"] doubleValue],
                                                                           [van[@"Longitude"] doubleValue]);
            NSUInteger percentageFull = [van[@"APCPercentage"] integerValue];
            
            [vans addObject:[VVVan vanWithCoordinate:coordinate
                                   andPercentageFull:percentageFull]];
        }
        
        responseObject = [vans copy];
    }
    
    return responseObject;
}

@end
