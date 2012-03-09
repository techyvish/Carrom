//
//  Coockie.m
//  CrazyBall
//
//  Created by Vishal Patel on 16/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//
#import "Striker.h"
#import "GameContext.h"
#import "MessagingSystem.h"

static inline cpBool
cpvroundeql(const cpVect v1, const cpVect v2)
{
	return ((int)v1.x == (int)v2.x && (int)v1.y == (int)v2.y);
}

@implementation Striker


static BOOL strikerStopped;


@synthesize shape;
@synthesize velocity ;

+(id) spriteWithFile:(NSString*)filename andGame:(CCLayer*)game{
	
	return [[[self alloc]initWithFile:filename andGame:game]autorelease];
}

-(id) initWithFile:(NSString *)filename andGame:(CCLayer*)game {
	
	if ( (self = [super initWithFile:filename]) ) {
		
		shape = cpCircleShapeNew(cpBodyNew(60.0, INFINITY), 12.0, cpvzero);
		shape->e = 0.45; // Elasticity
		shape->u = 0.10; // Friction --> high to let physics handle the collision properly.
		shape->data =  self ;// Associate with out ball's UIImageView
		shape->collision_type = 2 ; // kCollisionTypeCoockie Collisions are grouped by types
		shape->group = 5;
		_game = game;
		
		cpSpace* space = [[GameContext sharedInstance] getSpace];

		cpSpaceAddBody (space, shape->body);
		cpSpaceAddShape(space, shape);
		
		strikerStopped = cpTrue;
	}
	
	return self;
}

-(void) addAtPosition:(cpVect)posVect {
	shape->body->p = posVect ;
}

-(void) setAtPosition:(cpVect)posVect {
	shape->body->p = posVect;
}

-(void) killCoockie {
	
	id call = [CCCallFunc actionWithTarget:self selector:@selector(removeCoockie)];
	[self runAction:[CCSequence actions:call,nil]];
}

-(void) removeCoockie {
	[_game removeChild:self cleanup:YES];
}

-(void) observePosition {
	
	[self addObserver:self forKeyPath:@"position" options:NSKeyValueObservingOptionNew context:nil];

}

-(void) stopObservingPosition {

	[self removeObserver:self forKeyPath:@"position"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"position"])
	{		
		if ( cpvlength(shape->body->v) >= 0.500000 ) {
			strikerStopped = cpFalse;			
		}
		else {
			strikerStopped = cpTrue;
			AMSendMessage(@"STRIKER_RESET",nil);
			[self stopObservingPosition];
		}
	}
}

-(BOOL) isStrikerStopped {

	return strikerStopped;
}
	 
-(void) resetStrikerAnimate {

	CGSize wins = [[CCDirector sharedDirector] winSize];
	
	shape->body->p =  cpv( 110.0 , wins.height / 2.0 );
	id blink = [CCBlink actionWithDuration:1 blinks:1]; 
	[self runAction:blink];

	
}

-(cpFloat)velocity {
	CCLOG(@"velocity called");
	return cpvlength(shape->body->v);
}

-(void) scaleUp {
	
	id scaleup  = [CCScaleTo actionWithDuration:0.2 scale:3.0];
	[self runAction: scaleup];
	
}
-(void) scaleDown {
    id scaledown = [CCScaleTo actionWithDuration:0.05 scale:1.0];
   [self runAction: scaledown];
}

-(void) scaleXup:(int)x  {
    
    id scaley = [CCScaleTo actionWithDuration:0.0  scaleX:1.0 scaleY:x];
    [self runAction:scaley];
}
@end

