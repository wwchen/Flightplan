//
//  BLWeatherViewController.m
//  Flightplan
//
//  Created by William Chen on 8/19/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLWeatherViewController.h"
#import "BLURLConnectionManager.h"
#import "BLXMLReader.h"

typedef NS_ENUM(NSInteger, BLWeatherMETARInfoType)
{
    BLWeatherMETARInfoRawText,
    BLWeatherMETARInfoStationID,
    BLWeatherMETARInfoObservationTime,
    BLWeatherMETARInfoLatitude,
    BLWeatherMETARInfoLongitude,
    BLWeatherMETARInfoTemperature,
    BLWeatherMETARInfoDewPoint,
    BLWeatherMETARInfoWindDirection,
    BLWeatherMETARInfoWindSpeed,
    BLWeatherMETARInfoVisibility,
    BLWeatherMETARInfoAltimeter,
    BLWeatherMETARInfoPressureAltitude,
    BLWeatherMETARInfoFlightCategory,
    BLWeatherMETARInfoElevation,
    BLWeatherMETARInfo,
};

typedef NS_ENUM(NSInteger, BLURLConnectionType)
{
    BLURLConnectionMETARType,
    BLURLConnectionTAFType,
};

const NSString *BLkWeatherCellValueType = @"BLkWeatherCellValueType";
const NSString *BLkWeatherCellValue = @"BLkWeatherCellValue";


@interface BLWeatherViewController () <UITableViewDataSource, NSXMLParserDelegate>
@property (strong, nonatomic) BLURLConnectionManager *manager;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation BLWeatherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    // Not using XIB, so overloading
    [super loadView];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height) style:UITableViewStyleGrouped];
    [self.tableView setDataSource:self];
    [scrollView addSubview:self.tableView];
    [self.view addSubview:scrollView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *urlString = [BLUtils configForKey:@"WeatherXMLURL"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    self.manager = [[BLURLConnectionManager alloc] init];
    [self.manager setConnection:connection asType:BLURLConnectionMETARType];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"BLWeatherCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier];
    }
    NSDictionary *cellInfo = [self.dataSource objectAtIndex:indexPath.row];
    NSString *labelString;
    BLWeatherMETARInfoType valueType = [[cellInfo objectForKey:BLkWeatherCellValueType] integerValue];
    switch (valueType)
    {
        case BLWeatherMETARInfoRawText:
            labelString = @"METAR"; break;
        case BLWeatherMETARInfoStationID:
            labelString = @"Station"; break;
        case BLWeatherMETARInfoObservationTime:
            labelString = @"Time"; break;
        case BLWeatherMETARInfoLatitude:
            labelString = @"Latitude"; break;
        case BLWeatherMETARInfoLongitude:
            labelString = @"Longitude"; break;
        case BLWeatherMETARInfoTemperature:
            labelString = @"Temp (C)"; break;
        case BLWeatherMETARInfoDewPoint:
            labelString = @"Dew point (C)"; break;
        case BLWeatherMETARInfoWindDirection:
            labelString = @"Wind direction"; break;
        case BLWeatherMETARInfoWindSpeed:
            labelString = @"Wind speed"; break;
        case BLWeatherMETARInfoVisibility:
            labelString = @"Visibility"; break;
        case BLWeatherMETARInfoAltimeter:
            labelString = @"Altitude"; break;
        case BLWeatherMETARInfoPressureAltitude:
            labelString = @"Pressure altitude"; break;
        case BLWeatherMETARInfoFlightCategory:
            labelString = @"Category"; break;
        case BLWeatherMETARInfoElevation:
            labelString = @"Elevation"; break;
        default:
            break;
    }
    [cell.textLabel setText:labelString];
    [cell.textLabel setNumberOfLines:0];
    [cell.detailTextLabel setText:[cellInfo objectForKey:BLkWeatherCellValue]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [[self.manager dataWithConnection:connection] appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSMutableData *data = [self.manager dataWithConnection:connection];
    if (!self.dataSource)
    {
        self.dataSource = [NSMutableArray array];
    }
    switch ([self.manager typeWithConnection:connection]) {
        case BLURLConnectionMETARType:
        {
            NSDictionary *xml = [BLXMLReader dictionaryFromXMLData:data error:nil];
            NSInteger resultCount = [[xml valueForKeyPath:@"response.data.num_results"] integerValue];
            if (resultCount > 0)
            {
                NSDictionary *metarInfo = [[xml valueForKeyPath:@"response.data.METAR"] objectAtIndex:0];
                NSNumber *valueType = [NSNumber numberWithInt:BLWeatherMETARInfoRawText];
                NSString *value = [metarInfo valueForKeyPath:@"raw_text.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }
                
                valueType = [NSNumber numberWithInt:BLWeatherMETARInfoObservationTime];
                value = [metarInfo valueForKeyPath:@"observation_time.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }

                valueType = [NSNumber numberWithInt:BLWeatherMETARInfoLatitude];
                value = [metarInfo valueForKeyPath:@"latitude.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }

                valueType = [NSNumber numberWithInt:BLWeatherMETARInfoLongitude];
                value = [metarInfo valueForKeyPath:@"longitude.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }

                valueType = [NSNumber numberWithInt:BLWeatherMETARInfoTemperature];
                value = [metarInfo valueForKeyPath:@"temp_c.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }

                valueType = [NSNumber numberWithInt:BLWeatherMETARInfoDewPoint];
                value = [metarInfo valueForKeyPath:@"dewpoint_c.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }

                valueType = [NSNumber numberWithInt:BLWeatherMETARInfoWindSpeed];
                value = [metarInfo valueForKeyPath:@"wind_speed_kt.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }

                valueType = [NSNumber numberWithInt:BLWeatherMETARInfoWindDirection];
                value = [metarInfo valueForKeyPath:@"wind_dir_degree.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }

                valueType = [NSNumber numberWithInt:BLWeatherMETARInfoVisibility];
                value = [metarInfo valueForKeyPath:@"visibility_statute_mi.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }

                valueType = [NSNumber numberWithInt:BLWeatherMETARInfoAltimeter];
                value = [metarInfo valueForKeyPath:@"altim_in_hg.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }

                valueType = [NSNumber numberWithInt:BLWeatherMETARInfoPressureAltitude];
                value = [metarInfo valueForKeyPath:@"sea_level_pressure_mb.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }

                valueType = [NSNumber numberWithInt:BLWeatherMETARInfoFlightCategory];
                value = [metarInfo valueForKeyPath:@"flight_category.text"];
                if (value)
                {
                    [self.dataSource addObject:@{BLkWeatherCellValueType: valueType, BLkWeatherCellValue: value}];
                }
                                             /*
                id skyConditions = [metarInfo valueForKeyPath:@"sky_condition"];
                if ([skyConditions isKindOfClass:[NSArray class]])
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
                                              */
            }
            break;
        }
        default:
            break;
    }
    
    [self.tableView reloadData];
    [self.manager removeConnection:connection];
}

@end
