//
//  Striker2.m
//  CrazyBall
//
//  Created by Vishal Patel on 22/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Striker2.h"
#import "HelloWorldScene.h"


@implementation Striker2

+(id) bombWithGame:(Carrom*)game
{
	return [[[self alloc] initWithGame:game] autorelease];
}

+(id) bombWithGame:(Carrom*)game shape:(cpShape*)shape
{
	return [[[self alloc] initWithGame:game shape:shape] autorelease];	
}

-(id) initWithGame:(Carrom*)game
{
	cpShape *shape = [game.spaceManager addCircleAt:cpvzero mass:STATIC_MASS radius:26];
	return [self initWithGame:game shape:shape];
}

-(id) initWithGame:(Carrom*)game shape:(cpShape*)shape;
{
	[super initWithShape:shape file:@"Striker.png"];
	
	_game = game;
	_countDown = NO;
	
	//Free the shape when we are released
	self.spaceManager = game.spaceManager;
	self.autoFreeShape = YES;
	
	//Handle collisions
	shape->collision_type = 1;
	
	return self;
}


@end
