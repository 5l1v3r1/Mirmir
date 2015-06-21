#import "Lamo.h"
#import "CDTLamo.h"
#import "CDTLamoWindow.h"
#import "CDTLamoPanGestureRecognizer.h"

@interface CDTLamoBarView : UIView

- (void)setTitle:(NSString *)title;
- (void)handleClose;
- (void)handleMin;
- (void)handleMax;
- (void)handleOrientation;

@end