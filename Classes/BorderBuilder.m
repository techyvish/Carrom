//
//  BorderBuilder.m
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BorderBuilder.h"
#import "GameContext.h"

#define SPACE_DAMPING 0.1f
#define ELASTICIY     0.5f

@implementation BorderBuilder


-(id) init {
	
	if ( ( self = [super init] ) ) {
		
		wins = [[CCDirector sharedDirector]winSize];
		
	}
	return self;
}

-(void) addIntoLayer:(CCLayer*) _layer withSpace:(cpSpace*)_space {
	
	layer = _layer;
	space = _space;
	
}

-(void) buildShape {
	
	CCLOG(@"Building Boarder");
		
//	cpBody *staticBody = cpBodyNew(INFINITY, INFINITY);
//	
//	cpShape *shape;
		
	
	
    
    int dimension_pointer = 4; 
    CGPoint vertices_pointer[] = {
        ccp(-230.000000f,   10.000000f), // top left
        ccp( 230.000000f,   10.000000f), // top right
        ccp( 230.000000f, -0.000000f), // Bottom Right
        ccp(-230.000000f, -0.000000f)}; // Bottom Left 
    //cpBody *body_pointer = cpBodyNew(1.0f, cpMomentForPoly(1.0f, dimension_pointer, vertices_pointer, CGPointZero));
    cpBody *body_pointer = cpBodyNew(INFINITY,INFINITY);
    
    //cpSpaceAddBody(space, body_pointer);
    cpShape *shape_pointer = cpPolyShapeNew(body_pointer, dimension_pointer, vertices_pointer, CGPointZero);
    shape_pointer->e = 1.0f;
    shape_pointer->u = 1.0f;
    shape_pointer->body->p = CGPointMake(240, 0.0);
	// bottom
	{
        cpSpaceAddStaticShape(space,shape_pointer);
		//shape = cpSegmentShapeNew(staticBody, ccp(0,5.0), ccp(wins.width,5.0), 5.0f);
		//shape->e = 1.0f; shape->u = 1.0f; shape->collision_type = 0; 
		//cpSpaceAddStaticShape(space, shape);
		
//		
//		for ( int i = 1 ; i <= 64 ; i++ ) {
//			shape = cpCircleShapeNew(staticBody, 5.0, ccp( i * 10.0 , -11.0 ));
//			shape->e = ELASTICIY ; shape->u = 1.0f; shape->collision_type = 0; space->damping = SPACE_DAMPING;
//			cpSpaceAddStaticShape(space, shape);
//		}
		
		
		//shape = cpSegmentShapeNew(staticBody, ccp(0,10.0), ccp(wins.width,10.0), 5.0f);
		//shape->e = 1.0f; shape->u = 1.0f; shape->collision_type = 0; 
		//cpSpaceAddStaticShape(space, shape);
	}
	
	
	
    CGPoint vertices_pointer_left[] = {
        ccp(-10.000000f,   300.000000f), // top left
        ccp( 10.000000f,   300.000000f), // top right
        ccp( 10.000000f, -0.000000f), // Bottom Right
        ccp(-10.000000f, -0.000000f)}; // Bottom Left 
    //cpBody *body_pointer = cpBodyNew(1.0f, cpMomentForPoly(1.0f, dimension_pointer, vertices_pointer, CGPointZero));
    //cpBody *body_pointer = cpBodyNew(INFINITY,INFINITY);
    
    //cpSpaceAddBody(space, body_pointer);
    cpShape *shape_pointer_left = cpPolyShapeNew(cpBodyNew(INFINITY,INFINITY), dimension_pointer, vertices_pointer_left, CGPointZero);
    shape_pointer_left->e = 1.0f;
    shape_pointer_left->u = 1.0f;
    shape_pointer_left->body->p = CGPointMake(0.0, 10.0);
    cpSpaceAddStaticShape(space,shape_pointer_left);
    
	//left
	{
        
//		shape = cpSegmentShapeNew(staticBody, ccp(5.0,0), ccp(5.0,wins.height), 5.0f);
//		shape->e = 1.0f; shape->u = 1.0f; shape->collision_type = 0;
//		cpSpaceAddStaticShape(space, shape);

		
//		for ( int i = 1 ; i <= 32 ; i++ ) {
//			shape = cpCircleShapeNew(staticBody, 5.0, ccp( -11.0 , i * 10.0  ));
//			shape->e = ELASTICIY; shape->u = 1.0f; shape->collision_type = 0; space->damping = SPACE_DAMPING;
//			cpSpaceAddStaticShape(space, shape);
//		}
		
		
//		shape = cpSegmentShapeNew(staticBody, ccp(10.0,0), ccp(10.0,wins.height), 5.0f);
//		shape->e = 1.0f; shape->u = 1.0f; shape->collision_type = 0;
//		cpSpaceAddStaticShape(space, shape);
		
	}
	
	
    
    CGPoint vertices_pointer_top[] = {
        ccp(-230.000000f,   170.000000f), // top left
        ccp( 230.000000f,   170.000000f), // top right
        ccp( 230.000000f,   160.000000f), // Bottom Right
        ccp(-230.000000f,   160.000000f)}; // Bottom Left 
    //cpBody *body_pointer = cpBodyNew(1.0f, cpMomentForPoly(1.0f, dimension_pointer, vertices_pointer, CGPointZero));
    //cpBody *body_pointer = cpBodyNew(INFINITY,INFINITY);
    
    //cpSpaceAddBody(space, body_pointer);
    cpShape *shape_pointer_top = cpPolyShapeNew(cpBodyNew(INFINITY,INFINITY), dimension_pointer, vertices_pointer_top, CGPointZero);
    shape_pointer_top->e = 1.0f;
    shape_pointer_top->u = 1.0f;
    shape_pointer_top->body->p = CGPointMake(240.0, 150.0);
    cpSpaceAddStaticShape(space,shape_pointer_top);

	
	// top
	{
//		shape = cpSegmentShapeNew(staticBody, ccp(0,wins.height-5.0), ccp(wins.width,wins.height-5.0), 5.0f);
//		shape->e = 1.0f; shape->u = 1.0f; shape->collision_type = 0;
//		cpSpaceAddStaticShape(space, shape);
		
		
//		for ( int i = 1 ; i <= 64 ; i++ ) {
//			shape = cpCircleShapeNew(staticBody, 5.0, ccp(  i * 10.0  , wins.height + 11.0 ));
//			shape->e = ELASTICIY; shape->u = 1.0f; shape->collision_type = 0; space->damping = SPACE_DAMPING;
//			cpSpaceAddStaticShape(space, shape);
//		}	
		
		// top
//		shape = cpSegmentShapeNew(staticBody, ccp(0,wins.height -10.0), ccp(wins.width,wins.height - 10.0), 5.0f);
//		shape->e = 1.0f; shape->u = 1.0f; shape->collision_type = 0;
//		cpSpaceAddStaticShape(space, shape);
	}
	
	
    CGPoint vertices_pointer_bottom[] = {
        ccp(-10.000000f,   300.000000f), // top left
        ccp( 10.000000f,   300.000000f), // top right
        ccp( 10.000000f, -0.000000f), // Bottom Right
        ccp(-10.000000f, -0.000000f)}; // Bottom Left 
    //cpBody *body_pointer = cpBodyNew(1.0f, cpMomentForPoly(1.0f, dimension_pointer, vertices_pointer, CGPointZero));
    //cpBody *body_pointer = cpBodyNew(INFINITY,INFINITY);
    
    //cpSpaceAddBody(space, body_pointer);
    cpShape *shape_pointer_bottom = cpPolyShapeNew(cpBodyNew(INFINITY,INFINITY), dimension_pointer, vertices_pointer_bottom, CGPointZero);
    shape_pointer_bottom->e = 1.0f;
    shape_pointer_bottom->u = 1.0f;
    shape_pointer_bottom->body->p = CGPointMake(480.0, 10.0);
    cpSpaceAddStaticShape(space,shape_pointer_bottom);

	
	// right 
	{
//		shape = cpSegmentShapeNew(staticBody, ccp(wins.width-5.0,0), ccp(wins.width-5.0,wins.height), 5.0f);
//		shape->e = 1.0f; shape->u = 1.0f; shape->collision_type = 0;
//		cpSpaceAddStaticShape(space, shape);
		
		
//		for ( int i = 1 ; i <= 32 ; i++ ) {
//			shape = cpCircleShapeNew(staticBody, 5.0, ccp(  wins.width + 11.0  , i * 10.0 ));
//			shape->e = ELASTICIY; shape->u = 1.0f; shape->collision_type = 0; space->damping = SPACE_DAMPING;
//			cpSpaceAddStaticShape(space, shape);
//		}	
		
		
//		shape = cpSegmentShapeNew(staticBody, ccp(wins.width-10.0,0), ccp(wins.width -10.0,wins.height), 5.0f);
//		shape->e = 1.0f; shape->u = 1.0f; shape->collision_type = 0;
//		cpSpaceAddStaticShape(space, shape);
	}
	
}


-(void) dealloc {
	
	
	[super dealloc];
	
}


@end
