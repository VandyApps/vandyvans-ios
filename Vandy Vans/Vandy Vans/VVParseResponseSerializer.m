//
//  VVSyncromaticsResponseSerializer.m
//  Vandy Vans
//
//  Created by Seth Friedman on 12/9/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import "VVParseResponseSerializer.h"
#import "VVArrivalTime.h"
#import "VVVan.h"
#import "VVStop.h"
#import "VVRouteDictionary.h"

@implementation VVParseResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error {
    id responseObject = [super responseObjectForResponse:response
                                                    data:data
                                                   error:error];
    
    NSString *lastPathComponent = response.URL.lastPathComponent;
    
    if ([lastPathComponent isEqualToString:@"Vehicles"]) {
        NSArray *vehicleResponseArray = responseObject;
        
        NSMutableArray *vans = [NSMutableArray arrayWithCapacity:[vehicleResponseArray count]];
        
        for (NSDictionary *van in vehicleResponseArray) {
            NSString *vanID = van[@"ID"];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([van[@"Latitude"] doubleValue],
                                                                           [van[@"Longitude"] doubleValue]);
            NSUInteger percentageFull = [van[@"APCPercentage"] integerValue];
            
            [vans addObject:[VVVan vanWithVanID:vanID
                                     coordinate:coordinate
                              andPercentageFull:percentageFull]];
        }
        
        responseObject = [vans copy];
    } else if ([lastPathComponent isEqualToString:@"arrivalTimes"]) {
        NSDictionary *responseDictionary = responseObject;
        NSArray *arrivalTimesResponseArray = responseDictionary[@"result"];
        
        NSMutableArray *arrivalTimes = [NSMutableArray arrayWithCapacity:[arrivalTimesResponseArray count]];
        
        for (NSDictionary *arrivalTime in arrivalTimesResponseArray) {
            // Make sure it is accurately getting the Stop Name from the JSON
            [arrivalTimes addObject:[VVArrivalTime arrivalTimeWithStop:[VVStop stopWithID:[NSString stringWithFormat:@"%@", arrivalTime[@"stopID"]]]
                                                                 route:[VVRouteDictionary routeForIdentifier:[NSString stringWithFormat:@"%@", arrivalTime[@"routeID"]]]
                                               andArrivalTimeInMinutes:arrivalTime[@"minutes"]]];
        }
        
        responseObject = [arrivalTimes copy];
    }
    
    return responseObject;
}

@end
