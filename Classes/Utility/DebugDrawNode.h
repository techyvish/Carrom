//
//  DebugDrawNode.h
//  BallTest
//
//  Created by Juraj Hlavac on 4/5/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"

@interface DebugDrawNode : CCNode {
	cpSpace* _space;  // weak ref
}
+(id) nodeWithSpace:(cpSpace*)space;
-(id) initWithSpace:(cpSpace*)space;
@end
