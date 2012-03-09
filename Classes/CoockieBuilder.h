//
//  CircleShapeBuilder.h
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShapeBuilder.h"

// Concreate shape builder class

@class Coockie;
@interface CoockieBuilder :  ShapeBuilder {
	
	cpSpace		*space;
	CCLayer		*layer;
	Coockie		*coockie;
	NSString	*filename;
}

@property (nonatomic,retain) Coockie		*coockie;

-(id)	initWithSpriteFileName:(NSString*)filename andLayer:(CCLayer*)_layer ;
-(void) buildShape;
-(Coockie*) getResult;


@end
