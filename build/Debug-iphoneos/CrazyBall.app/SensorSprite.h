//
//  SensorSprite.h
//  CrazyBall
//
//  Created by Vishal Patel on 3/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SensorSprite : CCSprite {
   
	@private 
		int sensorPosition;
}


-(int) getSensorPosition ;
-(void) setSensorPosition:(int)position ;


@end
