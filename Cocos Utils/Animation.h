//
//  Animation.h
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

#pragma mark - Animation Constants

/** Thrown if you send an invalid argument to an Animation's constructor. */
static NSString* const InvalidAnimationTypeException = @"InvalidAnimationTypeException";
static NSString* const InvalidAnimationLoopModeException = @"InvalidAnimationLoopModeException";

/** The Animation plays forward. */
static const NSInteger AnimationLoopModeNormal = 0;
/** The Animation plays forward then backward. */
static const NSInteger AnimationLoopModeForwardBounceBack = 1;
/** The Animation plays backward then forward. */
static const NSInteger AnimationLoopModeReverseBounceBack = -1;

#pragma mark - Interfaces

/**
 * An Animation that makes it easier to set up animation sequences.
 * All texture frames need to first be loaded with CCSpriteFrameCache.
 */
@interface Animation : CCAnimation

/** A loop mode which determines how the animation plays, see constants for details. */
@property (nonatomic) NSInteger loopMode;
/** This is the amount of loops the animation will play for relative to the loop mode.  This should always be used instead of setting the loops property. */
@property (nonatomic) NSUInteger relativeLoops;
/** The start frame and total amount of frames in the animation sequence. */
@property (nonatomic, readonly) NSInteger startFrame, totalFrames;
/** The names, in correct order, of the texture frames in this animation. */
@property (nonatomic, readonly, strong) NSArray *frameNames;
/** The frame format used to load the frames. */
@property (nonatomic, readonly, strong) NSString *frameFormat;

/**
 * Creates an autoreleased animation that is based on a linear sequence of frames.
 *
 * @param frameFormat The frameformat used to find the frames, i.e. 'frame%i.png'.
 * @param startFrame The starting (inclusive) frame number of the sequence.
 * @param totalFrames The total count of frames in the sequence.
 * @return The new Animation.
 */
+ (Animation *)animationWithFrameFormat:(NSString *)frameFormat start:(NSInteger)startFrame count:(NSInteger)totalFrames;

/**
 * Creates an autoreleased animation that is based on a list of frame names.
 *
 * @param firstName The first frame name, in full.
 * @param ... The rest of the frame names in order, nil terminated.
 * @return The new Animation.
 */
+ (Animation *)animationWithFrameNames:(NSString *)firstName, ...NS_REQUIRES_NIL_TERMINATION;

- (id)initWithFrameFormat:(NSString *)frameFormat start:(NSInteger)startFrame count:(NSInteger)totalFrames frameNames:(NSArray *)frameNames;

/**
 * Generates the appropriate Action for this Animation.
 * The Action is based on the loops and loopMode properties, in addition to the loaded frames.
 *
 * @return The Action that can be run on a sprite to produce the animation.
 */
- (CCAction *)action;

/**
 * Gets the sprite frame at the given index of this animation.
 *
 * @param index The 0 based index.
 * @return The sprite frame at that index.
 */
- (CCSpriteFrame *)frameAtIndex:(NSUInteger)index;

@end
