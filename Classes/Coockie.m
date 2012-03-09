//
//  Coockie.m
//  CrazyBall
//
//  Created by Vishal Patel on 16/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Coockie.h"
#import "GameContext.h"

@implementation Coockie

@synthesize shape;

+(id) spriteWithFile:(NSString*)filename andGame:(CCLayer*)game{
	
	return [[[self alloc]initWithFile:filename andGame:game]autorelease];
}

-(id) initWithFile:(NSString *)filename andGame:(CCLayer*)game {
	
	if ( (self = [super initWithFile:filename]) ) {
		
		shape = cpCircleShapeNew(cpBodyNew(40.0, INFINITY), 10.0, cpvzero);
		shape->e = 0.4; // Elasticity
		shape->u = 0.10; // Friction --> high to let physics handle the collision properly.
		shape->data =  self ;// Associate with out ball's UIImageView
		shape->collision_type = 3 ; // kCollisionTypeCoockie Collisions are grouped by types
		
		_game = game;
		
		cpSpace* space = [[GameContext sharedInstance] getSpace];
		//cpSpace* space = cpSpaceNew();
		cpSpaceAddBody(space, shape->body);
		cpSpaceAddShape(space, shape);
	}
	
	return self;
}

-(void) addAtPosition:(cpVect)posVect {
	shape->body->p = posVect ;// cpv( wins.width / 2.0 , wins.height / 2.0 + 60	);
}

-(void) setAtPosition:(cpVect)posVect {
	shape->body->p = posVect;
}

-(void) setCookieFlipAngle:(cpFloat)angle {
	cpFloat originalAngle =  CC_RADIANS_TO_DEGREES(angle);
	flipAngle = CC_DEGREES_TO_RADIANS( originalAngle + 90 );
}

-(void) killCoockie {
		
	id rotate = [CCRotateTo actionWithDuration:0 angle:flipAngle];
	id s = [CCMoveTo actionWithDuration:0.2 position: getSensorPosition(sensorHitPosition)];
	id firstAction = [CCOrbitCamera actionWithDuration:0.2 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:25 angleX:0 deltaAngleX:0];
	id scaleAction = [CCScaleTo actionWithDuration:0.2 scale:0.8];
	id skew = [CCSpawn actions:s,firstAction,scaleAction,nil];
	
	id secondAction = [CCReverseTime actionWithAction:firstAction];
	
	//id secondAction = [CCOrbitCamera actionWithDuration:5 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:-45 angleX:0 deltaAngleX:0];

	//id q = [CCScaleTo actionWithDuration:0.3 scale:0.4];
	//id c = [CCCallFunc actionWithTarget:self selector:@selector(removeCoockie)];
	[self runAction:[CCSequence actions:rotate,skew,secondAction,nil]];
}

-(void) removeCoockie {
	[_game removeChild:self cleanup:YES];
}


-(void) setSensorHitPosietion:(int)position {
	sensorHitPosition = position;
}
@end
