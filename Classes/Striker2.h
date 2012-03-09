//
//  Striker2.h
//  CrazyBall
//
//  Created by Vishal Patel on 22/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpaceManagerCocos2d.h"

@class Carrom;

@interface Striker2 : cpCCSprite 
{
	Carrom *_game;
	BOOL _countDown;
}



+(id) bombWithGame:(Carrom*)game;
+(id) bombWithGame:(Carrom*)game shape:(cpShape*)shape;;
-(id) initWithGame:(Carrom*)game;
-(id) initWithGame:(Carrom*)game shape:(cpShape*)shape;



@end
