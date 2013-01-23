//
//  CCNode+Layout.h
//  Cocos Utils
//
//  NOTE: This library is ARC enabled.
//
//  Created by Paul Moore on 2012-11-01.
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

/**
 * Node extension methods with some handy layout methods and other utilities.
 */
@interface CCNode (Layout)

/** The local center-x,y point of this node. */
@property (nonatomic, readonly) CGPoint center;
/** The local bottom-y center-x point of this node. */
@property (nonatomic, readonly) CGPoint centerBottom;
/** @return The top-y center-x point of this node. */
@property (nonatomic, readonly) CGPoint centerTop;
/** @return The left-x center-y point of this node. */
@property (nonatomic, readonly) CGPoint centerLeft;
/** The right-x center-y point of this node. */
@property (nonatomic, readonly) CGPoint centerRight;
/** The top-y left-x point of this node. */
@property (nonatomic, readonly) CGPoint topLeft;
/** The top-y right-x point of this node. */
@property (nonatomic, readonly) CGPoint topRight;
/** The bottom-y left-x point of this node. */
@property (nonatomic, readonly) CGPoint bottomLeft;
/** The bottom-y right-x point of this node. */
@property (nonatomic, readonly) CGPoint bottomRight;

/**
 * @return The width the content (may or may not be the full size) of the screen.
 */
+ (float)contentScreenWidth;

/**
 * Sets the width the screen content size.
 * Useful if you want to letterbox your App for larger screens.
 *
 * @param width The width of the screen content.
 */
+ (void)setContentScreenWidth:(float)width;

/**
 * @return The height the content (may or may not be the full size) of the screen.
 */
+ (float)contentScreenHeight;

/**
 * Sets the height the screen content size.
 * Useful if you want to letterbox your App for larger screens.
 *
 * @param width The width of the screen content.
 */
+ (void)setContentScreenHeight:(float)height;

/**
 * Moves this nodes position by an x and y offset.
 *
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)translateWithOffsetX:(float)dx offsetY:(float)dy;

/**
 * Transforms a center point into the node's local coordinates and anchor.
 *
 * @param p The center point
 * @return The localized point.
 */
- (CGPoint)localFromCenter:(CGPoint)p;

/**
 * Transforms a bottom center point into the node's local coordinates and anchor.
 *
 * @param p The bottom center point.
 * @return The localized point.
 */
- (CGPoint)localFromCenterBottom:(CGPoint)p;

/**
 * Transforms a top center point into the node's local coordinates and anchor.
 *
 * @param p The top center point.
 * @return The localized point.
 */
- (CGPoint)localFromCenterTop:(CGPoint)p;

/**
 * Transforms a left center point into the node's local coordinates and anchor.
 *
 * @param p The left center point.
 * @return The localized point.
 */
- (CGPoint)localFromCenterLeft:(CGPoint)p;

/**
 * Transforms a right center point into the node's local coordinates and anchor.
 *
 * @param p The right center point.
 * @return The localized point.
 */
- (CGPoint)localFromCenterRight:(CGPoint)p;

/**
 * Transforms a top left point into the node's local coordinates and anchor.
 *
 * @param p The left top point.
 * @return The localized point.
 */
- (CGPoint)localFromTopLeft:(CGPoint)p;

/**
 * Transforms a top right point into the node's local coordinates and anchor.
 *
 * @param p The right top point.
 * @return The localized point.
 */
- (CGPoint)localFromTopRight:(CGPoint)p;

/**
 * Transforms a bottom left point into the node's local coordinates and anchor.
 *
 * @param p The bottom left point.
 * @return The localized point.
 */
- (CGPoint)localFromBottomLeft:(CGPoint)p;

/**
 * Transforms a bottom right point into the node's local coordinates and anchor.
 *
 * @param p The bottom right point.
 * @return The localized point.
 */
- (CGPoint)localFromBottomRight:(CGPoint)p;

/**
 * Centers the node within the window.
 */
- (void)layoutInCenter;

/**
 * Centers the node within the window.
 *
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)layoutInCenterWithOffsetX:(float)dx offsetY:(float)dy;

/**
 * Align the top of the node with the top of the screen.
 */
- (void)alignScreenTop;

/**
 * Align the top of the node with the top of the screen.
 *
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignScreenTopWithOffsetX:(float)dx offsetY:(float)dy;

/**
 * Align the bottom of the node with the bottom of the screen.
 */
- (void)alignScreenBottom;

