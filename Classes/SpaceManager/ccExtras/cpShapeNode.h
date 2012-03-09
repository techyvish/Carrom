/*********************************************************************
 *	
 *	cpShapeNode.h
 *
 *	Provide Drawing for Shapes
 *
 *	http://www.mobile-bros.com
 *
 *	Created by Robert Blackwood on 02/22/2009.
 *	Copyright 2009 Mobile Bros. All rights reserved.
 *
 **********************************************************************/

#import "cocos2d.h"
#import "chipmunk.h"
#import "cpCCNode.h"



@interface cpShapeNode : cpCCNode <CCRGBAProtocol>
{
@protected	
	ccColor3B _color;
	GLubyte _opacity;
	
	cpFloat _pointSize;
	cpFloat _lineWidth;
	BOOL	_smoothDraw;
	BOOL	_fillShape;
	BOOL	_drawDecoration;
	
}

/*! Color of our drawn shape */
@property (readwrite, assign) ccColor3B color;

/*! Opacity of our drawn shape */
@property (readwrite, assign) GLubyte opacity;

/*! Size of drawn points, default is 3 */
@property (readwrite, assign) cpFloat pointSize;

/*! Width of the drawn lines, default is 1 */
@property (readwrite, assign) cpFloat lineWidth;

/*! If this is set to YES/TRUE then the shape will be drawn
 with smooth lines/points */
@property (readwrite, assign) BOOL smoothDraw;

/*! If this is set to YES/TRUE then the shape will be filled
 when drawn */
@property (readwrite, assign) BOOL fillShape;

/*! Currently only circle has a "decoration" it is an extra line
 to see the rotation */
@property (readwrite, assign) BOOL drawDecoration;

@end
