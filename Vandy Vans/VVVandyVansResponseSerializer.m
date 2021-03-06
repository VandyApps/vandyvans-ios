//
//  VVVandyVansResponseSerializer.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/30/14.
//  Copyright (c) 2014 VandyApps. All rights reserved.
//

#import "VVVandyVansResponseSerializer.h"

@import MapKit;

@implementation VVVandyVansResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error {
    id responseObject = [super responseObjectForResponse:response
                                                    data:data
                                                   error:error];
    
    NSString *lastPathComponent = response.URL.lastPathComponent;
    
    if ([lastPathComponent isEqualToString:@"Stops"]) {
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
    }
    
    return responseObject;
}

@end
