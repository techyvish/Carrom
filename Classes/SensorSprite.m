//
//  SensorSprite.m
//  CrazyBall
//
//  Created by Vishal Patel on 3/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SensorSprite.h"


@implementation SensorSprite


-(id) init {
	
	if ( ( self = [super init] ) ) {
	
	}
	return self;

}

-(int) getSensorPosition {

	return sensorPosition;
	
}


-(void) setSensorPosition:(int)position  {
	
	sensorPosition = position;
	
}


@end
