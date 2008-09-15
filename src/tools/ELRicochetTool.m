//
//  ELRicochetTool.m
//  Elysium
//
//  Created by Matt Mower on 09/08/2008.
//  Copyright 2008 LucidMac Software. All rights reserved.
//

#import "ELRicochetTool.h"

#import "ELHex.h"
#import "ELPlayhead.h"

@implementation ELRicochetTool

- (id)initWithDirectionKnob:(ELIntegerKnob *)_directionKnob_ {
  if( ( self = [super initWithType:@"ricochet"] ) ) {
    directionKnob = _directionKnob_;
  }
  
  return self;
}

- (id)init {
  if( ( self = [super initWithType:@"ricochet"] ) ) {
    directionKnob = [[ELIntegerKnob alloc] initWithName:@"direction" integerValue:N];
  }

  return self;
}

@synthesize directionKnob;

- (NSArray *)observableValues {
  NSMutableArray *keys = [[NSMutableArray alloc] init];
  [keys addObjectsFromArray:[super observableValues]];
  [keys addObjectsFromArray:[NSArray arrayWithObjects:@"directionKnob.value",nil]];
  return keys;
}

// Tool runner

- (BOOL)run:(ELPlayhead *)_playhead_ {
  if( [super run:_playhead_] ) {
    [_playhead_ setDirection:[directionKnob value]];
    return YES;
  } else {
    return NO;
  }
}

// Drawing

- (void)drawWithAttributes:(NSDictionary *)_attributes_ {
  [[self hex] drawTriangleInDirection:[directionKnob value] withAttributes:_attributes_];
}

// NSMutableCopying protocol

- (id)mutableCopyWithZone:(NSZone *)_zone_ {
  return [[[self class] allocWithZone:_zone_] initWithDirectionKnob:[directionKnob mutableCopy]];
}

// Implement the ELXmlData protocol

- (NSXMLElement *)xmlRepresentation {
  NSXMLElement *ricochetElement = [NSXMLNode elementWithName:@"ricochet"];
  
  NSXMLElement *controlsElement = [NSXMLNode elementWithName:@"controls"];
  [ricochetElement addChild:controlsElement];
  
  return ricochetElement;
}

- (id)initWithXmlRepresentation:(NSXMLElement *)_representation_ {
  return nil;
}

@end
