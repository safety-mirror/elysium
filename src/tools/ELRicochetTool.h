//
//  ELRicochetTool.h
//  Elysium
//
//  Created by Matt Mower on 09/08/2008.
//  Copyright 2008 LucidMac Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "Elysium.h"

#import "ELTool.h"

@interface ELRicochetTool : ELTool {
}

- (id)initWithDirection:(Direction)direction;

@property Direction direction;

@end