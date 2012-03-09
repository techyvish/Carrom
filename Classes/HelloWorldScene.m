//
//  HelloWorldScene.m
//  CrazyBall
//
//  Created by Vishal Patel on 14/04/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldScene.h"
#import "GameContext.h"
#import "Coockie.h"
#import "CCLayer.h"
#import "DebugDrawNode.h"
#import "GameConfig.h"
#import "SensorSprite.h"
#import "BoardCreator.h"
#import "Striker.h"
#import "Striker2.h"
#import "MessagingSystem.h"
#import "CollisionHandler.h"

static inline void 
cpPrintVector(cpVect v) {
	CCLOG(@" x: %f   y: %f \n",v.x,v.y);
}
	
//static cpFloat gravityStrength = 1.0e6f;
//static cpFloat gravityStrength = 1.0e6f;
enum {
	kTagBatchNode = 1,
	kCollisionTypeBall = 2,
	kCollisionTypeCoockie = 3,
	kCollisionTypeSensor = 4,
	kCollisionTypeArrow = 5,
	KCollisionTypeOuterSensor = 6,
};


static cpFloat flipAngle = 0.0;





//static int handleInvocations(CollisionMoment moment, cpArbiter *arb, struct cpSpace *space, void *data)
//{
//	NSInvocation *invocation = (NSInvocation*)data;
//	CCLOG(@"Collistion moment :%d", moment );
//	@try {
//		[invocation setArgument:&moment atIndex:2];
//		[invocation setArgument:&arb atIndex:3];
//		[invocation setArgument:&space atIndex:4];
//	}
//	@catch (NSException *e) {
//		//No biggie, continue!
//	}
//	
//	[invocation invoke];
//	
//	//default is yes, thats what it is in chipmunk
//	BOOL retVal = YES;
//	
//	//not sure how heavy these methods are...
//	if ([[invocation methodSignature]  methodReturnLength] > 0)
//		[invocation getReturnValue:&retVal];
//	
//	return retVal;
//}
//
//
//static int collBegin(cpArbiter *arb, struct cpSpace *space, void *data)
//{
//	return handleInvocations(COLLISION_BEGIN, arb, space, data);
//}
//
//static int collPreSolve(cpArbiter *arb, struct cpSpace *space, void *data)
//{
//	return handleInvocations(COLLISION_PRESOLVE, arb, space, data);
//}
//
//static void collPostSolve(cpArbiter *arb, struct cpSpace *space, void *data)
//{
//	handleInvocations(COLLISION_POSTSOLVE, arb, space, data);
//}
//
//static void collSeparate(cpArbiter *arb, struct cpSpace *space, void *data)
//{
//	handleInvocations(COLLISION_SEPARATE, arb, space, data);
//}

static void removeShape(cpSpace *space, void *obj, void *data)
{
	[(Carrom*)(data) removeAndMaybeFreeShape:(cpShape*)(obj)];
}








static void
eachShape(void *ptr, void* unused)
{
	cpShape *shape = (cpShape*) ptr;
	CCSprite *sprite = shape->data;
	if( sprite ) {
		cpBody *body = shape->body;
		// TIP: cocos2d and chipmunk uses the same struct to store it's position
		// chipmunk uses: cpVect, and cocos2d uses CGPoint but in reality the are the same
		// since v0.7.1 you can mix them if you want.	
		//cpFloat v_mag = cpvlength(body->v);
		//body->v = cpvmult(body->v, 1.0f + (60.0f - v_mag)/v_mag* 0.2f);
		
		[sprite setPosition: body->p];
		
		[sprite setRotation: (float) CC_RADIANS_TO_DEGREES( -body->a )];
	}
	
}






// HelloWorld implementation
@implementation Carrom
@synthesize striker;
@synthesize objectArray;
@synthesize spaceManager = smgr;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Carrom *layer = [Carrom node];

	// add layer as a child to scene
	[scene addChild: layer];
	
	
	// return the scene
	return scene;
}




#define SLING_POSITION			ccp(60,157)
#define SLING_BOMB_POSITION		ccpAdd(SLING_POSITION, ccp(0,9))



