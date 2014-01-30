//
//  VVRoute.m
//  Vandy Vans
//
//  Created by Seth Friedman on 2/28/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVRoute.h"
#import "VVVandyVansClient.h"
#import "VVSyncromaticsClient.h"

NSString * const kAnnotationsDateKey = @"annotationsDate";
NSString * const kBlueAnnotationsDateKey = @"blueAnnotationsDateKey";
NSString * const kRedAnnotationsDateKey = @"redAnnotationsDateKey";
NSString * const kGreenAnnotationsDateKey = @"greenAnnotationsDateKey";

NSString * const kPolylineDateKey = @"polylineDate";
NSString * const kBluePolylineDateKey = @"bluePolylineDateKey";
NSString * const kRedPolylineDateKey = @"redPolylineDateKey";
NSString * const kGreenPolylineDateKey = @"greenPolylineDateKey";

static NSTimeInterval const kStaleTimeInterval = -14*24*60*60; // 2 weeks ago

@import MapKit;

@interface VVRoute ()

- (NSString *)routeNameForRouteColor:(VVRouteColor)routeColor;
- (VVRouteColor)routeColorForRouteID:(NSString *)routeID;

+ (NSString *)annotationsKeyForRouteColor:(VVRouteColor)routeColor;
+ (NSString *)polylineKeyForRouteColor:(VVRouteColor)routeColor;

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

#pragma mark - Factory Methods

+ (instancetype)routeWithRouteID:(NSString *)routeID {
    return [[self alloc] initWithRouteID:routeID];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    return (self.routeColor == [object routeColor]) && [self.name isEqualToString:[object name]] && (self.routeID == [object routeID]);
}

#pragma mark - Class Methods

+ (void)annotationsForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *stops))completionBlock {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *annotationsPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@ annotations", route.name]];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![fileManager fileExistsAtPath:annotationsPath] || ([[userDefaults objectForKey:kAnnotationsDateKey] timeIntervalSinceNow] <= kStaleTimeInterval)) {
        [[VVVandyVansClient sharedClient] fetchStopsForRoute:route
                                         withCompletionBlock:^(NSArray *stops, NSError *error) {
                                             if (stops) {
                                                 NSData *stopsData = [NSKeyedArchiver archivedDataWithRootObject:stops];
                                                 [fileManager createFileAtPath:annotationsPath
                                                                      contents:stopsData
                                                                    attributes:nil];
                                                 
                                                 NSDate *now = [NSDate date];
                                                 
                                                 [userDefaults setObject:now
                                                                  forKey:[self annotationsKeyForRouteColor:route.routeColor]];
                                                 
                                                 if (![userDefaults objectForKey:kAnnotationsDateKey]) {
                                                     [userDefaults setObject:now
                                                                      forKey:kAnnotationsDateKey];
                                                 }
                                                 
                                                 [userDefaults synchronize];
                                                 
                                                 completionBlock(stops);
                                             } else {
                                                 NSLog(@"ERROR: %@", error);
                                             }
                                         }];
    } else {
        NSArray *annotations = [NSKeyedUnarchiver unarchiveObjectWithFile:annotationsPath];
        completionBlock(annotations);
    }
}

+ (void)polylineForRoute:(VVRoute *)route withCompletionBlock:(void (^)(MKPolyline *polyline))completionBlock {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *polylinePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@ polyline", route.name]];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![fileManager fileExistsAtPath:polylinePath] || ([[userDefaults objectForKey:kPolylineDateKey] timeIntervalSinceNow] <= kStaleTimeInterval)) {
        [[VVVandyVansClient sharedClient] fetchPolylineForRoute:route
                                            withCompletionBlock:^(MKPolyline *polyline, NSError *error) {
                                                if (polyline) {
                                                    NSData *polylineData = [NSKeyedArchiver archivedDataWithRootObject:polyline];
                                                    [fileManager createFileAtPath:polylinePath
                                                                         contents:polylineData
                                                                       attributes:nil];
                                                    
                                                    NSDate *now = [NSDate date];
                                                    
                                                    [userDefaults setObject:[NSDate date]
                                                                     forKey:[self polylineKeyForRouteColor:route.routeColor]];
                                                    
                                                    if (![userDefaults objectForKey:kPolylineDateKey]) {
                                                        [userDefaults setObject:now
                                                                         forKey:kPolylineDateKey];
                                                    }
                                                    
                                                    [userDefaults synchronize];
                                                    
                                                    completionBlock(polyline);
                                                } else {
                                                    NSLog(@"ERROR: %@", error);
                                                }
                                            }];
    } else {
        MKPolyline *polyline = [NSKeyedUnarchiver unarchiveObjectWithFile:polylinePath];
        completionBlock(polyline);
    }
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

+ (NSString *)annotationsKeyForRouteColor:(VVRouteColor)routeColor {
    NSString *key;
    
    switch (routeColor) {
        case VVRouteColorBlue:
            key = kBlueAnnotationsDateKey;
            break;
            
        case VVRouteColorRed:
            key = kRedAnnotationsDateKey;
            break;
            
        case VVRouteColorGreen:
            key = kGreenAnnotationsDateKey;
            
        default:
            break;
    }
    
    return key;
}

+ (NSString *)polylineKeyForRouteColor:(VVRouteColor)routeColor {
    NSString *key;
    
    switch (routeColor) {
        case VVRouteColorBlue:
            key = kBluePolylineDateKey;
            break;
            
        case VVRouteColorRed:
            key = kRedPolylineDateKey;
            break;
            
        case VVRouteColorGreen:
            key = kGreenPolylineDateKey;
            
        default:
            break;
    }
    
    return key;
}

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