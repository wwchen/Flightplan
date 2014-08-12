//
//  BLUtils.h
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

@interface BLUtils : NSObject
+ (id) dataForUrl:(NSString *)urlString;
+ (NSString *) configForKey:(NSString *)keyPath;
@end
