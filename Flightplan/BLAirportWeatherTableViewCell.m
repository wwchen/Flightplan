//
//  BLAirportWeatherTableViewCell.m
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLAirportWeatherTableViewCell.h"
#import "BLURLConnectionManager.h"
#import "BLXMLReader.h"

typedef NS_ENUM(NSInteger, BLURLConnectionType)
{
    BLURLConnectionMETARType,
    BLURLConnectionTAFType,
};


#pragma mark -

@interface BLAirportWeatherTableViewCell () <NSURLConnectionDataDelegate>
@property (strong, nonatomic) NSString *metarString;
@property (strong, nonatomic) BLURLConnectionManager *manager;
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
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    self.manager = [[BLURLConnectionManager alloc] init];
    [self.manager setConnection:connection asType:BLURLConnectionMETARType];
    // self.title and self.metar
    
}

+ (CGFloat) height
{
    return 100.0f;
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [[self.manager dataWithConnection:connection] appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSMutableData *data = [self.manager dataWithConnection:connection];
    switch ([self.manager typeWithConnection:connection]) {
        case BLURLConnectionMETARType:
        {
            NSDictionary *xml = [BLXMLReader dictionaryFromXMLData:data error:nil];
            NSInteger resultCount = [[xml valueForKeyPath:@"response.data.num_results"] integerValue];
            if (resultCount > 0)
            {
                NSDictionary *metarInfo = [[xml valueForKeyPath:@"response.data.METAR"] objectAtIndex:0];
                [self.metar setText:[metarInfo valueForKeyPath:@"raw_text.text"]];
                [self.title setText:[metarInfo valueForKeyPath:@"station_id.text"]];
                id skyConditions = [metarInfo valueForKeyPath:@"sky_condition"];
                if ([skyConditions isKindOfClass:[NSArray class]] && [skyConditions count] > 0)
                {
                    NSMutableString *skyConditionString = [NSMutableString string];
                    for (int i = 0; i < [skyConditions count]; i++)
                    {
                        NSDictionary *skyConditionInfo = [skyConditions objectAtIndex:i];
                        NSString *infoString = [NSString stringWithFormat:@"%@: %@", [skyConditionInfo objectForKey:@"sky_cover"],
                                                                                     [skyConditionInfo objectForKey:@"cloud_base_ft_agl"]];
                        [skyConditionString appendString:infoString];
                    }
                    [self.skyCondition setText:skyConditionString];
                }
                else
                {
                    NSString *infoString = [NSString stringWithFormat:@"%@: %@", [skyConditions objectForKey:@"sky_cover"],
                                                                                 [skyConditions objectForKey:@"cloud_base_ft_agl"]];
                    [self.skyCondition setText:infoString];
                }
            }
            break;
        }
        default:
            break;
    }
    
    [self.manager removeConnection:connection];
}

@end
