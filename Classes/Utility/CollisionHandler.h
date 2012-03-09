//
//  CollisionHandler.h
//  CrazyBall
//
//  Created by Vishal Patel on 24/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpaceManager.h"


@interface CollisionHandler : NSObject {

}

+(id) sharedInstance; 
/*! Register a collision callback between types for the given collision moments */
-(void) addCollisionCallbackBetweenType:(unsigned int)type1 
							  otherType:(unsigned int)type2 
								 target:(id)target 
							   selector:(SEL)selector
								moments:(CollisionMoment)moment, ... NS_REQUIRES_NIL_TERMINATION;

@end

