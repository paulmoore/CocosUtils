//
//  TouchDistributor.m
//  Cocos Utils
//
//  NOTE: This library is ARC enabled.
//
//  Created by Paul Moore on 2012-11-01.
//
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

#import "TouchDistributor.h"

#pragma mark - Private APIs

/**
 * A node for a registered node.
 */
@interface TDNode : NSObject

/** The callback target. */
@property (nonatomic, strong) id target;
/** The registered node. */
@property (nonatomic, strong) CCNode *node;
/** The selector to perform when a touch event occurs on the node. */
@property (nonatomic) SEL selector;
/** YES if a touch event has began (and not ended or cancelled) on this node. */
@property (nonatomic) BOOL isTouched;

@end

@interface TouchDistributor ()

@property (nonatomic, strong) NSMutableArray *nodes;

@end

#pragma mark - Implementations

@implementation CCNode (Touch)

- (BOOL)isTouchedBy:(UITouch *)touch
{
    CGRect r = CGRectZero;
    r.size = self.contentSize;
    return CGRectContainsPoint(r, [self convertTouchToNodeSpace:touch]);
}

@end

@implementation TDNode

@synthesize target = _target, node = _node, selector = _selector;

+ (TDNode *)nodeWithNode:(CCNode *)node target:(id)target selector:(SEL)selector
{
    return [[self alloc] initWithNode:node target:target selector:selector];
}

- (id)initWithNode:(CCNode *)node target:(id)target selector:(SEL)selector
{
    if ((self = [super init])) {
        self.node = node;
        self.target = target;
        self.selector = selector;
    }
    return self;
}

- (void)dealloc
{
    self.selector = nil;
}

@end

@implementation TouchDistributor

@synthesize nodes = _nodes;

+ (TouchDistributor *)distributor
{
    return [self new];
}

- (id)init
{
    if ((self = [super init])) {
        self.nodes = [NSMutableArray array];
    }
    return self;
}

- (void)registerNode:(CCNode *)node target:(id)target selector:(SEL)selector
{
    TDNode *tdNode = [TDNode nodeWithNode:node target:target selector:selector];
    [self.nodes addObject:tdNode];
}

- (BOOL)unregisterNode:(CCNode *)node
{
    for (NSUInteger i = 0; i < self.nodes.count; i++) {
        TDNode *tdNode = [self.nodes objectAtIndex:i];
        if (tdNode.node == node) {
            [self.nodes removeObjectAtIndex:i];
            return YES;
        }
    }
    return NO;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL success = NO;
    for (NSInteger i = self.nodes.count - 1; i >= 0; i--) {
        TDNode *tdNode = [self.nodes objectAtIndex:i];
        if ([tdNode.node isTouchedBy:touch]) {
            tdNode.isTouched = YES;
            [tdNode.target performSelector:tdNode.selector withObject:tdNode.node withObject:touch];
            success = YES;
        }
    }
    return success;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    for (NSInteger i = self.nodes.count - 1; i >= 0; i--) {
        TDNode *tdNode = [self.nodes objectAtIndex:i];
        // Nodes that were touched in the began phase will always receive an end event.
        // Nodes that are on the touch point also receive an end event.
        if ([tdNode.node isTouchedBy:touch] || tdNode.isTouched) {
            tdNode.isTouched = NO;
            [tdNode.target performSelector:tdNode.selector withObject:tdNode.node withObject:touch];
        }
    }
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    for (NSInteger i = self.nodes.count - 1; i >= 0; i--) {
        TDNode *tdNode = [self.nodes objectAtIndex:i];
        // Only nodes that were touched in the began phase need to receive a cancelled event.
        if (tdNode.isTouched) {
            tdNode.isTouched = NO;
            [tdNode.target performSelector:tdNode.selector withObject:tdNode.node withObject:touch];
        }
    }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    for (NSInteger i = self.nodes.count - 1; i >= 0; i--) {
        TDNode *tdNode = [self.nodes objectAtIndex:i];
        if (tdNode.isTouched) {
            [tdNode.target performSelector:tdNode.selector withObject:tdNode.node withObject:touch];
        }
    }
}

- (void)unregisterAll
{
    [self.nodes removeAllObjects];
}

- (BOOL)isTouchEnabled
{
    return isTouchEnabled_;
}

- (void)setIsTouchEnabled:(BOOL)isTouchEnabled
{
    isTouchEnabled_ = isTouchEnabled;
    if (isTouchEnabled) {
        [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:0 swallowsTouches:YES];
    } else {
        [[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
    }
}

@end
