//
//  ELOscillator.m
//  Elysium
//
//  Created by Matt Mower on 08/09/2008.
//  Copyright 2008 LucidMac Software. All rights reserved.
//

#import <CoreAudio/CoreAudio.h>

#import "ELOscillator.h"
#import "ELSquareOscillator.h"
#import "ELSawOscillator.h"
#import "ELSineOscillator.h"

@implementation ELOscillator

- (id)initEnabled:(BOOL)_enabled_ {
  if( ( self = [super init] ) ) {
    [self setEnabled:_enabled_];
  }
  
  return self;
}

@synthesize enabled;

- (NSString *)type {
  return @"oscillator";
}

- (float)generate {
  @throw [NSException exceptionWithName:@"OscillatorException"
                                 reason:@"Oscillator#generate should never be called"
                               userInfo:[NSDictionary dictionaryWithObject:self forKey:@"oscillator"]];
}

// Implement the ELXmlData protocol

- (NSXMLElement *)xmlRepresentation {
  NSXMLElement *oscillatorElement = [NSXMLNode elementWithName:@"oscillator"];
  
  NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
  [oscillatorElement setAttributesAsDictionary:attributes];
  
  return oscillatorElement;
}

- (id)initWithXmlRepresentation:(NSXMLElement *)_representation_ parent:(id)_parent_ player:(ELPlayer *)_player_ {
  NSXMLNode *attributeNode = [_representation_ attributeForName:@"type"];
  Class oscillatorClass = NSClassFromString( [NSString stringWithFormat:@"EL%@Oscillator", [attributeNode stringValue]] );
  return [[oscillatorClass alloc] initWithXmlRepresentation:_representation_ parent:_parent_ player:_player_];
}

@end