-(id)init 
{
	if (( self = [super init] )) {
	
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];


		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = NO; // we don't want accelerator
		cpInitChipmunk();
		
		
		self.objectArray = [NSMutableArray arrayWithCapacity:10];

		space = [[GameContext sharedInstance] getSpace];
		space->gravity = cpvzero; // ccp(0, -100);
		space->elasticIterations = space->iterations;
		space->damping = 0.2;
		// Start Preparing GameObjects.
		[self prepareBoard];
						
		[self addSensor];	
		
		
            

//        cpShape *shape = cpSegmentShapeNew(cpBodyNew(60.0, INFINITY), ccp(100,100.0), ccp(150,150), 5.0f);
//		shape->e = 1.0; // Elasticity
//		shape->u = 1.0; // Friction --> high to let physics handle the collision properly.
//		
//		cpSpaceAddBody (space, shape->body);
//		cpSpaceAddShape(space, shape);
//
        
        
        
       // The information you see here is just an example and does not reflect the real data.
        //int pointer_positionX =  50; //PUT YOUR OWN VALUE HERE
        //int pointer_positionY = 100; //PUT YOUR OWN VALUE HERE
        pointer_Sprite = [CCSprite spriteWithFile:@"pointer2.png" ];//rect:CGRectMake(100,100, 100, 100)];
        //pointer_Sprite.position = ccp(pointer_positionX, pointer_positionY);
        pointer_Sprite.anchorPoint = CGPointMake(0.5,0.0);
        pointer_Sprite.opacity = 255* 0.5;
        [self addChild:pointer_Sprite];
        int dimension_pointer = 4;
        CGPoint vertices_pointer[] = {
            ccp(-10.000000f,  100.000000f),
            ccp( 10.000000f,  100.000000f),
            ccp( 10.000000f, -0.000000f),
            ccp(-10.000000f, -0.000000f)};
        cpBody *body_pointer = cpBodyNew(1.0f, cpMomentForPoly(1.0f, dimension_pointer, vertices_pointer, CGPointZero));
        body_pointer->p = ccp(50, 200); //ADD YOUR VALUES HERE
        cpSpaceAddBody(space, body_pointer);
        shape_pointer = cpPolyShapeNew(body_pointer, dimension_pointer, vertices_pointer, CGPointZero);
        shape_pointer->e = 0.5f;
        shape_pointer->u = 0.5f;
        shape_pointer->data = pointer_Sprite;
        shape_pointer->sensor = YES;
        cpSpaceAddShape(space, shape_pointer);
        
        
        shape_pointer->body->p = striker.shape->body->p;
        
        
		
#ifdef	SHOW_DEBUG_OUTLINES
		//[self addChild:[DebugDrawNode nodeWithSpace:space] z:30];
#endif
		
		AMSubscribe(@selector(reset:),@"STRIKER_RESET",nil);
	
		[self schedule: @selector(step:)];
		[self schedule: @selector(ballOutOfRangeCheck:) interval:1];
	}
	
	return self;
}

#define ARROW_TAG 66

-(void) reset:(NSNotification*)notification {

	[self performSelectorOnMainThread:@selector(resetPosition) withObject:nil waitUntilDone:YES];
}


- (void) ballOutOfRangeCheck: (ccTime) delta {
	//CCLOG(@"Checking Ball Range");
	if (striker.shape->body-> p.x > 480 || striker.shape->body-> p.x < -5 ||
		striker.shape->body-> p.y > 320 || striker.shape->body-> p.y < -5 ) {
		[self resetPosition];
	}
}

-(void) resetPosition {
	
	// Display animation Shooting too hard 
	// Resetting...
	
	CCLOG(@"Ball Reset");
	[striker resetStrikerAnimate];
	//CGSize wins = [[CCDirector sharedDirector] winSize];
	//striker.shape->body->p = cpv( wins.width / 2.0 - 60.0 , wins.height / 2.0 );
	
}



-(void) addSensor {
	
	for ( int i = 0 ; i < 4 ; i ++ ) {
		
		cpShape* sensorShape = cpCircleShapeNew(cpBodyNew(30.0, INFINITY), 16.0, cpvzero);
		sensorShape->sensor = 1;
		sensorShape->collision_type = kCollisionTypeSensor; // Collisions are grouped by types
	
		//[(SensorSprite*)sensorShape->data setSensorPosition:i];
		// Add the shape to out space
		cpSpaceAddShape(space, sensorShape);
		cpSpaceAddBody(space, sensorShape->body);
		
		sensorShape->body->p = [self getSensorPosition:i];
								
	
		[[CollisionHandler sharedInstance] addCollisionCallbackBetweenType:kCollisionTypeSensor 
									otherType:kCollisionTypeCoockie 
									   target:self 
									 selector:@selector(handleCoockieCollision:arbiter:space:)
									  moments:COLLISION_BEGIN,COLLISION_PRESOLVE,COLLISION_POSTSOLVE,COLLISION_SEPARATE,nil];
		
	}
}

