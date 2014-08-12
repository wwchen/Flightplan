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
        NSURL *url = [[NSURL alloc] initWithString:@"https://aviationweather.gov/adds/dataserver_current/httpparam?dataSource=metars&requestType=retrieve&format=xml&stationString=KPAE&hoursBeforeNow=1"];
        BLXMLReader *xmlReader = [[BLXMLReader alloc] initWithURL:url];
        NSString *metar = [xmlReader nodeValueWithKeyPath:@"response.data.METAR.raw_text"];
        [self.label setText:metar];
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
