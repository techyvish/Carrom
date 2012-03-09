//
//  GameContext.h
//  CrazyBall
//
//  Created by Vishal Patel on 16/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chipmunk.h"
#import "cocos2d.h"

#ifdef __cplusplus 
extern "C" {
#endif

	int printVector(NSString* __string__,cpVect __vector__);
	#ifdef __cplusplus
}
#endif

#define VPRINT(__string__,__vector__) printVector(__string__,__vector__)



typedef enum {
	BottomLeft = 0,
	TopLeft = 1,
	TopRight = 2, 
	BottomRight = 3 
}SensorPosition;

static inline cpVect getSensorPosition( int position ) {
	
	CGSize wins = [[CCDirector sharedDirector]winSize];
	switch ( position ) {
		case BottomLeft:
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


@interface GameContext : NSObject {

	cpSpace *space;
}

+(id) sharedInstance ;
-(cpSpace*) getSpace ;

@end
