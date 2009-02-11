//
//  ELNoteInspectorViewController.m
//  Elysium
//
//  Created by Matt Mower on 09/02/2009.
//  Copyright 2009 LucidMac Software. All rights reserved.
//

#import "ELNoteInspectorViewController.h"

#import "ELInspectorController.h"

@implementation ELNoteInspectorViewController

- (id)initWithInspectorController:(ELInspectorController *)controller {
  return [super initWithInspectorController:controller
                                    nibName:@"ELNoteInspectorPane"
                                     target:controller
                                       path:@"cell.tokens.note"];
}

- (void)awakeFromNib {
  [self bindControl:@"enabled"];
  
  [self bindControl:@"p"];
  [self bindMode:@"p"];
  [self bindOsc:@"p"];
  
  [self bindControl:@"gate"];
  [self bindMode:@"gate"];
  [self bindOsc:@"gate"];
  
  [self bindControl:@"velocity"];
  [self bindMode:@"velocity"];
  [self bindOsc:@"velocity"];
  
  [self bindControl:@"emphasis"];
  [self bindMode:@"emphasis"];
  [self bindOsc:@"emphasis"];
  
  [self bindControl:@"tempoSync"];
  
  [self bindControl:@"noteLength"];
  [self bindMode:@"noteLength"];
  [self bindOsc:@"noteLength"];
  
  [self bindControl:@"ghosts"];
  [self bindMode:@"ghosts"];
  [self bindOsc:@"ghosts"];
  
  [self bindControl:@"override"];
  
  [self bindOverrideControls];
  
  [self bindScript:@"willRun"];
  [self bindScript:@"didRun"];
}

- (void)bindOverrideControls {
  [channelOverrideSelectControl bind:@"enabled" toObject:[self objectController] withKeyPath:@"selection.overrideDial.value" options:nil];
  for( int i = 0; i < 16; i++ ) {
    [channelOverrideSelectControl bind:[NSString stringWithFormat:@"segment%dselected",i]
                              toObject:[self objectController]
                           withKeyPath:[NSString stringWithFormat:@"selection.channelSends.%d.value",i]
                               options:nil];
  }
}

@end
