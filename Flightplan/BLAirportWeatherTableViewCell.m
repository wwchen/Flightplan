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
@property (strong, nonatomic) NSMutableData *requestData;
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
    if (!self.requestData)
    {
        self.requestData = [[NSMutableData alloc] init];
    }
    [self.requestData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    NSDictionary *xml = [BLXMLReader dictionaryFromXMLData:self.requestData error:&error];
    NSArray *metarInfo = [xml valueForKeyPath:@"response.data.METAR"];
    [self.metar setText:[[metarInfo objectAtIndex:0] valueForKeyPath:@"raw_text.text"]];
}

@end
