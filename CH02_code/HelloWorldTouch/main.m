//
//  main.m
//  HelloWorld
//
//  Created by Steffen Itterheim on 27.06.10.
//  Copyright Steffen Itterheim 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	int retVal = UIApplicationMain(argc, argv, nil, @"HelloWorldAppDelegate");
	[pool release];
	return retVal;
}