-(void) onEnter
{
	[super onEnter];
	
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
}

-(void) step: (ccTime) delta
{
	//CCLOG(@"Time %f",delta);
	int steps = 4;
	CGFloat dt = delta/(CGFloat)steps;

	for(int i=0; i<steps; i++){
		cpSpaceStep(space, dt);
	}
	cpSpaceHashEach(space->activeShapes, &eachShape, nil);
	cpSpaceHashEach(space->staticShapes, &eachShape, nil);

}

#define SLING_MAX_ANGLE			360
#define SLING_MIN_ANGLE			-360
#define SLING_TOUCH_RADIUS		50
#define SLING_LAUNCH_RADIUS		75

#define SPRITE_BALL_POSITION	ccp(60,20) 



-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	if ( ![striker isStrikerStopped] )
		return cpFalse;
	CCLOG(@"Touch Began");
	if ( striker.velocity <= 0.500000  ) {
		CGPoint pt = [self convertTouchToNodeSpace:touch];	
			
		cpFloat distance = cpvlength(cpvsub(pt, striker.shape->body->p));
		CCLOG(@"distance %f",distance);
		if ( distance <= 25.0 ) {
			CCLOG(@"Ball Touched ");
			previousPosition = striker.shape->body->p;
			

		}
		
		float radiusSQ = SLING_TOUCH_RADIUS*SLING_TOUCH_RADIUS;
		
		//Get the vector of the touch
		CGPoint vector = ccpSub(striker.shape->body->p, pt);
		
		
		
		//Are we close enough to the slingshot?
		if (ccpLengthSQ(vector) < radiusSQ)
			return cpTrue;
		else
			return cpFalse;
	}
	
	return cpFalse;
	
}

-(void) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event {
	if ( ![striker isStrikerStopped] )
		return;

//	CGSize wins = [[CCDirector sharedDirector] winSize];
//	CGPoint arbitoryPoint = cpv( wins.width / 2.0 - 60.0 , winSize.height )
	
	if ( [striker isStrikerStopped] ) {
		
		
		CGPoint pt = [self convertTouchToNodeSpace:touch];
		
		CGPoint vector = ccpSub(pt, striker.shape->body->p );
		
		
		CGPoint normalVector = ccpNormalize(vector);
		float angleRads = ccpToAngle(normalVector);
		int angleDegs = (int)CC_RADIANS_TO_DEGREES(angleRads) % 360;
		
//		float angle1 = ccpAngle(previousPosition, pt ) ;
//		int angleD = (int)CC_RADIANS_TO_DEGREES(angle1) % 360;
//		float radiusSQ = SLING_TOUCH_RADIUS*SLING_TOUCH_RADIUS;
		
		//Get the vector of the touch
//		CGPoint vector1 = ccpSub(striker.shape->body->p, pt);
		
		
		/*
		VPRINT(@"point ",pt);
		
		CCLOG(@"Angle %d",angleDegs);
		if ( pt.x >=  (previousPosition.x - 15.0) && pt.x <= (previousPosition.x + 15.0) ) {
			[striker scaleUp];
			//CCLOG(@"Moving body curret angle : %d", angleDegs);
			striker.shape->body->p = cpv (previousPosition.x,pt.y);
			return;
		}
        
        [striker scaleDown];
		*/	
		float length = ccpLength(vector);
		
		//Limit the length
		if (length > SLING_LAUNCH_RADIUS)
			length = SLING_LAUNCH_RADIUS;
		
//		//Limit the angle
//		if (angleDegs > SLING_MAX_ANGLE)
//			normalVector = ccpForAngle(CC_DEGREES_TO_RADIANS(SLING_MAX_ANGLE));
//		else if (angleDegs < SLING_MIN_ANGLE)
//			normalVector = ccpForAngle(CC_DEGREES_TO_RADIANS(SLING_MIN_ANGLE));
		
		
//		flipAngle = arrowShape->body->a ;
//		if ( !arrowSprite.visible ) 
//			arrowSprite.visible = cpTrue;
//		arrowShape->body->p = ccpAdd(previousPosition, ccpMult(normalVector , length * -1 ));
//		arrowShape->body->a = CC_DEGREES_TO_RADIANS( 90 + angleDegs );
		

        flipAngle = shape_pointer->body->a ;
		//if ( !arrowSprite.visible ) 
		//	arrowSprite.visible = cpTrue;
		//shape_pointer->body->p = ccpAdd(previousPosition, ccpMult(normalVector , length * -1 ));
		shape_pointer->body->p = striker.shape->body->p;
        shape_pointer->body->a = CC_DEGREES_TO_RADIANS( 90 + angleDegs );
        CCLOG(@"%f",length);
        [pointer_Sprite setScaleY:length/15.0];
        //[pointer_Sprite runAction:[CCScaleTo actionWithDuration:0.0  scaleX:1.0 scaleY:2.0]];
    
		
		// Assuming that striker stopped @ postion we want 
		
		//striker.shape->body->p = cpv (pt.x,pt.y);
		
//		cpMouseMove(mouse, cpv(pt.x, pt.y));
//		if( mouse->grabbedBody == nil){
//			CCLOG(@"Grabbed object moved");
//			cpMouseGrab(mouse, pt);
//		}
		
		// If user is about to move out from boundry calculate distance, apply impulse and
		// calncell all touches.
		
	}
}

