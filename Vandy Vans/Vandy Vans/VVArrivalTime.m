//
//  VVArrivalTime.m
//  Vandy Vans
//
//  Created by Seth Friedman on 11/24/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import "VVArrivalTime.h"
#import "VVAPIClient.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation VVArrivalTime

@synthesize stopName = _stopName;
@synthesize arrivalTimeInMinutes = _arrivalTimeInMinutes;

- (id)initWithAttributes:(NSDictionary*)attributes {
    self = [super init];
    if (self) {
        _stopName = [attributes objectForKey:@"StopName"];
        _arrivalTimeInMinutes = [[attributes objectForKey:@"ArrivalTimeInMinutes"] integerValue];
    }
    
    return self;
}

+ (BOOL)isStopForAllRoutes:(NSString *)stopName {
    return ([stopName isEqualToString:@"Branscomb Quad"] || [stopName isEqualToString:@"Carmichael Towers"] ||
      [stopName isEqualToString:@"Murray House"] || [stopName isEqualToString:@"Highland Quad"]);
}

+ (BOOL)isStopForOnlyGreenRoute:(NSString *)stopName {
    return ([stopName isEqualToString:@"Vanderbilt Police Department"] || [stopName isEqualToString:@"Vanderbilt Book Store"] ||
      [stopName isEqualToString:@"Kissam Quad"] || [stopName isEqualToString:@"Terrace Place Garage"] ||
      [stopName isEqualToString:@"Wesley Place Garage"] || [stopName isEqualToString:@"Blair School of Music"] ||
      [stopName isEqualToString:@"McGugin Center"] || [stopName isEqualToString:@"Blakemore House"]);
}

+ (void)arrivalTimesForStopID:(NSUInteger)stopID stopName:(NSString *)stopName withBlock:(void (^)(NSArray *arrivalTimes))block {
    NSDictionary *params = @{@"api_key" : @"a922a34dfb5e63ba549adbb259518909"};
    __block NSDictionary *arrivalTimeAttributes;
    __block NSMutableOrderedSet *arrivalTimesSet;
    
    BOOL isStopForAllRoutes = [self isStopForAllRoutes:stopName];
    
    // Get all of the arrival times for the Blue Route.
    if (isStopForAllRoutes || [stopName isEqualToString:@"Kissam Quad"]) {
        [[VVAPIClient sharedClient] getPath:[[[[@"Route/" stringByAppendingFormat:@"%i", 745] stringByAppendingString:@"/Stop/"] stringByAppendingFormat:@"%i", stopID] stringByAppendingString:@"/Arrivals"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            for (NSDictionary *predictions in [responseObject objectForKey:@"Predictions"]) {
                arrivalTimeAttributes = @{
                    @"StopName" : stopName,
                    @"ArrivalTimeInMinutes" : [predictions objectForKey:@"Minutes"]
                };
                [arrivalTimesSet addObject:[[VVArrivalTime alloc] initWithAttributes:arrivalTimeAttributes]];
            }
            
            // Get all of the arrival times for the Green Route.
            if (isStopForAllRoutes || [self isStopForOnlyGreenRoute:stopName]) {
                [[VVAPIClient sharedClient] getPath:[[[[@"Route/" stringByAppendingFormat:@"%i", 749] stringByAppendingString:@"/Stop/"] stringByAppendingFormat:@"%i", stopID] stringByAppendingString:@"/Arrivals"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    for (NSDictionary *predictions in [responseObject objectForKey:@"Predictions"]) {
                        arrivalTimeAttributes = @{
                            @"StopName" : stopName,
                            @"ArrivalTimeInMinutes" : [predictions objectForKey:@"Minutes"]
                        };
                        [arrivalTimesSet addObject:[[VVArrivalTime alloc] initWithAttributes:arrivalTimeAttributes]];
                    }
                    
                    // Get all of the arrival times for the Red Route.
                    if (isStopForAllRoutes || [stopName isEqualToString:@"North House"]) {
                        [[VVAPIClient sharedClient] getPath:[[[[@"Route/" stringByAppendingFormat:@"%i", 746] stringByAppendingString:@"/Stop/"] stringByAppendingFormat:@"%i", stopID] stringByAppendingString:@"/Arrivals"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            for (NSDictionary *predictions in [responseObject objectForKey:@"Predictions"]) {
                                arrivalTimeAttributes = @{
                                    @"StopName" : stopName,
                                    @"ArrivalTimeInMinutes" : [predictions objectForKey:@"Minutes"]
                                };
                                [arrivalTimesSet addObject:[[VVArrivalTime alloc] initWithAttributes:arrivalTimeAttributes]];
                            }
                            
                            // Get all of the arrival times for the Yellow Route when running.
                            
                            if (block) {
                                block([arrivalTimesSet sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                                    if (((VVArrivalTime *)obj1).arrivalTimeInMinutes > ((VVArrivalTime *)obj2).arrivalTimeInMinutes) {
                                        return (NSComparisonResult)NSOrderedDescending;
                                    } else if (((VVArrivalTime *)obj1).arrivalTimeInMinutes < ((VVArrivalTime *)obj2).arrivalTimeInMinutes) {
                                        return (NSComparisonResult)NSOrderedAscending;
                                    } else {
                                        return (NSComparisonResult)NSOrderedSame;
                                    }
                                }]);
                            }
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"Error: %@", error);
                            
                            if (block) {
                                block(nil);
                            }
                        }];
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                    
                    if (block) {
                        block(nil);
                    }
                }];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        
            if (block) {
                block(nil);
            }
        }];
    }
}

@end
