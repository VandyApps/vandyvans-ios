//
//  VVRoute.m
//  Vandy Vans
//
//  Created by Seth Friedman on 2/28/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import "VVRoute.h"
#import "VVVandyVansClient.h"
#import "VVAWSClient.h"

NSString * const kBlackRouteID = @"1857";
NSString * const kRedRouteID = @"1858";
NSString * const kGoldRouteID = @"1856";

NSString * const kBlackMapRouteID = @"1290";
NSString * const kRedMapRouteID = @"1291";
NSString * const kGoldMapRouteID = @"1289";

NSString * const kAnnotationsDateKey = @"annotationsDate";
NSString * const kBlackAnnotationsDateKey = @"blackAnnotationsDateKey";
NSString * const kRedAnnotationsDateKey = @"redAnnotationsDateKey";
NSString * const kGoldAnnotationsDateKey = @"goldAnnotationsDateKey";

NSString * const kPolylineDateKey = @"polylineDate";
NSString * const kBlackPolylineDateKey = @"blackPolylineDateKey";
NSString * const kRedPolylineDateKey = @"redPolylineDateKey";
NSString * const kGoldPolylineDateKey = @"goldPolylineDateKey";

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
        _mapRouteID = [VVRoute mapRouteIDForRouteID:_routeID];
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
        [[VVAWSClient sharedClient] fetchPolylineForRoute:route
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
        // Remove files from Blue and Green polylines that no longer exist so
        // that we don't take up space on the user's phone.
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSString *bluePolylinePath = [documentsPath stringByAppendingPathComponent:@"Blue polyline"];
            NSString *greenPolylinePath = [documentsPath stringByAppendingPathComponent:@"Green polyline"];
            
            NSError *error;
            
            if ([fileManager fileExistsAtPath:bluePolylinePath]) {
                [fileManager removeItemAtPath:bluePolylinePath
                                        error:&error];
                
                if (error) {
                    NSLog(@"Error removing Blue Polyline file: %@", [error description]);
                }
            }
            
            if ([fileManager fileExistsAtPath:greenPolylinePath]) {
                [fileManager removeItemAtPath:greenPolylinePath
                                        error:&error];
                
                if (error) {
                    NSLog(@"Error removing Green Polyline file: %@", [error description]);
                }
            }
        });
        
        // Get the polyline from the file.
        MKPolyline *polyline = [NSKeyedUnarchiver unarchiveObjectWithFile:polylinePath];
        completionBlock(polyline);
    }
}

+ (NSURLSessionDataTask *)vansForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *vans))completionBlock {
    return [[VVAWSClient sharedClient] fetchVansForRoute:route
                                       withCompletionBlock:^(NSArray *vans, NSError *error) {
                                           if (vans) {
                                               completionBlock(vans);
                                           } else {
                                               if ([[error domain] isEqualToString:NSURLErrorDomain] && [error code] == NSURLErrorCancelled) {
                                                   NSLog(@"Van fetch was cancelled");
                                               } else {
                                                   NSLog(@"ERROR: %@", error);
                                               }
                                           }
                                       }];
}

#pragma mark - Helper Methods

+ (NSString *)annotationsKeyForRouteColor:(VVRouteColor)routeColor {
    NSString *key;
    
    switch (routeColor) {
        case VVRouteColorBlack:
            key = kBlackAnnotationsDateKey;
            break;
            
        case VVRouteColorRed:
            key = kRedAnnotationsDateKey;
            break;
            
        case VVRouteColorGold:
            key = kGoldAnnotationsDateKey;
            
        default:
            break;
    }
    
    return key;
}

+ (NSString *)polylineKeyForRouteColor:(VVRouteColor)routeColor {
    NSString *key;
    
    switch (routeColor) {
        case VVRouteColorBlack:
            key = kBlackPolylineDateKey;
            break;
            
        case VVRouteColorRed:
            key = kRedPolylineDateKey;
            break;
            
        case VVRouteColorGold:
            key = kGoldPolylineDateKey;
            
        default:
            break;
    }
    
    return key;
}

+ (NSString *)mapRouteIDForRouteID:(NSString *)routeID {
    NSString *mapRouteID;
    
    if ([routeID isEqualToString:kBlackRouteID]) {
        mapRouteID = kBlackMapRouteID;
    } else if ([routeID isEqualToString:kRedRouteID]) {
        mapRouteID = kRedMapRouteID;
    } else { // Gold
        mapRouteID = kGoldMapRouteID;
    }
    
    return mapRouteID;
}

- (NSString *)routeNameForRouteColor:(VVRouteColor)routeColor {
    NSString *routeName;
    
    switch (routeColor) {
        case VVRouteColorBlack:
            routeName = @"Black";
            break;
            
        case VVRouteColorRed:
            routeName = @"Red";
            break;
            
        case VVRouteColorGold:
            routeName = @"Gold";
            break;
            
        default:
            break;
    }
    
    return routeName;
}

- (VVRouteColor)routeColorForRouteID:(NSString *)routeID {
    VVRouteColor routeColor;
    
    if ([routeID isEqualToString:kBlackRouteID]) {
        routeColor = VVRouteColorBlack;
    } else if ([routeID isEqualToString:kRedRouteID]) {
        routeColor = VVRouteColorRed;
    } else { // Gold
        routeColor = VVRouteColorGold;
    }
    
    return routeColor;
}

@end