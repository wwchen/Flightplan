//
//  BLXMLReader.h
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

@interface BLXMLElement : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDictionary *attributes;
@property (strong, nonatomic) id value;
@end

@interface BLXMLReader : NSObject <NSXMLParserDelegate>
@property (strong, nonatomic, readonly) NSDictionary *xmlDictionary;
- (id)initWithURL:(NSURL *)url;
- (id)nodeValueWithKeyPath:(NSString *)keyPath;
@end
