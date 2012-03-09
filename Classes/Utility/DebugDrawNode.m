//
//  DebugDrawNode.m
//  CrazyBall
//
//  Created by Vishal Patel on 28/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DebugDrawNode.h"


//
//  DebugDrawNode.m
//  BallTest
//
//  Created by Juraj Hlavac on 4/5/10.
//  Copyright 2010 Apple. All rights reserved.
//

#import "DebugDrawNode.h"

@implementation DebugDrawNode

static void eachShapeDraw(void *ptr, void* unused) {
	cpShape* shape = (cpShape*)ptr;
	if (shape) {
		if (shape->klass->type == CP_CIRCLE_SHAPE) {
			glColor4f(0.5f, 0.5f, 0.5f, 1.0);
			glLineWidth(5.0);
			cpCircleShape* crc = (cpCircleShape*)shape;
			cpVect c = cpvadd(shape->body->p, cpvrotate(crc->c, shape->body->rot));
			ccDrawCircle(c, crc->r, shape->body->a, 10, true);
		}
		else if (shape->klass->type == CP_POLY_SHAPE) {
			glColor4f(1.0f, 0.0f, 0.0f, 1.0);
			glLineWidth(5.0);
			cpPolyShape* poly = (cpPolyShape*)shape;
			ccDrawPoly(poly->tVerts, poly->numVerts, YES);
		}
		else if (shape->klass->type == CP_SEGMENT_SHAPE) {
			glColor4f(1.0f, 0.0f, 0.0f, 1.0);
			glLineWidth(5.0);
			cpSegmentShape* segment = (cpSegmentShape*)shape;
			ccDrawLine(segment->ta, segment->tb);
		}
		else {
			glColor4f(0.0f, 0.0f, 1.0f, 1.0);
			glLineWidth(5.0);
			cpSegmentShape* seg = (cpSegmentShape*)shape;
			ccDrawLine(seg->ta, seg->tb);
		}
	}
}

+(id) nodeWithSpace:(cpSpace*)space {
	return [[[DebugDrawNode alloc] initWithSpace:space] autorelease];
}

-(id) initWithSpace:(cpSpace*)space {
	if ((self == [super init])) {
		_space = space;  // weak ref
	}
	return self;
}

-(void) draw {
	if (visible_ && _space) {
		cpSpaceHashEach(_space->activeShapes, &eachShapeDraw, nil);
		cpSpaceHashEach(_space->staticShapes, &eachShapeDraw, nil);
	}
}

@end


