//
//  BLURLConnectionManager.m
//  Flightplan
//
//  Created by William Chen on 8/17/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLURLConnectionManager.h"

const NSString *BLkURLConnectionType = @"BLURLConnectionType";
const NSString *BLkURLConnectionData = @"BLURLConnectionData";

@interface BLURLConnectionManager ()
@property (strong, nonatomic) NSMutableDictionary *manager;
@property (strong, nonatomic) NSString *description;
@end

@implementation BLURLConnectionManager
- (void) setConnection:(NSURLConnection *)connection asType:(NSInteger)type
{
    if (!self.manager)
    {
        self.manager = [NSMutableDictionary dictionary];
    }
    NSDictionary *entry = @{BLkURLConnectionType: [NSNumber numberWithInteger:type],
                            BLkURLConnectionData: [NSMutableData data]};
    [self.manager setObject:entry forKey:[connection description]];
}
- (NSData *)dataWithConnection:(NSURLConnection *)connection
{
    NSDictionary *entry = [self.manager objectForKey:[connection description]];
    return [entry objectForKey:BLkURLConnectionData];
}

- (NSInteger)typeWithConnection:(NSURLConnection *)connection
{
    NSDictionary *entry = [self.manager objectForKey:[connection description]];
    return [[entry objectForKey:BLkURLConnectionType] integerValue];
}

- (void) removeConnection:(NSURLConnection *)connection
{
    [self.manager removeObjectForKey:[connection description]];
}


@end
