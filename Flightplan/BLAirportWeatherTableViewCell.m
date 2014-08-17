//
//  BLAirportWeatherTableViewCell.m
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLAirportWeatherTableViewCell.h"
#import "BLXMLReader.h"

@interface BLAirportWeatherTableViewCell () <NSURLConnectionDataDelegate>
@property (strong, nonatomic) NSString *metarString;
@property (strong, nonatomic) NSMutableDictionary *receivedDataDictionary;
@end

@implementation BLAirportWeatherTableViewCell

- (void)awakeFromNib
{
}

- (void)setAirportIdentifier:(NSString *)airportIdentifier
{
    _airportIdentifier = airportIdentifier;
    
    NSString *urlString = [BLUtils configForKey:@"WeatherXMLURL"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    if (!self.receivedDataDictionary)
    {
        self.receivedDataDictionary = [NSMutableDictionary dictionary];
    }
    // self.title and self.metar
    
}

+ (CGFloat) height
{
    return 100.0f;
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Received data: %@", data);
    NSString *key = [connection description];
    NSMutableData *receivedData = [self.receivedDataDictionary objectForKey:key];
    if (!receivedData)
    {
        receivedData = [[NSMutableData alloc] init];
        [self.receivedDataDictionary setObject:receivedData forKey:key];
    }
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *key = [connection description];
    NSData *data = [NSData dataWithData:[self.receivedDataDictionary objectForKey:key]];
    NSDictionary *xml = [BLXMLReader dictionaryFromXMLData:data error:nil];
    NSArray *metarInfo = [xml valueForKeyPath:@"response.data.METAR"];
    [self.metar setText:[[metarInfo objectAtIndex:0] valueForKeyPath:@"raw_text.text"]];
    [self.receivedDataDictionary removeObjectForKey:key];
}

@end
