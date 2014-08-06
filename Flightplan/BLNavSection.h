//
//  BLNavSection.h
//  Flightplan
//
//  Created by William Chen on 8/6/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLNavItem.h"

@interface BLNavSection : NSObject

@property (strong, nonatomic) NSString *header;
@property (strong, nonatomic) NSString *footer;
@property (strong, nonatomic) NSMutableArray *items;
- (BLNavItem *)itemAtIndex:(NSInteger)index;
@end
