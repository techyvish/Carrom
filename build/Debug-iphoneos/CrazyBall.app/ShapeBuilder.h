//
//  ShapeBuilder.h
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// Importing Chipmunk headers
#import "chipmunk.h"




@protocol ShapeBuilderProtocol 

	-(void) addIntoLayer:(CCLayer*) layer withSpace:(cpSpace*)space;
	-(void) buildShape ;

@end

// Abstract Shape builder class 
@interface ShapeBuilder : NSObject <ShapeBuilderProtocol> {

	CGSize wins;
}


-(id) initWithSpriteFileName:(NSString*)filename andLayer:(CCLayer*)_layer ;

@end
