//
//  ELDial.m
//  Elysium
//
//  Created by Matt Mower on 31/01/2009.
//  Copyright 2009 LucidMac Software. All rights reserved.
//

#import "limits.h"

#import "ELDial.h"

@implementation ELDial

+ (void)initialize {
  [self exposeBinding:@"mode"];
  [self exposeBinding:@"name"];
  [self exposeBinding:@"tag"];
  [self exposeBinding:@"parent"];
  [self exposeBinding:@"oscillator"];
  [self exposeBinding:@"assigned"];
  [self exposeBinding:@"value"];
  [self exposeBinding:@"min"];
  [self exposeBinding:@"max"];
  [self exposeBinding:@"step"];
}

- (id)initWithMode:(ELDialMode)mode
              name:(NSString *)name
               tag:(int)tag
            parent:(ELDial *)parent
        oscillator:(ELOscillator *)oscillator
          assigned:(int)assigned
              last:(int)last
             value:(int)value
{
  return [self initWithMode:mode
                       name:name
                        tag:tag
                     parent:parent
                 oscillator:oscillator
                   assigned:assigned
                       last:last
                      value:value
                        min:0
                        max:1
                       step:1];
}


- (id)initWithMode:(ELDialMode)mode
              name:(NSString *)name
               tag:(int)tag
            parent:(ELDial *)parent
        oscillator:(ELOscillator *)oscillator
          assigned:(int)assigned
              last:(int)last
             value:(int)value
               min:(int)min
               max:(int)max
              step:(int)step
{
  if( ( self = [super init] ) ) {
    [self setName:name];
    [self setTag:tag];
    [self setParent:parent];
    [self setOscillator:oscillator];
    [self setAssigned:assigned];
    [self setLast:last];
    [self setDisplayed:value];
    [self setMin:min];
    [self setMax:max];
    [self setStep:step];
    
    // Mode is set last to ensure that parent/oscillator
    // are setup before attempting to switch mode
    [self setMode:mode];
  }
  
  return self;
}

@dynamic mode;

- (ELDialMode)mode {
  return mode;
}

- (void)setMode:(ELDialMode)newMode {
  if( newMode != mode ) {
    switch( newMode ) {
      case dialFree:
        [self unbind:@"value"];
        [self bind:@"value" toObject:self withKeyPath:@"assigned" options:nil];
        break;
        
      case dialDynamic:
        if( oscillator ) {
          [self unbind:@"value"];
          // Note that we expect all current oscillators to have generated a new value
          // at the start of each beat of their layer
          [self bind:@"value" toObject:oscillator withKeyPath:@"value" options:nil];
          mode = newMode;
        }
        break;
      
      case dialInherited:
        if( parent ) {
          [self unbind:@"value"];
          [self bind:@"value" toObject:parent withKeyPath:@"value" options:nil];
          mode = newMode;
        }
        break;
    }
  }
}

@synthesize name;
@synthesize tag;
@synthesize parent;
@synthesize oscillator;
@synthesize assigned;
@synthesize last;
@synthesize value;
@synthesize value;
@synthesize min;
@synthesize max;
@synthesize step;

#pragma mark ELXmlData implementation

- (NSXMLElement *)xmlRepresentation {
  NSXMLElement *dialElement = [NSXMLNode elementWithName:@"dial"];

  NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
  [attributes setObject:[[NSNumber numberWithInteger:mode] stringValue] forKey:@"mode"];
  [attributes setObject:name forKey:@"name"];
  [attributes setObject:[NSNumber numberWithInteger:tag] forKey:@"tag"];
  
  [attributes setObject:[NSNumber numberWithInteger:tag] forKey:@"assigned"];
  [attributes setObject:[NSNumber numberWithInteger:tag] forKey:@"last"];
  [attributes setObject:[NSNumber numberWithInteger:tag] forKey:@"value"];
  [attributes setObject:[NSNumber numberWithInteger:tag] forKey:@"min"];
  [attributes setObject:[NSNumber numberWithInteger:tag] forKey:@"max"];
  [attributes setObject:[NSNumber numberWithInteger:tag] forKey:@"step"];
  [dialElement setAttributesAsDictionary:attributes];
  if( oscillator ) {
    [dialbElement addChild:[oscillator xmlRepresentation]];
  }
  
  return dialElement;
}

- (id)initWithXmlRepresentation:(NSXMLElement *)_representation_ parent:(id)_parent_ player:(ELPlayer *)_player_ error:(NSError **)_error_ {
  if( ( self = [self init] ) ) {
    NSArray *nodes;
    NSXMLElement *element;
    NSXMLNode *attrNode;
    
    [self setMode:[_representation_ attributeAsInteger:@"mode" defaultValue:dialFree]];
    [self setName:[_representation_ attributeAsString:@"name"]];
    [self setTag:[_representation_ attributeAsInteger:@"tag" defaultValue:INT_MIN]];
    
    [self setAssigned:[_representation_ attributeAsInteger:@"assigned" defaultValue:INT_MIN]];
    [self setLast:[_representation_ attributeAsInteger:@"last" defaultValue:INT_MIN]];
    [self setValue:[_representation_ attributeAsInteger:@"value" defaultValue:INT_MIN]];
    
    [self setMin:[_representation_ attributeAsInteger:@"min" defaultValue:INT_MIN]];
    [self setMax:[_representation_ attributeAsInteger:@"max" defaultValue:INT_MIN]];
    [self setStep:[_representation_ attributeAsInteger:@"step" defaultValue:INT_MIN]];
    
    [self setParent:_parent_];
    
    // Decode oscillator
    NSXMLElement *oscillatorElement = [[_representation_ nodesForXPath:@"oscillator"] firstXmlElement];
    if( oscillatorElement ) {
      [self setOscillator:[ELOscillator loadFromXml:oscillatorElement parent:self player:_player_ error:_error_]]
    }
  }
  
  return self;
}

@end
