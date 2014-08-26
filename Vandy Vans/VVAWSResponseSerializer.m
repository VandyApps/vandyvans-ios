//
//  VVAWSResponseSerializer.m
//  Vandy Vans
//
//  Created by Seth Friedman on 12/9/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import "VVAWSResponseSerializer.h"
#import "VVArrivalTime.h"
#import "VVVan.h"
#import "VVStop.h"
#import "VVRouteDictionary.h"

@implementation VVAWSResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error {
    id responseObject = [super responseObjectForResponse:response
                                                    data:data
                                                   error:error];
    
    NSString *lastPathComponent = [[response URL] lastPathComponent];
    
    if ([lastPathComponent isEqualToString:@"vans"]) {
        responseObject = [[self class] serializeResponseObject:responseObject
                                                     withBlock:^id(NSDictionary *object) {
                                                         NSString *vanID = object[@"vanID"];
                                                         CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([object[@"latitude"] doubleValue],
                                                                                                                        [object[@"longitude"] doubleValue]);
                                                         NSUInteger percentageFull = [object[@"percentageFull"] integerValue];
                                                         
                                                         return [VVVan vanWithVanID:vanID
                                                                         coordinate:coordinate
                                                                  andPercentageFull:percentageFull];
                                                     }];
    } else if ([lastPathComponent isEqualToString:@"arrivalTimes"]) {
        responseObject = [[self class] serializeResponseObject:responseObject
                                                     withBlock:^id(NSDictionary *object) {
                                                         return [VVArrivalTime arrivalTimeWithStop:[VVStop stopWithID:[NSString stringWithFormat:@"%@", object[@"stopID"]]]
                                                                                             route:[VVRouteDictionary routeForIdentifier:[NSString stringWithFormat:@"%@", object[@"routeID"]]]
                                                                           andArrivalTimeInMinutes:object[@"minutes"]];
                                                     }];
    } else if ([lastPathComponent isEqualToString:@"waypoints"]) {
        NSArray *coordinateResponseArray = responseObject;
        NSUInteger coordinateResponseArrayCount = [coordinateResponseArray count];
        
        CLLocationCoordinate2D coordinates[coordinateResponseArrayCount];
        
        for (NSUInteger i = 0; i < coordinateResponseArrayCount; ++i) {
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([coordinateResponseArray[i][@"latitude"] doubleValue],
                                                                           [coordinateResponseArray[i][@"longitude"] doubleValue]);
            coordinates[i] = coordinate;
        }
        
        responseObject = [MKPolyline polylineWithCoordinates:coordinates
                                                       count:coordinateResponseArrayCount];
    }
    
    return responseObject;
}

/**
 *  Serialize a Parse JSON response object into an `NSArray` of relevant
 *  objects. The response object is assumed to have one inner array for
 *  the key "result".
 *
 *  @param responseObject The response object to serialize.
 *  @param block          The block used to hydrate each object in the
 *                        returned array.
 *
 *  @return An array with relevant objects serialized from the response
 *          object.
 */
+ (NSArray *)serializeResponseObject:(NSArray *)responseObject withBlock:(id (^)(NSDictionary *object))block {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:[responseObject count]];
    
    for (NSDictionary *object in responseObject) {
        [objects addObject:block(object)];
    }
    
    return [objects copy];
}

@end
