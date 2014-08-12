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
@property (strong, nonatomic) NSURL *url;
- (void)parseWithURL:(NSURL *)url completionHandler:(void (^)(BLXMLElement *root, NSError *error)) completionHandler;
- (id)nodeValueWithKeyPath:(NSString *)keyPath;
+ (id)nodeValueWithKeyPath:(NSString *)keyPath inElement:(BLXMLElement *)root;
@end
