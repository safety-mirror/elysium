//
//  ELSinkTool.m
//  Elysium
//
//  Created by Matt Mower on 09/08/2008.
//  Copyright 2008 LucidMac Software. All rights reserved.
//

#import "ELAbsorbTool.h"

#import "ELHex.h"
#import "ELPlayhead.h"

static NSString * const toolType = @"absorb";

@implementation ELAbsorbTool

- (NSString *)toolType {
  return toolType;
}

- (BOOL)run:(ELPlayhead *)_playhead {
  if( [super run:_playhead] && ![_playhead isNew] ) {
    [_playhead kill];
    return YES;
  } else {
    return NO;
  }
}

// Drawing

- (void)drawWithAttributes:(NSDictionary *)_attributes_ {
  NSPoint centre = [[self hex] centre];
  float radius = [[self hex] radius];
  
  NSBezierPath *symbolPath;
  [[_attributes_ objectForKey:ELDefaultToolColor] set];
  symbolPath = [NSBezierPath bezierPathWithRect:NSMakeRect( centre.x - radius/3, centre.y - radius/3, 2*radius/3, 2*radius/3 )];
  [symbolPath setLineWidth:2.0];
  [symbolPath stroke];
}

// NSMutableCopying protocol

- (id)mutableCopyWithZone:(NSZone *)_zone_ {
  return [[[self class] allocWithZone:_zone_] init];
}

// Implement the ELXmlData protocol

- (NSXMLElement *)xmlRepresentation {
  NSXMLElement *sinkElement = [NSXMLNode elementWithName:toolType];
  
  NSXMLElement *controlsElement = [NSXMLNode elementWithName:@"controls"];
  [sinkElement addChild:controlsElement];
  
  return sinkElement;
}

- (id)initWithXmlRepresentation:(NSXMLElement *)_representation_ parent:(id)_parent_ {
  return [self init];
}

@end
