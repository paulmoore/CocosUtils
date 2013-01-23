//
//  Animation.m
//  Cocos Utils
//
//  NOTE: This library is ARC enabled.
//
//  Created by Paul Moore on 2012-10-26.
/*
 Copyright (c) 2013 Paul Moore
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

#import "Animation.h"

#pragma mark - Private APIs

@interface Animation ()

@property (nonatomic, readwrite) NSInteger startFrame, totalFrames;
@property (nonatomic, readwrite, strong) NSArray *frameNames;
@property (nonatomic, readwrite, strong) NSString *frameFormat;

@end

#pragma mark - Implementations

@implementation Animation

@synthesize startFrame = _startFrame;
@synthesize loopMode = _loopMode;
@synthesize totalFrames = _totalFrames;
@synthesize frameFormat = _frameFormat;
@synthesize frameNames = _frameNames;
@synthesize relativeLoops = _relativeLoops;

+ (Animation *)animationWithFrameFormat:(NSString *)frameFormat start:(NSInteger)startFrame count:(NSInteger)totalFrames
{
    return [[self alloc] initWithFrameFormat:frameFormat start:startFrame count:totalFrames frameNames:nil];
}

+ (Animation *)animationWithFrameNames:(NSString *)firstName, ...NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, firstName);
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *arg = firstName; arg != nil; arg = va_arg(args, NSString*)) {
        [array addObject:arg];
    }
    va_end(args);
    return [[self alloc] initWithFrameFormat:nil start:-1 count:-1 frameNames:array];
}

- (id)initWithFrameFormat:(NSString *)frameFormat start:(NSInteger)startFrame count:(NSInteger)totalFrames frameNames:(NSArray *)frameNames
{
    if ((self = [super init])) {
        self.frameFormat = frameFormat;
        self.frameNames = frameNames;
        self.startFrame = startFrame;
        self.totalFrames = totalFrames;
        self.delayPerUnit = [CCDirector sharedDirector].animationInterval;
        self.relativeLoops = 1;
        CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        if (self.frameNames != nil) {
            // If frame names are given, load each frame explicitly.
            for (NSString *frameName in self.frameNames) {
                [self addSpriteFrame:[cache spriteFrameByName:frameName]];
            }
        } else if (self.frameFormat != nil) {
            // Otherwise, try to load each frame from start to start + count sequentially.
            // The frame names are based on the given frame format string.
            for (NSUInteger i = 0; i < self.totalFrames; i++) {
                [self addSpriteFrame:[cache spriteFrameByName:[NSString stringWithFormat:self.frameFormat, i + self.startFrame]]];
            }
        } else {
            @throw [NSException exceptionWithName:InvalidAnimationTypeException reason:@"frameNames and frameFormat are both nil.  One of them must be set to do the animation." userInfo:nil];
        }
    }
    return self;
}

- (CCAction *)action
{
    if (self.relativeLoops == 0) {
        return [CCAnimate actionWithAnimation:self];
    }
    switch (self.loopMode)
    {
        case AnimationLoopModeNormal:
            return [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:self] times:self.relativeLoops];
        
        case AnimationLoopModeForwardBounceBack:
            
            return [CCRepeat actionWithAction:[CCSequence actionOne:[CCAnimate actionWithAnimation:self] two:[[CCAnimate actionWithAnimation:self] reverse]] times:self.relativeLoops];
            
        case AnimationLoopModeReverseBounceBack:
            return [CCRepeat actionWithAction:[CCSequence actionOne:[[CCAnimate actionWithAnimation:self] reverse] two:[CCAnimate actionWithAnimation:self]] times:self.relativeLoops];
        
        default:
            @throw [NSException exceptionWithName:InvalidAnimationLoopModeException reason:[NSString stringWithFormat:@"loopMode has to be one of the defined AnimationLoopMode constants, but got: %i", self.loopMode] userInfo:nil];
    }
}

- (CCSpriteFrame *)frameAtIndex:(NSUInteger)index
{
    CCAnimationFrame *animFrame = [self.frames objectAtIndex:index];
    return animFrame.spriteFrame;
}

- (id)copyWithZone:(NSZone *)zone
{
    Animation *copy = [[Animation allocWithZone:zone] initWithFrameFormat:self.frameFormat start:self.startFrame count:self.totalFrames frameNames:self.frameNames];
    copy.relativeLoops = self.relativeLoops;
    copy.loopMode = self.loopMode;
    return copy;
}

@end
