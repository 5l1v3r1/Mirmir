#import "CDTLamoBarView.h"

@implementation CDTLamoBarView

- (id)init {

	if (self = [super init]) {

		//create the bar
		[self setFrame:CGRectMake(0, 0, kScreenWidth, 40)];
		[self setBackgroundColor:[UIColor grayColor]];
		[self setAlpha:0.9];
		[self setUserInteractionEnabled:YES];

		//setup gestures
		//add pangesture to make it movable
		CDTLamoPanGestureRecognizer *panTrack = [[CDTLamoPanGestureRecognizer alloc] initWithTarget:[CDTLamo sharedInstance] action:@selector(handlePan:)];
		[self addGestureRecognizer:panTrack];

		UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[closeButton setFrame:CGRectMake(5, 5, 30, 30)];
#if TARGET_IPHONE_SIMULATOR
		[closeButton setImage:[UIImage imageWithContentsOfFile:@"/Users/ethanarbuckle/Desktop/_lamo/layout/Library/Application Support/Lamo/close.png"] forState:UIControlStateNormal];
#else
		[closeButton setImage:[UIImage imageWithContentsOfFile:@"/Library/Application Support/Lamo/close.png"] forState:UIControlStateNormal];
#endif	
		[closeButton setAlpha:.7];
		[closeButton addTarget:self action:@selector(handleClose) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:closeButton];

		UIButton *minButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[minButton setFrame:CGRectMake(40, 5, 30, 30)];
#if TARGET_IPHONE_SIMULATOR
		[minButton setImage:[UIImage imageWithContentsOfFile:@"/Users/ethanarbuckle/Desktop/_lamo/layout/Library/Application Support/Lamo/min.png"] forState:UIControlStateNormal];
#else
		[minButton setImage:[UIImage imageWithContentsOfFile:@"/Library/Application Support/Lamo/min.png"] forState:UIControlStateNormal];
#endif	
		[minButton setAlpha:.7];
		[minButton addTarget:self action:@selector(handleMin) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:minButton];

		UIButton *maxButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[maxButton setFrame:CGRectMake(75, 5, 30, 30)];
#if TARGET_IPHONE_SIMULATOR
		[maxButton setImage:[UIImage imageWithContentsOfFile:@"/Users/ethanarbuckle/Desktop/_lamo/layout/Library/Application Support/Lamo/full.png"] forState:UIControlStateNormal];
#else
		[maxButton setImage:[UIImage imageWithContentsOfFile:@"/Library/Application Support/Lamo/full.png"] forState:UIControlStateNormal];
#endif
		[maxButton setAlpha:.7];
		[maxButton addTarget:self action:@selector(handleMax) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:maxButton];

		UIButton *orientButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[orientButton setFrame:CGRectMake(kScreenWidth - 35, 5, 30, 30)];
#if TARGET_IPHONE_SIMULATOR
		[orientButton setImage:[UIImage imageWithContentsOfFile:@"/Users/ethanarbuckle/Desktop/_lamo/layout/Library/Application Support/Lamo/min.png"] forState:UIControlStateNormal];
#else
		[orientButton setImage:[UIImage imageWithContentsOfFile:@"/Library/Application Support/Lamo/min.png"] forState:UIControlStateNormal];
#endif	
		[orientButton setAlpha:.7];
		[orientButton addTarget:self action:@selector(handleOrientation) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:orientButton];
        
        //define area pan is allowed, and wont confict with buttons
        _panBounds = CGPointMake([maxButton frame].origin.x + 35, [orientButton frame].origin.x - 5);
        NSLog(@"CC: %@", NSStringFromCGPoint(_panBounds));
	}

	return self;
}

- (void)handleClose {

	//close window
	[[CDTLamo sharedInstance] unwindowApplicationWithBundleID:[(CDTLamoWindow *)[self superview] identifier]];

}

- (void)handleMin {

	//animate scale back to .6
	[UIView animateWithDuration:0.3f animations:^{

		[[self superview] setTransform:CGAffineTransformMakeScale(.6, .6)];
        
        //set frame to ensure window bar isnt out of screen bounds
        CGRect appWindowFrame = [[self superview] frame];
        
        if (appWindowFrame.origin.y <= 0) {
            
            //off of screen, bounce it back
            appWindowFrame.origin.y = 5;
        }
        
        if (appWindowFrame.origin.x <= 0) {
            
            //bounce this back too
            appWindowFrame.origin.x = 5;
        }
        
        [[self superview] setFrame:appWindowFrame];


	}];

}

- (void)handleMax {

	//get sbapp
	SBApplication *app = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:[(CDTLamoWindow *)[self superview] identifier]];

	//launch it fullscreen
	[[CDTLamo sharedInstance] launchFullModeFromWindowForApplication:app];

}

- (void)handleOrientation {

	//get app
	SBApplication *app = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:[(CDTLamoWindow *)[self superview] identifier]];

	//trigger portrait opposite of current one
    if ([(CDTLamoWindow *)[self superview] activeOrientation] == (UIInterfaceOrientation *)UIInterfaceOrientationLandscapeLeft) {
        
        //in landscape, trigger portrait
        [(CDTLamoWindow *)[self superview] setActiveOrientation:(UIInterfaceOrientation *)UIInterfaceOrientationPortrait];
        [[CDTLamo sharedInstance] triggerPortraitForApplication:app];
        
    }
    else {
        
        //in portrait, trigger landscape
        [(CDTLamoWindow *)[self superview] setActiveOrientation:(UIInterfaceOrientation *)UIInterfaceOrientationLandscapeLeft];
        [[CDTLamo sharedInstance] triggerLandscapeForApplication:app];
        
    }
	
}

@end