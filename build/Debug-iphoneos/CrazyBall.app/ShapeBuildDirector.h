//
//  BuildDirector.h
//  CrazyBall
//
//  Created by Vishal Patel on 9/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShapeBuilder.h"

@interface ShapeBuildDirector : NSObject {

	ShapeBuilder		*builder;
}


-(id) initWithShapeBuilder: (ShapeBuilder*) _builder ;
-(void) buildShape ;


@end
