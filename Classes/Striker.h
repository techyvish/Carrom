
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "chipmunk.h"

@class Carrom;

@interface Striker : CCSprite {

	CCLayer* _game;
	cpFloat flipAngle;
	int sensorHitPosition;
	cpFloat previousVelocity;

}

@property (readwrite,assign) cpShape *shape ;
@property (readonly) cpFloat velocity;

+(id)   spriteWithFile:(NSString*)filename andGame:(CCLayer*)game;
-(id)   initWithFile:(NSString *)filename andGame:(CCLayer*)game;
-(void) addAtPosition:(cpVect)posVect ;
-(void) setAtPosition:(cpVect)posVect ;
-(void) killCoockie ;
-(BOOL) isStrikerStopped ;
-(void) resetStrikerAnimate;
-(void) observePosition;
-(void) stopObservingPosition;
-(void) scaleUp ;
-(void) scaleDown ;
-(void) scaleXup:(int)x ;

@end
