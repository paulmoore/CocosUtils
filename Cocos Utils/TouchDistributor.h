//
//  TouchDistributor.h
//  Cocos Utils
//
//  NOTE: This library is ARC enabled.
//
//  Created by Paul Moore on 2012-11-01.
//  Copyright (c) 2012 Strange Ideas Software. All rights reserved.
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

@interface CCNode (Touch)

/**
 * Checks if this touch touches the node.
 *
 * @param touch The touch to test.
 * @return YES if a touch is contained by the bounds of this node.
 */
- (BOOL)isTouchedBy:(UITouch *)touch;

@end

/**
 * An alternate targeted touch delegate.
 * Automatically tracks up, down, move, and cancel move events on specific nodes.
 */
@interface TouchDistributor : NSObject <CCTargetedTouchDelegate>
{
    @private
    BOOL isTouchEnabled_;
}

/** Gets or sets if this touch delegate is enabled. */
@property (nonatomic) BOOL isTouchEnabled;

/**
 * Creates an autoreleased touch distributor.
 *
 * @return The new touch distributor.
 */
+ (TouchDistributor *)distributor;

/**
 * Registers a new node to be managed by the distributor.
 * The node is retained.
 *
 * @param node The node to manage.
 * @param target The target to perform the selector on.
 * @param selector The selector that is performed when a touch event occurs on the node.
 */
- (void)registerNode:(CCNode *)node target:(id)target selector:(SEL)selector;

- (BOOL)unregisterNode:(CCNode *)node;

/**
 * Unregisters all nodes.
 * This should be called so the nodes are released.
 */
- (void)unregisterAll;

@end
