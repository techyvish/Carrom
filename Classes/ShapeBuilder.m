//
//  ShapeBuilder.m
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShapeBuilder.h"


@implementation ShapeBuilder


-(id) initWithSpriteFileName:(NSString*)filename andLayer:(CCLayer*)_layer {

	
	if ( (self = [super init] ) ) {
		
		wins = [[CCDirector sharedDirector]winSize];
	}
	
	return self;
	
}


-(void)addIntoLayer:(CCLayer*) layer withSpace:(cpSpace*)space {

}


-(void) buildShape {
}


@end
