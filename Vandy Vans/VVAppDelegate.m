//
//  VVAppDelegate.m
//  Vandy Vans
//
//  Created by Seth Friedman on 10/11/12.
//  Copyright (c) 2012 VandyApps. All rights reserved.
//

#import "VVAppDelegate.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "VVArrivalTimeTableViewController.h"
#import "VVAlertBuilder.h"
#import "VVAppearanceBuilder.h"
#import "VVRoute.h"
#import <Crashlytics/Crashlytics.h>
#import <AWSiOSSDKv2/AWSCore.h>
#import <AWSiOSSDKv2/AWSMobileAnalytics.h>

static NSTimeInterval const kStaleTimeInterval = -14*24*60*60; // 2 weeks ago

@implementation VVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [VVAppearanceBuilder buildAppearance];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"America/Chicago"]];
    
    [Crashlytics startWithAPIKey:@"18d97f17a7d34a2b79244c7fc057a01a9e96a9a7"];
    
    AWSCognitoCredentialsProvider *credentialsProvider = [AWSCognitoCredentialsProvider credentialsWithRegionType:AWSRegionUSEast1
                                                                                                        accountId:@"982943484315"
                                                                                                   identityPoolId:@"us-east-1:072f1854-e969-44e2-a6ec-91df3a72693e"
                                                                                                    unauthRoleArn:@"arn:aws:iam::982943484315:role/Cognito_VandyVansUnauth_DefaultRole"
                                                                                                      authRoleArn:@"arn:aws:iam::982943484315:role/Cognito_VandyVansAuth_DefaultRole"];
    
    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionUSEast1
                                                                          credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
    [AWSMobileAnalytics mobileAnalyticsForAppId:[[[UIDevice currentDevice] identifierForVendor].UUIDString stringByAppendingString:@"edu.vanderbilt.vandyvans"]];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *vanArrivingAlertView = [VVAlertBuilder vanArrivingAlertWithRouteName:notification.userInfo[@"RouteName"] andStopName:notification.userInfo[@"StopName"]];
        [vanArrivingAlertView show];
    } else {
        application.applicationIconBadgeNumber += notification.applicationIconBadgeNumber;
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // Ensures that the badge number is cleaned up when no notifications are present.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Background Fetch

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[userDefaults objectForKey:kAnnotationsDateKey] timeIntervalSinceNow] <= kStaleTimeInterval) {
        [self updateAnnotationsWithUserDefaults:userDefaults
                              completionHandler:completionHandler];
    } else if ([[userDefaults objectForKey:kPolylineDateKey] timeIntervalSinceNow] <= kStaleTimeInterval) {
        [self updatePolylineWithUserDefaults:userDefaults
                           completionHandler:completionHandler];
    } else {
        completionHandler(UIBackgroundFetchResultNoData);
    }
}

#pragma mark - Helper Methods

- (void)updateAnnotationsWithUserDefaults:(NSUserDefaults *)userDefaults completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [VVRoute annotationsForRoute:[VVRoute routeWithRouteID:kBlackRouteID]
             withCompletionBlock:^(NSArray *stops) {
                 [userDefaults setObject:[NSDate date]
                                  forKey:kAnnotationsDateKey];
                 
                 dispatch_group_leave(group);
             }];
    
    dispatch_group_enter(group);
    [VVRoute annotationsForRoute:[VVRoute routeWithRouteID:kRedRouteID]
             withCompletionBlock:^(NSArray *stops) {
                 dispatch_group_leave(group);
             }];
    
    dispatch_group_enter(group);
    [VVRoute annotationsForRoute:[VVRoute routeWithRouteID:kGoldRouteID]
             withCompletionBlock:^(NSArray *stops) {
                 dispatch_group_leave(group);
             }];
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [userDefaults synchronize];
        
        completionHandler(UIBackgroundFetchResultNewData);
    });
}

- (void)updatePolylineWithUserDefaults:(NSUserDefaults *)userDefaults completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [VVRoute polylineForRoute:[VVRoute routeWithRouteID:kBlackRouteID]
          withCompletionBlock:^(MKPolyline *polyline) {
              [userDefaults setObject:[NSDate date]
                               forKey:kPolylineDateKey];
              
              dispatch_group_leave(group);
          }];
    
    dispatch_group_enter(group);
    [VVRoute polylineForRoute:[VVRoute routeWithRouteID:kRedRouteID]
          withCompletionBlock:^(MKPolyline *polyline) {
              dispatch_group_leave(group);
          }];
    
    dispatch_group_enter(group);
    [VVRoute polylineForRoute:[VVRoute routeWithRouteID:kGoldRouteID]
          withCompletionBlock:^(MKPolyline *polyline) {
              dispatch_group_leave(group);
          }];
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [userDefaults synchronize];
        
        completionHandler(UIBackgroundFetchResultNewData);
    });
}

@end