/**
 * Align the bottom of the node with the bottom of the screen.
 *
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignScreenBottomWithOffsetX:(float)dx offsetY:(float)dy;

/**
 * Align the top of the node with the top of the screen content.
 */
- (void)alignContentScreenTop;

/**
 * Align the top of the node with the top of the screen content.
 *
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignContentScreenTopWithOffsetX:(float)dx offsetY:(float)dy;

/**
 * Align the bottom of the node with the bottom of the screen content.
 */
- (void)alignContentScreenBottom;

/**
 * Align the bottom of the node with the bottom of the screen content.
 *
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignContentScreenBottomWithOffsetX:(float)dx offsetY:(float)dy;

/**
 * Align the right side of the node with the right side of the screen.
 */
- (void)alignScreenRight;

/**
 * Align the right side of the node with the right side of the screen.
 *
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignScreenRightWithOffsetX:(float)dx offsetY:(float)dy;

/**
 * Align the left side of the node with the left side of the screen.
 */
- (void)alignScreenLeft;

/**
 * Align the left side of the node with the left side of the screen.
 *
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignScreenLeftWithOffsetX:(float)dx offsetY:(float)dy;

/**
 * Layout this node below the other node.
 *
 * @param other The other node.
 */
- (void)layoutBelow:(CCNode *)other;

/**
 * Layout this node below the other node.
 *
 * @param other The other node.
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)layoutBelow:(CCNode *)other offsetX:(float)dx offsetY:(float)dy;

/**
 * Layout this node above the other node.
 *
 * @param other The other node.
 */
- (void)layoutAbove:(CCNode *)other;

/**
 * Layout this node above the other node.
 *
 * @param other The other node.
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)layoutAbove:(CCNode *)other offsetX:(float)dx offsetY:(float)dy;

/**
 * Layout this node to the left of the other node.
 *
 * @param other The other node.
 */
- (void)layoutToLeftOf:(CCNode *)other;

/**
 * Layout this node to the left of the other node.
 *
 * @param other The other node.
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)layoutToLeftOf:(CCNode *)other offsetX:(float)dx offsetY:(float)dy;

/**
 * Layout to the right of the other node.
 *
 * @param other The other node.
 */
- (void)layoutToRightOf:(CCNode *)other;

/**
 * Layout to the right of the other node.
 *
 * @param other The other node.
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)layoutToRightOf:(CCNode *)other offsetX:(float)dx offsetY:(float)dy;

/**
 * Horizontally aligns this node with the other node.
 *
 * @param other The other node.
 */
- (void)alignHorizontal:(CCNode *)other;

/**
 * Horizontally aligns this node with the other node.
 *
 * @param other The other node.
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignHorizontal:(CCNode *)other offsetX:(float)dx offsetY:(float)dy;

/**
 * Vertically aligns this node with the other node.
 *
 * @param other The other node.
 */
- (void)alignVertical:(CCNode *)other;

/**
 * Vertically aligns this node with the other node.
 *
 * @param other The other node.
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignVertical:(CCNode *)other offsetX:(float)dx offsetY:(float)dy;

/**
 * Aligns the top of the node with the top of the other node.
 */
- (void)alignTop:(CCNode *)other;

/**
 * Aligns the top of the node with the top of the other node.
 *
 * @param other The other node.
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignTop:(CCNode *)other offsetX:(float)dx offsetY:(float)dy;

/**
 * Aligns the bottom of the node with the bottom of the other node.
 */
- (void)alignBottom:(CCNode *)other;

/**
 * Aligns the bottom of the node with the bottom of the other node.
 *
 * @param other The other node.
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignBottom:(CCNode *)other offsetX:(float)dx offsetY:(float)dy;

/**
 * Aligns the left side of the node with the left side of the other node.
 */
- (void)alignLeft:(CCNode *)other;

/**
 * Aligns the left side of the node with the left side of the other node.
 *
 * @param other The other node.
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignLeft:(CCNode *)other offsetX:(float)dx offsetY:(float)dy;

/**
 * Aligns the right side of the node with the right side of the other node.
 */
- (void)alignRight:(CCNode *)other;

/**
 * Aligns the right side of the node with the right side of the other node.
 *
 * @param other The other node.
 * @param dx The x offset.
 * @param dy The y offset.
 */
- (void)alignRight:(CCNode *)other offsetX:(float)dx offsetY:(float)dy;

@end
