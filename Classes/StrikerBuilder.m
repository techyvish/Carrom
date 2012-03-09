//
//  StrikerBuilder.m
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StrikerBuilder.h"
#import "GameContext.h"
#import "Striker.h"


void physicsBodyUpdateVelocity(cpBody *body, cpVect gravity, cpFloat damping, cpFloat dt) {
	
	cpFloat v_limit, v_mag;
	cpBodyUpdateVelocity(body, gravity, damping, dt);
	// v_limit is really set from body->data. This is to keep it simple.   
	v_limit = 65.0f;
	v_mag = cpvlength(body->v);
	
	CCLOG(@"valo length : %d",cpvlength(body->v));
	
	if(v_mag > v_limit) {
		
		float v_scale = v_limit / v_mag;
		body->v = cpvmult(body->v, v_scale < 0.99 ? 0.99 : v_scale);
	}
}

@implementation StrikerBuilder
@synthesize striker;

-(id) initWithSpriteFileName:(NSString*)filename andLayer:(CCLayer*)_layer {
	
	if ( ( self = [super initWithSpriteFileName:filename andLayer:_layer] ) ) {
		
		self.striker = [Striker spriteWithFile:filename andGame:_layer];
		space   = [[GameContext sharedInstance]getSpace];
		layer   = _layer;
	}
	
	return self;
}

-(void) buildShape {
	[layer addChild:self.striker z:10 tag:91];
	[striker addAtPosition: cpv( 110.0 , wins.height / 2.0 	)];
}

-(Striker*) getResult {
	
	return striker;
}

-(void) dealloc {
	
	[striker release];
	[super dealloc];
	
}

@end
