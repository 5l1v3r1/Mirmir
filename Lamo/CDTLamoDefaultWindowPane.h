//
//  CDTLamoDefaultWindowPane.h
//  Lamo
//
//  Created by Ethan Arbuckle on 6/26/15.
//  Copyright © 2015 CortexDevTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lamo.h"
#import "CDTLamoWindow.h"
#import "CDTContextHostProvider.h"

@class CDTLamoWindow;

@interface CDTLamoDefaultWindowPane : UITableViewController

@property (nonatomic, retain) CDTLamoWindow *previewWindow;

- (void)handleSliderChanged:(UISlider *)slider;

@end
