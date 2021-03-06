//
//  ParallaxBackground.m
//  ScrollingWithJoy
//
//  Created by Steffen Itterheim on 11.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "ParallaxBackground.h"


@implementation ParallaxBackground

-(id) init
{
	if ((self = [super init]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
		// Get the game's texture atlas texture by adding it. Since it's added already it will simply return 
		// the CCTexture2D associated with the texture atlas.
		CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"game-art.png"];
		
		// Create the background spritebatch
		spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
		[self addChild:spriteBatch];

		numStripes = 7;
		
		// Add the 7 different stripes and position them on the screen
		for (int i = 0; i < numStripes; i++)
		{
			NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
			CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
			sprite.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
			[spriteBatch addChild:sprite z:i tag:i];
		}

		// Add 7 more stripes, flip them and position them next to their neighbor stripe
		for (int i = 0; i < numStripes; i++)
		{
			NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
			CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
			
			// Position the new sprite one screen width to the right
			sprite.position = CGPointMake(screenSize.width / 2 + screenSize.width, screenSize.height / 2);

			// Flip the sprite so that it aligns perfectly with its neighbor
			sprite.flipX = YES;
			
			// Add the sprite using the same tag offset by numStripes
			[spriteBatch addChild:sprite z:i tag:i + numStripes];
		}
		
		// Initialize the array that contains the scroll factors for individual stripes.
		speedFactors = [[CCArray alloc] initWithCapacity:numStripes];
		[speedFactors addObject:[NSNumber numberWithFloat:0.3f]];
		[speedFactors addObject:[NSNumber numberWithFloat:0.5f]];
		[speedFactors addObject:[NSNumber numberWithFloat:0.5f]];
		[speedFactors addObject:[NSNumber numberWithFloat:0.8f]];
		[speedFactors addObject:[NSNumber numberWithFloat:0.8f]];
		[speedFactors addObject:[NSNumber numberWithFloat:1.2f]];
		[speedFactors addObject:[NSNumber numberWithFloat:1.2f]];
		NSAssert([speedFactors count] == numStripes, @"speedFactors count does not match numStripes!");

		scrollSpeed = 1.0f;
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) dealloc
{
	[speedFactors release];
	[super dealloc];
}

-(void) update:(ccTime)delta
{
	CCSprite* sprite;
	CCARRAY_FOREACH([spriteBatch children], sprite)
	{
		NSNumber* factor = [speedFactors objectAtIndex:sprite.zOrder];
		
		CGPoint pos = sprite.position;
		pos.x -= scrollSpeed * [factor floatValue];
		sprite.position = pos;
	}
}

@end
