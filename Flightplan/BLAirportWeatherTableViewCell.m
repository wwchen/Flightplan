//
//  BLAirportWeatherTableViewCell.m
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLAirportWeatherTableViewCell.h"
#import "BLXMLReader.h"

@interface BLAirportWeatherTableViewCell ()
@property (strong, nonatomic) NSString *metarString;
@end

@implementation BLAirportWeatherTableViewCell

- (void)awakeFromNib
{
}

- (void)setAirportIdentifier:(NSString *)airportIdentifier
{
    _airportIdentifier = airportIdentifier;
    
    NSString *urlString = [BLUtils configForKey:@"WeatherXMLURL"];
    BLXMLReader *xmlReader = [[BLXMLReader alloc] init];
    [xmlReader parseWithURL:[NSURL URLWithString:urlString] completionHandler:^(BLXMLElement *root, NSError *error) {
        id response = [xmlReader nodeValueWithKeyPath:@"response.data.METAR.raw_text"];
        if ([response isKindOfClass:[NSArray class]])
        {
            [self.metar setText:[response objectAtIndex:0]];
        }
        else
        {
            [self.metar setText:response];
        }
    }];
    
}

+ (CGFloat) height
{
    return 100.0f;
}

@end
