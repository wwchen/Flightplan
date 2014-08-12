//
//  BLUtils.m
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLUtils.h"

@implementation BLUtils
+ (id) dataForUrl:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLCacheStorageAllowedInMemoryOnly
                                                            timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if ([response statusCode] != 200)
    {
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[response statusCode]);
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *) configForKey:(NSString *)keyPath
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"BLConfig" ofType:@"plist"];
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return [config valueForKeyPath:keyPath];
}

@end
