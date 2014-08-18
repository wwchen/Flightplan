//
//  BLAirportWeatherTableViewCell.h
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLTableViewCell.h"

@interface BLAirportWeatherTableViewCell : BLTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
//@property (strong, nonatomic) IBOutlet UIImage *status;
@property (strong, nonatomic) IBOutlet UILabel *metar;
@property (strong, nonatomic) IBOutlet UILabel *taf;
@property (strong, nonatomic) IBOutlet UILabel *skyCondition;
@property (strong, nonatomic) NSString *airportIdentifier;
@property (strong, nonatomic) id dataSource;
+ (CGFloat) height;
@end
