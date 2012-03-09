//
//  CircleShapeBuilder.m
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CoockieBuilder.h"
#import "Coockie.h"
#import "GameContext.h"


@implementation CoockieBuilder
@synthesize coockie;


-(id) initWithSpriteFileName:(NSString*)_filename andLayer:(CCLayer*)_layer {
	
	if ( ( self = [super initWithSpriteFileName:_filename andLayer:_layer] ) ) {
		filename = [_filename retain];
		space   = [[GameContext sharedInstance]getSpace];
		layer   = _layer;
	}
	
	return self;
}

-(void) buildShape {
	
	self.coockie = [Coockie spriteWithFile:filename andGame:layer];
    if ( self.coockie )
        [layer addChild:self.coockie z:10 tag:91];

}

-(Coockie*) getResult {
	
	return coockie;
}


-(void) dealloc {
	[filename release];
	[coockie release];
	[super dealloc];

}

@end
