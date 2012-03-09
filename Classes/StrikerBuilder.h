//
//  StrikerBuilder.h
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShapeBuilder.h"
#import "Striker.h"


@interface StrikerBuilder : ShapeBuilder {
	cpSpace		*space;
	CCLayer		*layer;
	Striker		*striker;
	
}

@property (nonatomic,retain) Striker	*striker;

-(id) initWithSpriteFileName:(NSString*)filename andLayer:(CCLayer*)_layer;
-(void) buildShape;
-(Striker*) getResult;

@end
