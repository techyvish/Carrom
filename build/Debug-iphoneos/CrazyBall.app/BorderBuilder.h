//
//  BorderBuilder.h
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShapeBuilder.h"

@interface BorderBuilder : ShapeBuilder {

	cpSpace		*space;
	CCLayer		*layer;

}

-(void) addIntoLayer:(CCLayer*) _layer withSpace:(cpSpace*)space;
-(void) buildShape;

@end
