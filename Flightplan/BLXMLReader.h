//
//  BLXMLReader.h
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

extern NSString *const BLkXMLReaderTextNodeKey;

// This class parses XML into dictionary.
@interface BLXMLReader : NSObject <NSXMLParserDelegate>

+ (NSDictionary *) dictionaryFromXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *) dictionaryFromXMLString:(NSString *)string error:(NSError **)errorPointer;

@end
