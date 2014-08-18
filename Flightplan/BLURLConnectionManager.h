//
//  BLURLConnectionManager.h
//  Flightplan
//
//  Created by William Chen on 8/17/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

@interface BLURLConnectionManager : NSObject
- (void) setConnection:(NSURLConnection *)connection asType:(NSInteger)type;
- (NSMutableData *)dataWithConnection:(NSURLConnection *)connection;
- (NSInteger)typeWithConnection:(NSURLConnection *)connection;
- (void) removeConnection:(NSURLConnection *)connection;
@end
