//
//  BuildDirector.m
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShapeBuildDirector.h"

@implementation ShapeBuildDirector



-(id) initWithShapeBuilder: (ShapeBuilder*) _builder {
	
	if ( ( self = [super init] ) ) {
	
		builder = _builder;
		
	}
	return self;

}

-(void) dealloc {

	[super dealloc];
}


-(void) buildShape {
	
	[builder buildShape];
}

@end
