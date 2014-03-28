//
//  VVStopToRouteDictionary.h
//  Vandy Vans
//
//  Created by Seth Friedman on 3/27/14.
//  Copyright (c) 2014 VandyApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVStopToRouteDictionary : NSObject

+ (NSArray *)routesForStopName:(NSString *)stopName;

@end
