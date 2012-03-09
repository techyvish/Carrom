//
//  GameContext.m
//  CrazyBall
//
//  Created by Vishal Patel on 16/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameContext.h"
#import "cpShapeDebugNode.h"


int printVector(NSString* string,cpVect vector) {
	
	CCLOG(@" %@ X: %f , Y: %f ",string,vector.x,vector.y);
	return 0;
}


static GameContext* instance = nil;
@implementation GameContext

+(id) sharedInstance {
	if ( instance == nil )
		instance = [[GameContext alloc] init];
	return instance;
}

-(cpSpace*) getSpace {
	if ( space == nil )
		space = cpSpaceNew();
	return space;
}

@end
