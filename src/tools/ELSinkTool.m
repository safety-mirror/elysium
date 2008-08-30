//
//  ELSinkTool.m
//  Elysium
//
//  Created by Matt Mower on 09/08/2008.
//  Copyright 2008 LucidMac Software. All rights reserved.
//

#import "ELSinkTool.h"

#import "ELHex.h"
#import "ELPlayhead.h"

@implementation ELSinkTool

+ (ELSinkTool *)new {
  return [[ELSinkTool alloc] init];
}

- (id)init {
  if( self = [super initWithType:@"sink"] ) {
    // NOP
  }
  
  return self;
}

- (BOOL)run:(ELPlayhead *)_playhead {
  if( [super run:_playhead] ) {
    [_playhead setPosition:nil];
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
  [[_attributes_ objectForKey:ELToolColor] set];
  symbolPath = [NSBezierPath bezierPathWithRect:NSMakeRect( centre.x - radius / 4, centre.y - radius / 4, radius / 2, radius / 2 )];
  [symbolPath setLineWidth:2.0];
  [symbolPath stroke];
}

@end