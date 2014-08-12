//
//  BLAirportWeatherTableViewCell.h
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

@interface BLAirportWeatherTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) id dataSource;
- (id)initWithICAO:(NSString *)icao;
+ (CGFloat) height;
@end
