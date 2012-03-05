//
//  EssentialsAppDelegate.m
//  Essentials
//
//  Created by Steffen Itterheim on 14.07.10.
//  Copyright Steffen Itterheim 2010. All rights reserved.
//

#import "EssentialsAppDelegate.h"
#import "cocos2d.h"
#import "HelloWorldScene.h"

@implementation EssentialsAppDelegate

@synthesize window;

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// this is the necessary Cocoa Touch part
	// a cocoa touch window is created and setup, later cocos2d's OpenGL is attached to this window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window setUserInteractionEnabled:YES];
	[window setMultipleTouchEnabled:YES];

	// cocos2d supports four types of update methods:
	// the default is the DisplayLinkDirector which uses Apple's CADisplayLink class internally
	// but is only available on iOS 3.1 and above, hence the fallback to the default CCTimerDirector (NSTimer based)
	// the other two Directors are FastDirector, which was the preferred choice before DisplayLink became available
	// and the ThreadedFastDirector, which is the preferred choice if you want to use Cocoa Touch UIKit objects
	// alongside with cocos2d
	if ( ! [CCDirector setDirectorType:CCDirectorTypeDisplayLink] )
	{
		// choose the NSTimer based Director
		[CCDirector setDirectorType:CCDirectorTypeDefault];
	}

	// the pixel format determines color depth, alpha and memory used by the screen
	// in general you want to use RGBA8888 which will give you 32-bit colors and full alpha
	// but this mode consumes the most memory and performance, in some cases RGB565 may be preferable
	// RGB565 doesn't give you alpha and only 16 bit colors but consumes less memory and performance
	[[CCDirector sharedDirector] setPixelFormat:kPixelFormatRGBA8888];

	// If you change the Pixel Format of the screen you should also use the same pixel format for Textures.
	// But you can also later change this setting for each individual texture as needed.
	[CCTexture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGBA8888];
	
	// a depth buffer is only needed if you use 3D objects with cocos2d, or certain effects
	// for example you'll see better results (less flickering) in the PageTurn3D transition/action
	// when you're using a 16 or 24 bit depth buffer
	// Of course depth buffer consumes memory and memory is precious, so don't enable a depth buffer unless you need it.
	[[CCDirector sharedDirector] setDepthBufferFormat:kCCDepthBufferNone];
	
	// Device Orientation determines in which corner the 0,0 coordinate is located, and in turn it determines
	// in what orientation objects are drawn on screen. Generally you have Landscape (sideways) and Portrait (upright)
	// modes and both come with an alternative mode which is simply rotated by 180 degrees.
	[[CCDirector sharedDirector] setDeviceOrientation:CCDeviceOrientationLandscapeLeft];
	
	// the animationInterval is just the inverse of the framerate, meaning how much time will pass
	// before the next frame is drawn
	double framerate = 60;
	[[CCDirector sharedDirector] setAnimationInterval: 1.0 / framerate];
	
	// if you want to see a framerate counter displayed in the lower left corner, set this to YES
	[[CCDirector sharedDirector] setDisplayFPS:YES];
	
	// this method creates cocos2d's OpenGL view and attaches it to the Cocoa Touch window
	[[CCDirector sharedDirector] attachInView:window];
	
	// the Cocoa Touch window is made visible and becomes the first responder for input
	[window makeKeyAndVisible];

	// Uncomment the next line to seed the randomizer with the current time.
	// Otherwise the CCRANDOM methods return the same sequence of numbers each time the App is started.
	// Try running the App a few times with and without the call to srandom and see how the colors change.
	/*
	srandom(time(NULL));
	 */

	// cocos2d is now fully initialized and it's time to run our first scene (the familiar HelloWorldScene)
	// NOTE: the runWithScene method is only ever used here
	// if you want to change scenes later you'll have to use the replaceScene method instead
	[[CCDirector sharedDirector] runWithScene:[HelloWorld scene]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[[CCDirector sharedDirector] end];
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
