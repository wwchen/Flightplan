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
        self.name = nil;
        self.attributes = [[NSDictionary alloc] init];
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

- (id)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self)
    {
        self.parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        [self.parser setDelegate:self];
        self.textInProgress = [[NSMutableString alloc] init];
        
    }
    return self;
}

- (id)nodeValueWithKeyPath:(NSString *)keyPath
{
    if (!self.root)
    {
        self.root = [[BLXMLElement alloc] init];
        self.elementStack = [[NSMutableArray alloc] init];
        
        [self.parser parse];
    }
    NSArray *keys = [keyPath componentsSeparatedByString:@"."];
    
    NSMutableArray *elements = [NSMutableArray arrayWithObject:self.root];
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

    if ([elements count] > 1)
    {
        return [NSArray arrayWithArray:elements];
    }
    return [elements objectAtIndex:0];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // Create the child dictionary for the new element, and initilaize it with the attributes
    BLXMLElement *childElement;
    if ([self.elementStack count] > 0)
    {
        childElement = [[BLXMLElement alloc] init];
    }
    else
    {
        childElement = self.root;
    }
    
    childElement.name = elementName;
    childElement.attributes = attributeDict;
    
    if ([self.elementStack count] > 0)
    {
        BLXMLElement *parentElement = [self.elementStack lastObject];
        [parentElement.value addObject:childElement];
    }
    
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
