//
//  BLTableViewCell.h
//  Flightplan
//
//  Created by William Chen on 8/13/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

@interface BLTableViewCell : UITableViewCell
+ (NSString *)reuseIdentifer;
+ (NSString *)nibName;
+ (CGFloat) height; // overridden by subclass
@end
