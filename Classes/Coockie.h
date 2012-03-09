//
//  Coockie.h
//  CrazyBall
//
//  Created by Vishal Patel on 16/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// Importing Chipmunk headers
#import "chipmunk.h"

@class Carrom;
@interface Coockie : CCSprite {

	CCLayer* _game;
	cpFloat flipAngle;
	int sensorHitPosition;

}

@property (readwrite,assign) cpShape *shape ;

+(id) spriteWithFile:(NSString*)filename andGame:(CCLayer*)game;
-(id) initWithFile:(NSString *)filename andGame:(CCLayer*)game;
-(void) addAtPosition:(cpVect)posVect ;
-(void) setAtPosition:(cpVect)posVect ;
-(void) setCookieFlipAngle:(cpFloat)angle ;
-(void) setSensorHitPosietion:(int)position ;
-(void) killCoockie ;


@end