-(void) ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
	CCLOG(@"Touches Cancelled");
}


-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	if ( ![striker isStrikerStopped] )
		return;

	if ( [striker isStrikerStopped] ) {
		
		CGPoint pt = [self convertTouchToNodeSpace:touch];	

		//CGPoint vector = ccpSub(previousPosition, arrowSprite.position);
		CGPoint vector = ccpSub(previousPosition, pt);
		
		float hitDirection = ( fabsf(vector.x) > fabsf(vector.y) ) ? fabsf( vector.x ) : fabsf( vector.y ) ;
		int lateralForce	= ( ((hitDirection * 15) > 1600 ) ? 1800 : (hitDirection * 30) );
		
		CCLOG(@"Lateral force : %d",lateralForce);
		[striker scaleDown];
        
        
//#ifdef SHOW_DEBUG_OUTLINES
//		cpBodyApplyImpulse(ballShape->body, cpvmult(vector, 1000), cpvzero );
//#else
		cpBodyApplyImpulse(striker.shape->body, cpvmult(vector, lateralForce ), cpvzero );
//#endif
		

		[striker observePosition];
		
//		cpMouseDestroy(mouse);
	}
}

-(void) removeAndMaybeFreeShape:(cpShape*)shape {
	
	cpSpaceRemoveBody(space, shape->body);
	cpBodyFree(shape->body);
	
	cpSpaceRemoveShape(space, shape);
	cpShapeFree(shape);
	if ( shape != nil ) 
		[(Coockie*)shape->data killCoockie];
	

}


//-(void) addCollisionCallbackBetweenType:(unsigned int)type1 otherType:(unsigned int) type2 target:(id)target selector:(SEL)selector
//{
//	//set up the invocation
//	NSMethodSignature * sig = [[target class] instanceMethodSignatureForSelector:selector];
//	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
//	
//	[invocation setTarget:target];
//	[invocation setSelector:selector];
//	
//	//add the callback to chipmunk
//	cpSpaceAddCollisionHandler(space, type1, type2, collBegin, collPreSolve, collPostSolve, collSeparate, invocation);
//	
//	//we'll keep a ref so it won't disappear, prob could just retain and clear hash later
//	//[_invocations addObject:invocation];
//}


//-(void) addCollisionCallbackBetweenType:(unsigned int)type1 
//							  otherType:(unsigned int)type2 
//								 target:(id)target 
//							   selector:(SEL)selector
//								moments:(CollisionMoment)moment, ...
//{
//	//set up the invocation
//	NSMethodSignature * sig = [[target class] instanceMethodSignatureForSelector:selector];
//	NSInvocation *invocation = [[NSInvocation invocationWithMethodSignature:sig] retain];
//		//should retain some where, free some where...
//	
//	[invocation setTarget:target];
//	[invocation setSelector:selector];
//	
//	cpCollisionBeginFunc begin = NULL;
//	cpCollisionPreSolveFunc preSolve = NULL;
//	cpCollisionPostSolveFunc postSolve = NULL;
//	cpCollisionSeparateFunc separate = NULL;
//	
//	va_list args;
//	va_start(args, moment);
//	
//	while (moment != 0)
//	{
//		switch (moment) 
//		{
//			case COLLISION_BEGIN:
//				begin = collBegin;
//				break;
//			case COLLISION_PRESOLVE:
//				preSolve = collPreSolve;
//				break;
//			case COLLISION_POSTSOLVE:
//				postSolve = collPostSolve;
//				break;
//			case COLLISION_SEPARATE:
//				separate = collSeparate;
//				break;
//			default:
//				break;
//		}
//		moment = (CollisionMoment)va_arg(args, int);
//	}
//	
//	va_end(args);
//	
//	//add the callback to chipmunk
//	cpSpaceAddCollisionHandler(space, type1, type2, begin, preSolve, postSolve, separate, invocation);
//	
//	//we'll keep a ref so it won't disappear, prob could just retain and clear hash later
//	//[_invocations addObject:invocation];
//}

