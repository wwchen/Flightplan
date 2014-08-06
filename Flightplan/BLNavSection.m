//
//  BLNavSection.m
//  Flightplan
//
//  Created by William Chen on 8/6/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLNavSection.h"

@implementation BLNavSection

- (id)init
{
    self = [super init];
    if (self)
    {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (BLNavItem *)itemAtIndex:(NSInteger)index
{
    if (index > [self.items count])
    {
        return nil;
    }
    return [self.items objectAtIndex:index];
}
@end
