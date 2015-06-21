//
//  CDTLamoAppOverlay.h
//  Lamo
//
//  Created by Ethan Arbuckle on 6/21/15.
//  Copyright © 2015 CortexDevTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lamo.h"
#import "CDTLamoBarView.h"

@interface CDTLamoAppOverlay : UIView

- (id)initWithOrientation:(UIInterfaceOrientation *)orientation;

- (void)handleClose;
- (void)handleMin;
- (void)handleMax;
- (void)handleOrientation;

@end