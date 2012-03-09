//
//  BoardCreator.h
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShapeBuildDirector.h"

@interface BoardCreator : NSObject {

	CCLayer		*layer;
	cpSpace		*space;

}


-(id)initWithSpace:(CCLayer*)_layer withSpace:(cpSpace*)space ;
-(void) generateBoarders;
-(void) generateStriker;
-(void) generateCoockies;

@end
