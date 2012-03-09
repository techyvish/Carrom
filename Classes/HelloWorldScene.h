//
//  HelloWorldScene.m
//  CrazyBall
//
//  Created by Vishal Patel on 14/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// Importing Chipmunk headers
#import "chipmunk.h"
#import "SpaceManagerCocos2d.h"
#import "cpMouse.h"

///*! Collision Moments */
//typedef enum { 
//	COLLISION_BEGIN = 1, 
//	COLLISION_PRESOLVE, 
//	COLLISION_POSTSOLVE, 
//	COLLISION_SEPARATE
//} CollisionMoment;
//

@class Striker;
@class Striker2;
// HelloWorld Layer
@interface Carrom : CCLayer<SpaceManagerSerializeDelegate>
{
	cpSpace *space;
	CGPoint previousPosition;
	
	Striker* striker;
		
	SpaceManagerCocos2d	*smgr;
	Striker2	*strker;
	
    cpShape     *shape_pointer;
    
	cpMouse *mouse;
    CCSprite *pointer_Sprite;
}

@property (nonatomic,retain) Striker* striker;
@property (nonatomic,retain) NSMutableArray* objectArray;
@property (readonly) SpaceManager* spaceManager;


// returns a Scene that contains the HelloWorld as the only child
+(id) scene;
-(void) step: (ccTime) dt;
-(void) addSensor ;
-(BOOL) handleCoockieCollision:(CollisionMoment)moment arbiter:(cpArbiter*)arb space:(cpSpace*)space;
-(void) removeAndMaybeFreeShape:(cpShape*)shape ;

///*! Register a collision callback between types for the given collision moments */
//-(void) addCollisionCallbackBetweenType:(unsigned int)type1 
//							  otherType:(unsigned int)type2 
//								 target:(id)target 
//							   selector:(SEL)selector
//								moments:(CollisionMoment)moment, ... NS_REQUIRES_NIL_TERMINATION;


//-(void) addCollisionCallbackBetweenType:(unsigned int)type1 otherType:(unsigned int) type2 target:(id)target selector:(SEL)selector ;
-(cpVect) getSensorPosition: ( int ) position ;
-(void) prepareBoard;
-(void) resetPosition ;

@end
