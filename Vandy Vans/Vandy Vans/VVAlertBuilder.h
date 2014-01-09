//
//  VVAlertBuilder.h
//  Vandy Vans
//
//  Created by Seth Friedman on 3/13/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVAlertBuilder : NSObject

+ (NSString *)vanArrivingAlertMessageWithRouteName:(NSString *)routeName andStopName:(NSString *)stopName;

+ (UIAlertView *)vanArrivingAlertWithRouteName:(NSString *)routeName andStopName:(NSString *)stopName;

+ (UIAlertView *)reminderSetAlertWithRouteName:(NSString *)routeName andStopName:(NSString *)stopName;

+ (UIAlertView *)reminderAlreadyExistsAlertForStopName:(NSString *)stopName newStopName:(NSString *)newStopName delegate:(id)delegate;

+ (UIAlertView *)vansNotRunningAlertWithDelegate:(id)delegate;

+ (UIAlertView *)noArrivalPredictionsAlertWithDelegate:(id)delegate;

@end
