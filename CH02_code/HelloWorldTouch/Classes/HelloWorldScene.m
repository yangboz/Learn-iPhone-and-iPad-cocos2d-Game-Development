//
//  HelloWorldLayer.m
//  HelloWorld
//
//  Created by Steffen Itterheim on 27.06.10.
//  Copyright Steffen Itterheim 2010. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"

// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if ((self = [super init])) {
		
		// create and initialize a Label
		CCLabel* label = [CCLabel labelWithString:@"Hello Touch!" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];

		// your label needs a tag so we can find it later on
		// you can pick any arbitrary number
		label.tag = 13;
		
		// must be enabled if you want to receive touch events!
		self.isTouchEnabled = YES;
	}
	return self;
}

-(void) ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;
{
	// get the label by its tag - CCLabel is of course derived from CCNode
	CCNode* node = [self getChildByTag:13];

	// defensive programming: verify the returned node is a CCLabel class object
	NSAssert([node isKindOfClass:[CCLabel class]], @"node is not a CCLabel!");
	
	// only after asserting that node is of class CCLabel we should cast it to (CCLabel*)
	CCLabel* label = (CCLabel*)node;
	
	// change the label's scale randomly
	label.scale = CCRANDOM_0_1();
}

// on "dealloc" you need to release all your retained objects
-(void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
