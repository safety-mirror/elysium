//
//  Elysium.h
//  Elysium
//
//  Created by Matt Mower on 20/07/2008.
//  Copyright 2008 Matthew Mower.
//  See MIT-LICENSE for more information.
//

#import <CoreAudio/CoreAudio.h>

#import "String+AsJavascriptFunction.h"

#import "NSXML+Helpers.h"
#import "NSString+ELHelpers.h"

#import "ELPreferences.h"
#import "ELNotifications.h"

// Type to represent compass directions (for a cell)
typedef enum tagDirection {
  N = 0,
  NE,
  SE,
  S,
  SW,
  NW
  } Direction;

#define INVERSE_DIRECTION( direction ) ((direction + 3) % 6)

#define ASSERT_VALID_DIRECTION( d ) NSAssert1( d>=0 && d<=5, @"Invalid direction %d specified", d )

// Define the size of the Harmonic Table
#define HTABLE_COLS 17
#define HTABLE_ROWS 12

// To make calculations a little easier
#define HTABLE_SIZE (HTABLE_COLS * HTABLE_ROWS)
#define HTABLE_MAX_COL (HTABLE_COLS - 1)
#define HTABLE_MAX_ROW (HTABLE_ROWS - 1)

// Calculate an offset into a linear array representing a
// lattice of cells where columns are stacked end to end
#define COL_ROW_OFFSET(col,row) ((col * HTABLE_ROWS) + row)

// Our error domain
extern NSString * const ELErrorDomain;

#define EL_ERR_DOCUMENT_LOAD_FAILURE      0x0000
#define EL_ERR_DOCUMENT_INVALID_ROOT      0x0001
#define EL_ERR_DOCUMENT_INVALID_VERSION   0x0002
#define EL_ERR_PLAYER_LOAD_FAILURE        0x0100
#define EL_ERR_LAYER_MISSING_ID           0x0200
#define EL_ERR_LAYER_CELL_REF_INVALID     0x0201
#define EL_ERR_CELL_INVALID_ATTR          0x0300
#define EL_ERR_OSCILLATOR_INVALID_ATTR    0x0500
#define EL_ERR_KNOB_MISSING_VALUE         0x0700

#import "ELXmlData.h"
#import "ELTaggable.h"

#import "ELDial.h"
