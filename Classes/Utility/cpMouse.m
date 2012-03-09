/* Copyright (c) 2008 Tommy Thorsen
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include "cpMouse.h"
#include <stdlib.h>
#include <stdio.h>
#import "CollisionHandler.h"


static void
mouseUpdateVelocity(cpBody *body,
                    cpVect gravity,
                    cpFloat damping,
                    cpFloat dt)
{
    cpMouse *mouse = (cpMouse *)body->data;

    /*
     *  Calculate the velocity based on the distance moved since the
     *  last time we calculated velocity. We use a weighted average
     *  of the new velocity and the old velocity to make everything
     *  a bit smoother.
     */
    cpVect newVelocity = cpvmult(mouse->moved, 1.0f / dt);

    body->v = cpvadd(cpvmult(body->v, 0.7f),
                     cpvmult(newVelocity, 0.3f));

    mouse->moved = cpvzero;
}

static void
mouseUpdatePosition(cpBody *body,
                    cpFloat dt)
{
}

cpMouse *
cpMouseAlloc()
{
    return (cpMouse *)malloc(sizeof(cpMouse));
}

cpMouse *
cpMouseInit(cpMouse *mouse, cpSpace *space)
{
	
	NSLog(@"Mouse Init");
    mouse->space = space;
    mouse->grabbedBody = NULL;
    mouse->moved = cpvzero;

    mouse->body = cpBodyNew(1000.0, INFINITY);
    mouse->body->velocity_func = mouseUpdateVelocity;
    mouse->body->position_func = mouseUpdatePosition;
    mouse->body->data = (void *)mouse;

    mouse->shape = cpCircleShapeNew(mouse->body, 30.0f, cpvzero);
    mouse->shape->layers = (unsigned int)(1 << 31);
	mouse->shape->group = 5;
	NSLog(@"MouseInit-setting up layers");
		
    mouse->joint = NULL;

	
    cpSpaceAddBody(space, mouse->body);
    cpSpaceAddShape(space, mouse->shape);

	
	NSLog(@"MouseInit - shape & body added - returning");

    return mouse;
}

cpMouse *
cpMouseNew(cpSpace *space)
{
    return cpMouseInit(cpMouseAlloc(), space);
}

void
cpMouseDestroy(cpMouse *mouse)
{
    cpMouseRelease(mouse);

    cpSpaceRemoveShape(mouse->space, mouse->shape);
    cpSpaceRemoveBody(mouse->space, mouse->body);

    cpShapeFree(mouse->shape);
    cpBodyFree(mouse->body);
}

void
cpMouseFree(cpMouse *mouse)
{
    if (mouse) {
        cpMouseDestroy(mouse);
        free(mouse);
    }
}

void
cpMouseMove(cpMouse *mouse, cpVect position)
{
    mouse->moved = cpvadd(mouse->moved,
                          cpvsub(position, mouse->body->p));
    mouse->body->p = position;
}

void
cpMouseGrab(cpMouse *mouse, cpVect point)
{
    cpMouseRelease(mouse);

    mouse->grabbedBody = NULL;
	
	cpShape *shape = cpSpacePointQueryFirst(mouse->space, point, (unsigned int)(1 << 31), 0);

    if (shape) {
		NSLog(@"Found Shape To Grab- Grabbing");
		mouse->grabbedBody = shape->body;
        mouse->joint = cpPivotJointNew2(mouse->body,
										 mouse->grabbedBody,
										 cpvzero,
										 cpBodyWorld2Local(mouse->grabbedBody, point));
		mouse->joint->maxForce = 30000.0f;
		mouse->joint->biasCoef = 0.15f; 
		cpSpaceAddConstraint(mouse->space, mouse->joint);
    }
}

void
cpMouseRelease(cpMouse *mouse)
{
    if (!mouse->joint) {
        return;
    }

    cpSpaceRemoveConstraint(mouse->space, mouse->joint);
    cpConstraintFree(mouse->joint);
    mouse->joint = NULL;

    mouse->grabbedBody = NULL;
}


