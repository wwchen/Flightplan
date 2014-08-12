//
//  BLAirportWeatherTableViewCell.m
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLAirportWeatherTableViewCell.h"
#import "BLXMLReader.h"

@implementation BLAirportWeatherTableViewCell

- (id)init
{
    self = [super init];
    if (self)
    {
        self.label = [[UILabel alloc] init];
    }
    return self;
}

- (id)initWithICAO:(NSString *)icao
{
    self = [self init];
    if (self)
    {
        NSString *urlString = [BLUtils configForKey:@"WeatherXMLURL"];
        BLXMLReader *xmlReader = [[BLXMLReader alloc] init];
        [xmlReader parseWithURL:[NSURL URLWithString:urlString] completionHandler:^(BLXMLElement *root, NSError *error) {
            NSString *metar = [xmlReader nodeValueWithKeyPath:@"response.data.METAR.raw_text"];
            [self.label setText:metar];
        }];
    }
    return self;
}

- (NSDictionary *)metarInformationFromXML:(NSDictionary *)xml
{
    return xml;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = self.frame;
    [self addSubview:self.label];
}

+ (CGFloat) height
{
    return 100.0f;
}

@end