//-(BOOL) handleCoockieBallCollision:(CollisionMoment)moment arbiter:(cpArbiter*)arb space:(cpSpace*)space_
//{
//	cpShape *coockie, *sen;
//	cpArbiterGetShapes(arb, &sen , &coockie);
//	if (moment == COLLISION_BEGIN)
//	{
//		CCLOG(@"Collision Point:  %f  %f ",arb->contacts->p.x,arb->contacts->p.y);		
//	}
//	return YES;	
//}

-(BOOL) handleStrikerJointCollision:(CollisionMoment)moment arbiter:(cpArbiter*)arb space:(cpSpace*)space_
{
	CCLOG(@"Striker & Joint collied");
	return cpTrue;
}


-(BOOL) handleCoockieCollision:(CollisionMoment)moment arbiter:(cpArbiter*)arb space:(cpSpace*)space_
{
	BOOL handled = cpFalse;
	CP_ARBITER_GET_SHAPES(arb, sensor, coockie);
	switch (moment) {
		case COLLISION_BEGIN: {
			//CCLOG(@"Collision Begin Called"); 
			handled = cpTrue;
		}
			break;
		case COLLISION_PRESOLVE:  {
			//CCLOG(@"Presolve Called");
			if ( cpShapePointQuery(coockie, sensor->body->p ))
			{
				CGSize wins = [[CCDirector sharedDirector] winSize];
				
				[(Coockie*)(coockie->data) setCookieFlipAngle:flipAngle];
				SensorPosition pos;
				
				if ( cpveql( sensor->body->p ,cpv( 16.0 , 16.0 ) ) ) 
					pos = BottomLeft;
				
				if ( cpveql( sensor->body->p ,cpv( 16.0 , wins.height - 16))  ) 
					pos = TopLeft;
				
				if ( cpveql( sensor->body->p , cpv( wins.width - 16.0 ,  wins.height - 16.0 ) ) ) 
					pos = TopRight;
				
				if ( cpveql( sensor->body->p ,cpv( wins.width - 16.0 , 16.0 ) )  ) 
					pos = BottomRight;
				
				[(Coockie*)(coockie->data) setSensorHitPosietion: pos ];
				//CCLOG(@"Yay got score...");
				if (space->locked) 
					cpSpaceAddPostStepCallback(space, removeShape, coockie, self);
				else 
					[self removeAndMaybeFreeShape:coockie];
			handled = cpTrue;
			}
		}
			break;
		case COLLISION_POSTSOLVE:
			//CCLOG(@"Postsolve Called"); handled = cpTrue;
			break;
		case COLLISION_SEPARATE:
			//CCLOG(@"Separate called"); handled = cpTrue;
			break;
	}
		
	return handled;
}



-(cpVect) getSensorPosition: ( int ) position  {
	
	CGSize wins = [[CCDirector sharedDirector]winSize];
	switch ( position ) {
		case BottomLeft :
			return cpv( 16.0 , 16.0 );
			break;
			
		case TopLeft :
			return cpv( 16.0 , wins.height - 16);
			break;
			
		case TopRight  :
			return cpv( wins.width - 16.0 ,  wins.height - 16.0 );
			break;
			
		case BottomRight :
			return cpv( wins.width - 16.0 , 16.0 );
			break;
	}
	return cpvzero;
}

-(void) prepareBoard {

	BoardCreator* creator = [[BoardCreator alloc]initWithSpace:self withSpace:[[GameContext sharedInstance]getSpace]];
	[creator generateBoarders];
	[creator generateStriker];
	[creator generateCoockies];
	
}


@end
