//
//  ELSpinToken.m
//  Elysium
//
//  Created by Matt Mower on 09/08/2008.
//  Copyright 2008 Matthew Mower.
//  See MIT-LICENSE for more information.
//

#import "ELSpinToken.h"

#import "ELHex.h"
#import "ELPlayer.h"
#import "ELPlayhead.h"
#import "ELGenerateToken.h"
#import "ELReboundToken.h"

@implementation ELSpinToken

+ (NSString *)tokenType {
  return @"spin";
}

- (id)initWithClockwiseDial:(ELDial *)newClockwiseDial steppingDial:(ELDial *)newSteppingDial {
  if( ( self = [super init] ) ) {
    [self setClockwiseDial:newClockwiseDial];
    [self setSteppingDial:newSteppingDial];
  }
  
  return self;
}

- (id)init {
  return [self initWithClockwiseDial:[ELPlayer defaultClockWiseDial]
                        steppingDial:[ELPlayer defaultSteppingDial]];
}

@dynamic clockwiseDial;

- (ELDial *)clockwiseDial {
  return clockwiseDial;
}

- (void)setClockwiseDial:(ELDial *)newClockwiseDial {
  clockwiseDial = newClockwiseDial;
  [clockwiseDial setDelegate:self];
}

@dynamic steppingDial;

- (ELDial *)steppingDial {
  return steppingDial;
}

- (void)setSteppingDial:(ELDial *)newSteppingDial {
  steppingDial = newSteppingDial;
  [steppingDial setDelegate:self];
}

- (void)start {
  [super start];
  
  [clockwiseDial start];
  [steppingDial start];
}

- (void)stop {
  [super stop];
  
  [clockwiseDial stop];
  [steppingDial stop];
}

// What happens when a playhead arrives

- (void)runToken:(ELPlayhead *)_playhead_ {
  ELToken<DirectedToken> *token;
  
  if( [[_playhead_ position] reboundToken] ) {
    token = [[_playhead_ position] reboundToken];
  } else if( [[_playhead_ position] generateToken] ) {
    token = [[_playhead_ position] generateToken];
  } else {
    token = nil;
  }
  
  if( [clockwiseDial value] ) {
    [[token directionDial] setValue:(([[token directionDial] value]+[steppingDial value]) % 6)];
  } else {
    [[token directionDial] setValue:(([[token directionDial] value]-[steppingDial value]) % 6)];
  }
}

// Drawing

- (void)drawWithAttributes:(NSDictionary *)_attributes_ {
  NSPoint centre = [[self hex] centre];
  float radius = [[self hex] radius];
  
  [self setTokenDrawColor:_attributes_];
  
  NSBezierPath *symbolPath = [NSBezierPath bezierPath];
  
  if( [clockwiseDial value] ) {
    [symbolPath moveToPoint:NSMakePoint( centre.x - radius/3 - radius/10, centre.y - radius/8 )];
    [symbolPath lineToPoint:NSMakePoint( centre.x - radius/3, centre.y + radius/8 )];
    [symbolPath lineToPoint:NSMakePoint( centre.x - radius/3 + radius/10, centre.y - radius/8 )];
    
    [symbolPath moveToPoint:NSMakePoint( centre.x + radius/3 - radius/10, centre.y + radius/8 )];
    [symbolPath lineToPoint:NSMakePoint( centre.x + radius/3, centre.y - radius/8 )];
    [symbolPath lineToPoint:NSMakePoint( centre.x + radius/3 + radius/10, centre.y + radius/8 )];
  } else {
    [symbolPath moveToPoint:NSMakePoint( centre.x - radius/3 - radius/10, centre.y + radius/8 )];
    [symbolPath lineToPoint:NSMakePoint( centre.x - radius/3, centre.y - radius/8 )];
    [symbolPath lineToPoint:NSMakePoint( centre.x - radius/3 + radius/10, centre.y + radius/8 )];
    
    [symbolPath moveToPoint:NSMakePoint( centre.x + radius/3 - radius/10, centre.y - radius/8 )];
    [symbolPath lineToPoint:NSMakePoint( centre.x + radius/3, centre.y + radius/8 )];
    [symbolPath lineToPoint:NSMakePoint( centre.x + radius/3 + radius/10, centre.y - radius/8 )];
  }
  
  [symbolPath setLineWidth:2.0];
  [symbolPath stroke];
}

// NSMutableCopying protocol

- (id)mutableCopyWithZone:(NSZone *)_zone_ {
  id copy = [super mutableCopyWithZone:_zone_];
  [copy setClockwiseDial:[[self clockwiseDial] mutableCopy]];
  [copy setSteppingDial:[[self steppingDial] mutableCopy]];
  return copy;
}

// Implement the ELXmlData protocol

- (NSXMLElement *)controlsXmlRepresentation {
  NSXMLElement *controlsElement = [super controlsXmlRepresentation];
  [controlsElement addChild:[clockwiseDial xmlRepresentation]];
  [controlsElement addChild:[steppingDial xmlRepresentation]];
  return controlsElement;
}

- (id)initWithXmlRepresentation:(NSXMLElement *)_representation_ parent:(id)_parent_ player:(ELPlayer *)_player_ error:(NSError **)_error_ {
  if( ( self = [super initWithXmlRepresentation:_representation_ parent:_parent_ player:_player_ error:_error_] ) ) {
    [self setClockwiseDial:[_representation_ loadDial:@"clockwise" parent:nil player:_player_ error:_error_]];
    [self setSteppingDial:[_representation_ loadDial:@"stepping" parent:nil player:_player_ error:_error_]];
  }
  
  return self;
}

@end
