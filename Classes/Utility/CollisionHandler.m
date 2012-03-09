//
//  CollisionHandler.m
//  CrazyBall
//
//  Created by Vishal Patel on 24/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CollisionHandler.h"
#import "cocos2d.h"
#import "chipmunk.h"
#import "HelloWorldScene.h"
#import "GameContext.h"


static int handleInvocations(CollisionMoment moment, cpArbiter *arb, struct cpSpace *space, void *data)
{
	NSInvocation *invocation = (NSInvocation*)data;
	CCLOG(@"Collistion moment :%d", moment );
	@try {
		[invocation setArgument:&moment atIndex:2];
		[invocation setArgument:&arb atIndex:3];
		[invocation setArgument:&space atIndex:4];
	}
	@catch (NSException *e) {
		//No biggie, continue!
	}
	
	[invocation invoke];
	
	//default is yes, thats what it is in chipmunk
	BOOL retVal = YES;
	
	//not sure how heavy these methods are...
	if ([[invocation methodSignature]  methodReturnLength] > 0)
		[invocation getReturnValue:&retVal];
	
	return retVal;
}


static int collBegin(cpArbiter *arb, struct cpSpace *space, void *data)
{
	return handleInvocations(COLLISION_BEGIN, arb, space, data);
}

static int collPreSolve(cpArbiter *arb, struct cpSpace *space, void *data)
{
	return handleInvocations(COLLISION_PRESOLVE, arb, space, data);
}

static void collPostSolve(cpArbiter *arb, struct cpSpace *space, void *data)
{
	handleInvocations(COLLISION_POSTSOLVE, arb, space, data);
}

static void collSeparate(cpArbiter *arb, struct cpSpace *space, void *data)
{
	handleInvocations(COLLISION_SEPARATE, arb, space, data);
}



static CollisionHandler	*instance;
@implementation CollisionHandler

+(id) sharedInstance {

	if ( instance == nil ) 
		 instance = [[CollisionHandler alloc]init];
	return instance;

}

-(void) addCollisionCallbackBetweenType:(unsigned int)type1 
							  otherType:(unsigned int)type2 
								 target:(id)target 
							   selector:(SEL)selector
								moments:(CollisionMoment)moment, ...
{
	//set up the invocation
	NSMethodSignature * sig = [[target class] instanceMethodSignatureForSelector:selector];
	NSInvocation *invocation = [[NSInvocation invocationWithMethodSignature:sig] retain];
	//should retain some where, free some where...
	
	[invocation setTarget:target];
	[invocation setSelector:selector];
	
	cpCollisionBeginFunc begin = NULL;
	cpCollisionPreSolveFunc preSolve = NULL;
	cpCollisionPostSolveFunc postSolve = NULL;
	cpCollisionSeparateFunc separate = NULL;
	
	va_list args;
	va_start(args, moment);
	
	while (moment != 0)
	{
		switch (moment) 
		{
			case COLLISION_BEGIN:
				begin = collBegin;
				break;
			case COLLISION_PRESOLVE:
				preSolve = collPreSolve;
				break;
			case COLLISION_POSTSOLVE:
				postSolve = collPostSolve;
				break;
			case COLLISION_SEPARATE:
				separate = collSeparate;
				break;
			default:
				break;
		}
		moment = (CollisionMoment)va_arg(args, int);
	}
	
	va_end(args);
	
	cpSpace *space = [[GameContext sharedInstance]getSpace];
	//add the callback to chipmunk
	cpSpaceAddCollisionHandler(space, type1, type2, begin, preSolve, postSolve, separate, invocation);
	
	//we'll keep a ref so it won't disappear, prob could just retain and clear hash later
	//[_invocations addObject:invocation];
}







@end
