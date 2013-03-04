//
//  VVAppDelegate.m
//  Vandy Vans
//
//  Created by Seth Friedman on 10/11/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import "VVAppDelegate.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "VVArrivalTimeTableViewController.h"

@implementation VVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (localNotification) {
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        UINavigationController *navigationController = (UINavigationController *)[tabBarController.viewControllers objectAtIndex:0];
        
        VVArrivalTimeTableViewController *arrivalTimeTableViewController = [[VVArrivalTimeTableViewController alloc] init];
        arrivalTimeTableViewController.title = [localNotification.userInfo objectForKey:@"StopName"];
        [navigationController pushViewController:arrivalTimeTableViewController animated:YES];
        
        application.applicationIconBadgeNumber = localNotification.applicationIconBadgeNumber - 1;
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navigationController = (UINavigationController *)[tabBarController.viewControllers objectAtIndex:0];
    
    VVArrivalTimeTableViewController *arrivalTimeTableViewController = [[VVArrivalTimeTableViewController alloc] init];
    arrivalTimeTableViewController.title = [notification.userInfo objectForKey:@"StopName"];
    [navigationController pushViewController:arrivalTimeTableViewController animated:YES];
    
    application.applicationIconBadgeNumber = notification.applicationIconBadgeNumber-1;
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
