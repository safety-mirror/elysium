//
//  ELFilterDesignerController.h
//  Elysium
//
//  Created by Matt Mower on 23/09/2008.
//  Copyright 2008 LucidMac Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ELKnob;
@class ELSquareFilter;
@class ELSawFilter;
@class ELSineFilter;
@class ELListFilter;
@class ELRandomFilter;

@interface ELFilterDesignerController : NSWindowController {
  IBOutlet NSTabView  *tabView;

  ELKnob              *knob;
  ELSquareFilter      *squareFilter;
  ELSawFilter         *sawFilter;
  ELSineFilter        *sineFilter;
  ELListFilter        *listFilter;
  ELRandomFilter      *randomFilter;
  
  NSString            *selectedTag;
}

- (id)initWithKnob:(ELKnob *)knob;

@property (readonly) ELKnob *knob;

@property (readonly) ELSquareFilter *squareFilter;
@property (readonly) ELSawFilter *sawFilter;
@property (readonly) ELSineFilter *sineFilter;
@property (readonly) ELListFilter *listFilter;
@property (readonly) ELRandomFilter *randomFilter;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end
