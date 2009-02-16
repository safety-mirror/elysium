//
//  ELSpinToken.h
//  Elysium
//
//  Created by Matt Mower on 09/08/2008.
//  Copyright 2008 Matthew Mower.
//  See MIT-LICENSE for more information.
//

#import <Cocoa/Cocoa.h>

#import "Elysium.h"

#import "ELToken.h"

@interface ELSpinToken : ELToken {
  ELDial *clockwiseDial;
  ELDial *steppingDial;
}

- (id)initWithClockwiseDial:(ELDial *)clockwiseDial steppingDial:(ELDial *)steppingDial;

@property ELDial *clockwiseDial;
@property ELDial *steppingDial;

@end
