//
//  BoardCreator.m
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BoardCreator.h"
#import "BorderBuilder.h"
#import "StrikerBuilder.h"
#import "HelloWorldScene.h"
#import "CoockieBuilder.h"

@implementation BoardCreator


-(id)initWithSpace:(CCLayer*)_layer withSpace:(cpSpace*)_space  {
		
	if ( (self = [super init] ) ) {
	
		layer = _layer;
		space = _space;
	}
	return self;
}

-(void) generateBoarders {

	CCSprite *background = [CCSprite spriteWithFile:@"woodboard.png"];
	background.position = ccp(240,160);
	[layer addChild:background z:0];
	
	
	BorderBuilder* builder = [[BorderBuilder alloc]init];
	[builder addIntoLayer:layer withSpace:space];
	ShapeBuildDirector* director = [[ShapeBuildDirector alloc]initWithShapeBuilder:builder];
	[director buildShape];
	[builder release];
	[director release];
}

-(void) generateStriker {
	StrikerBuilder* builder = [[StrikerBuilder alloc]initWithSpriteFileName:@"Striker.png" 
																andLayer:layer];
	ShapeBuildDirector* director = [[ShapeBuildDirector alloc]initWithShapeBuilder:builder];
	[director buildShape];
	((Carrom*)layer).striker = [builder getResult];
	[builder release];
	[director release];
}	
	

-(void) generateCoockies {

	CGSize wins = [[CCDirector sharedDirector]winSize];
	CoockieBuilder* builder = [[CoockieBuilder alloc]initWithSpriteFileName:@"coockie-black.png" 
																   andLayer:layer];
	ShapeBuildDirector* director = [[ShapeBuildDirector alloc]initWithShapeBuilder:builder];
	
	for ( int i = 1 ; i <= 3 ; i ++ ) {
	
		[director buildShape];
		Coockie* coockie = [builder getResult];
		[coockie setAtPosition:cpv( wins.width / 2.0 + i * 30.0 , wins.height / 2.0 + 30 )];
	}
	[builder release];
	[director release];

	
	CoockieBuilder* whiteBuilder = [[CoockieBuilder alloc]initWithSpriteFileName:@"coockie.png" 
																   andLayer:layer];
	ShapeBuildDirector* whiteDirector = [[ShapeBuildDirector alloc]initWithShapeBuilder:whiteBuilder];
	
	for ( int i = 1 ; i <= 3 ; i ++ ) {
		
		[whiteDirector buildShape];
		Coockie* coockie = [builder getResult];
		[coockie setAtPosition:cpv( wins.width / 2.0 + i * 30.0 , wins.height / 2.0 - 30 )];
	}
	[whiteBuilder release];
	[whiteDirector release];
	
}

@end
