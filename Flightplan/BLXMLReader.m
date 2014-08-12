//
//  BLXMLReader.m
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLXMLReader.h"

@implementation BLXMLElement
- (id)init
{
    self = [super init];
    if (self)
    {
        self.value = [[NSMutableArray alloc] init];
    }
    return self;
}
@end


@interface BLXMLReader ()
@property (strong, nonatomic) NSMutableString *textInProgress;
@property (strong, nonatomic) NSError *errorPointer;
@property (strong, nonatomic) NSXMLParser *parser;

@property (strong, nonatomic) BLXMLElement *root;
@property (strong, nonatomic) NSMutableArray *elementStack;

@end

@implementation BLXMLReader

- (id)init
{
    self = [super init];
    if (self)
    {
        self.textInProgress = [[NSMutableString alloc] init];
        self.root = [[BLXMLElement alloc] init];
        self.elementStack = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parseWithURL:(NSURL *)url completionHandler:(void (^)(BLXMLElement *root, NSError *error)) completionHandler
{
    self.url = url;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        [self.parser setDelegate:self];
        [self.parser parse];
        completionHandler(self.root, self.errorPointer);
    });
}

- (id)nodeValueWithKeyPath:(NSString *)keyPath
{
    return [BLXMLReader nodeValueWithKeyPath:keyPath inElement:self.root];
}

+ (id)nodeValueWithKeyPath:(NSString *)keyPath inElement:(BLXMLElement *)root
{
    NSArray *keys = [keyPath componentsSeparatedByString:@"."];
    NSMutableArray *elements = [NSMutableArray arrayWithObject:root];
    NSInteger keyIndex = 0;
    while (keyIndex < [keys count])
    {
        NSString *key = [keys objectAtIndex:keyIndex];
        NSMutableArray *childElements = [NSMutableArray array];
        NSInteger elementIndex = 0;
        while (elementIndex < [elements count])
        {
            id object = [elements objectAtIndex:elementIndex];
            if ([object isKindOfClass:[BLXMLElement class]])
            {
                BLXMLElement *element = (BLXMLElement *) object;
                if ([element.name isEqualToString:key])
                {
                    if ([element.value isKindOfClass:[NSMutableArray class]])
                    {
                        [childElements addObjectsFromArray:element.value];
                    }
                    else
                    {
                        [childElements addObject:element.value];
                    }
                }
            }
            elementIndex++;
        }
        elements = childElements;
        keyIndex++;
    }

    switch ([elements count]) {
        case 0:
            return nil;
        case 1:
            return [elements objectAtIndex:0];
        default:
            return [NSArray arrayWithArray:elements];
    }
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    BLXMLElement *childElement;
    if ([self.elementStack count] > 0)
    {
        childElement = [[BLXMLElement alloc] init];
        BLXMLElement *parentElement = [self.elementStack lastObject];
        [parentElement.value addObject:childElement];
    }
    else
    {
        childElement = self.root;
    }
    
    childElement.name = elementName;
    childElement.attributes = attributeDict;
    
    [self.elementStack addObject:childElement];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    BLXMLElement *elementInProgress = [self.elementStack lastObject];
    
    if ([elementInProgress.value count] == 0)
    {
        elementInProgress.value = [NSString stringWithString:self.textInProgress];
    }
    
    [self.elementStack removeLastObject];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.textInProgress setString:string];
    [self.textInProgress replaceOccurrencesOfString:@"^[ \t\n]*$"
                                         withString:@""
                                            options:NSRegularExpressionSearch
                                              range:NSMakeRange(0, [self.textInProgress length])];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    self.errorPointer = parseError;
}

@end
