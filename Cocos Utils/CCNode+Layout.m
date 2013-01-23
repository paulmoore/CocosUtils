//
//  CCNode+Layout.m
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

#import "CCNode+Layout.h"

static float contentWidth = 0, contentHeight = 0;

@implementation CCNode (Layout)

/* Layout Methods.
 * In general, anchor points can be transformed using the formula:
 * x' = x - w(ax - cx)
 * y' = y - h(ay - cy)
 * Where:
 * x = the sprite's reported x position
 * y = the sprite's reported y position
 * x' = the x position with the new anchor point
 * y' = the y position with the new anchor point
 * w = the sprite's width
 * h = the sprite's height
 * ax = the sprite's x anchor point
 * ay = the sprite's y anchor point
 * cx = the new x anchor point you want
 * cy = the new y anchor point you want
 * This maintains the sprite's position while changing the anchor point to make layout calculations easier.
 */

+ (float)contentScreenWidth
{
    return contentWidth;
}

+ (void)setContentScreenWidth:(float)width
{
    contentWidth = width;
}

+ (float)contentScreenHeight
{
    return contentHeight;
}

+ (void)setContentScreenHeight:(float)height
{
    contentHeight = height;
}

- (CGPoint)center
{
    CGPoint p = self.position, a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x - s.width * (a.x - 0.5);
    p.y = p.y - s.height * (a.y - 0.5);
    return p;
}

- (CGPoint)centerBottom
{
    CGPoint p = self.position, a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x - s.width * (a.x - 0.5);
    p.y = p.y - s.height * a.y;
    return p;
}

- (void)translateWithOffsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = self.position;
    p.x += dx;
    p.y += dy;
    self.position = p;
}

- (CGPoint)centerTop
{
    CGPoint p = self.position, a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x - s.width * (a.x - 0.5);
    p.y = p.y - s.height * (a.y - 1);
    return p;
}

- (CGPoint)centerLeft
{
    CGPoint p = self.position, a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x - s.width * a.x;
    p.y = p.y - s.height * (a.y - 0.5);
    return p;
}

- (CGPoint)centerRight
{
    CGPoint p = self.position, a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x - s.width * (a.x - 1);
    p.y = p.y - s.height * (a.y - 0.5);
    return p;
}

- (CGPoint)topLeft
{
    CGPoint p = self.position, a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x - s.width * a.x;
    p.y = p.y - s.height * (a.y - 1);
    return p;
}

- (CGPoint)topRight
{
    CGPoint p = self.position, a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x - s.width * (a.x - 1);
    p.y = p.y - s.height * (a.y - 1);
    return p;
}

- (CGPoint)bottomLeft
{
    CGPoint p = self.position, a = self.anchorPoint;
    CGSize s = self.boundingBox.size;//self.contentSize;
    p.x = p.x - s.width * a.x;
    p.y = p.y - s.height * a.y;
    return p;
}

- (CGPoint)bottomRight
{
    CGPoint p = self.position, a = self.anchorPoint;
    CGSize s = self.boundingBox.size;//self.contentSize;
    p.x = p.x - s.width * (a.x - 1);
    p.y = p.y - s.height * a.y;
    return p;
}

- (CGPoint)localFromCenter:(CGPoint)p
{
    CGPoint a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x + s.width * (a.x - 0.5);
    p.y = p.y + s.height * (a.y - 0.5);
    return p;
}

- (CGPoint)localFromCenterBottom:(CGPoint)p
{
    CGPoint a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x + s.width * (a.x - 0.5);
    p.y = p.y + s.height * a.y;
    return p;
}

- (CGPoint)localFromCenterTop:(CGPoint)p
{
    CGPoint a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x + s.width * (a.x - 0.5);
    p.y = p.y + s.height * (a.y - 1);
    return p;
}

- (CGPoint)localFromCenterLeft:(CGPoint)p
{
    CGPoint a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x + s.width * a.x;
    p.y = p.y + s.height * (a.y - 0.5);
    return p;
}

- (CGPoint)localFromCenterRight:(CGPoint)p
{
    CGPoint a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x + s.width * (a.x - 1);
    p.y = p.y + s.height * (a.y - 0.5);
    return p;
}

- (CGPoint)localFromTopLeft:(CGPoint)p
{
    CGPoint a = self.anchorPoint;
    CGSize s = self.boundingBox.size;//self.contentSize;
    p.x = p.x + s.width * a.x;
    p.y = p.y + s.height * (a.y - 1);
    return p;
}

- (CGPoint)localFromTopRight:(CGPoint)p
{
    CGPoint a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x + s.width * (a.x - 1);
    p.y = p.y + s.height * (a.y - 1);
    return p;
}

- (CGPoint)localFromBottomLeft:(CGPoint)p
{
    CGPoint a = self.anchorPoint;
    CGSize s = self.boundingBox.size;//self.contentSize;
    p.x = p.x + s.width * a.x;
    p.y = p.y + s.height * a.y;
    return p;
}

- (CGPoint)localFromBottomRight:(CGPoint)p
{
    CGPoint a = self.anchorPoint;
    CGSize s = self.contentSize;
    p.x = p.x + s.width * (a.x - 1);
    p.y = p.y + s.height * a.y;
    return p;
}

- (void)layoutInCenter
{
    [self layoutInCenterWithOffsetX:0 offsetY:0];
}

- (void)layoutInCenterWithOffsetX:(float)dx offsetY:(float)dy
{
    CGSize size = self.parent.contentSize;
    CGPoint p = ccp(size.width / 2 + dx, size.height / 2 + dy);
    self.position = [self localFromCenter:p];
}

- (void)alignScreenTop
{
    [self alignScreenTopWithOffsetX:0 offsetY:0];
}

- (void)alignScreenTopWithOffsetX:(float)dx offsetY:(float)dy
{
    CGSize size = self.parent.contentSize;
    CGPoint p = [self localFromTopLeft:ccp(0, size.height + dy)];
    p.x = self.position.x + dx;
    self.position = p;
}

- (void)alignContentScreenTop
{
    [self alignContentScreenTopWithOffsetX:0 offsetY:0];
}

- (void)alignContentScreenTopWithOffsetX:(float)dx offsetY:(float)dy
{
    CGSize size = self.parent.contentSize;
    CGPoint center = ccp(size.width / 2, size.height / 2);
    CGPoint p = ccp(center.x - contentWidth / 2.0, center.y + contentHeight / 2.0);
    p = [self localFromTopLeft:p];
    p.x = self.position.x + dx;
    p.y += dy;
    self.position = p;
}

- (void)alignContentScreenBottom
{
    [self alignContentScreenBottomWithOffsetX:0 offsetY:0];
}

- (void)alignContentScreenBottomWithOffsetX:(float)dx offsetY:(float)dy
{
    CGSize size = self.parent.contentSize;
    CGPoint center = ccp(size.width / 2, size.height / 2);
    CGPoint p = ccp(center.x - contentWidth / 2.0, center.y - contentHeight / 2.0);
    p = [self localFromBottomLeft:p];
    p.x = self.position.x + dx;
    p.y += dy;
    self.position = p;
}

- (void)alignScreenBottom
{
    [self alignScreenBottomWithOffsetX:0 offsetY:0];
}

- (void)alignScreenBottomWithOffsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = [self localFromBottomLeft:ccp(0, dy)];
    p.x = self.position.x + dx;
    self.position = p;
}

- (void)alignScreenRight
{
    [self alignScreenRightWithOffsetX:0 offsetY:0];
}

- (void)alignScreenRightWithOffsetX:(float)dx offsetY:(float)dy
{
    CGSize size = self.parent.contentSize;
    CGPoint p = [self localFromBottomRight:ccp(size.width + dx, 0)];
    p.y = self.position.y + dy;
    self.position = p;
}

- (void)alignScreenLeft
{
    [self alignScreenLeftWithOffsetX:0 offsetY:0];
}

- (void)alignScreenLeftWithOffsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = [self localFromBottomLeft:ccp(dx, 0)];
    p.y = self.position.y + dy;
    self.position = p;
}

- (void)layoutBelow:(CCNode *)other
{
    [self layoutBelow:other offsetX:0 offsetY:0];
}

- (void)layoutBelow:(CCNode *)other offsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = other.bottomLeft;
    p = [self localFromTopLeft:p];
    p.x = self.position.x + dx;
    p.y += dy;
    self.position = p;
}

- (void)layoutAbove:(CCNode *)other
{
    [self layoutAbove:other offsetX:0 offsetY:0];
}

- (void)layoutAbove:(CCNode *)other offsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = other.topLeft;
    p = [self localFromBottomLeft:p];
    p.x = self.position.x + dx;
    p.y += dy;
    self.position = p;
}

- (void)layoutToLeftOf:(CCNode *)other
{
    [self layoutToLeftOf:other offsetX:0 offsetY:0];
}

- (void)layoutToLeftOf:(CCNode *)other offsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = other.bottomLeft;
    p = [self localFromBottomRight:p];
    p.x += dx;
    p.y = self.position.y + dy;
    self.position = p;
}

- (void)layoutToRightOf:(CCNode *)other
{
    [self layoutToRightOf:other offsetX:0 offsetY:0];
}

- (void)layoutToRightOf:(CCNode *)other offsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = other.bottomRight;
    p = [self localFromBottomLeft:p];
    p.x += dx;
    p.y = self.position.y + dy;
    self.position = p;
}

- (void)alignHorizontal:(CCNode *)other
{
    [self alignHorizontal:other offsetX:0 offsetY:0];
}

- (void)alignHorizontal:(CCNode *)other offsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = other.centerBottom;
    p = [self localFromCenterBottom:p];
    p.x += dx;
    p.y = self.position.y + dy;
    self.position = p;
}

- (void)alignVertical:(CCNode *)other
{
    [self alignVertical:other offsetX:0 offsetY:0];
}

- (void)alignVertical:(CCNode *)other offsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = other.centerLeft;
    p = [self localFromCenterLeft:p];
    p.y += dy;
    p.x = self.position.x + dx;
    self.position = p;
}

- (void)alignTop:(CCNode *)other
{
    [self alignTop:other offsetX:0 offsetY:0];
}

- (void)alignTop:(CCNode *)other offsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = other.topLeft;
    p = [self localFromTopLeft:p];
    p.x = self.position.x + dx;
    p.y += dy;
    self.position = p;
}

- (void)alignBottom:(CCNode *)other
{
    [self alignBottom:other offsetX:0 offsetY:0];
}

- (void)alignBottom:(CCNode *)other offsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = other.bottomLeft;
    p = [self localFromBottomLeft:p];
    p.x = self.position.x + dx;
    p.y += dy;
    self.position = p;
}

- (void)alignLeft:(CCNode *)other
{
    [self alignLeft:other offsetX:0 offsetY:0];
}

- (void)alignLeft:(CCNode *)other offsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = other.bottomLeft;
    p = [self localFromBottomLeft:p];
    p.x += dx;
    p.y = self.position.y + dy;
    self.position = p;
}

- (void)alignRight:(CCNode *)other
{
    [self alignRight:other offsetX:0 offsetY:0];
}

- (void)alignRight:(CCNode *)other offsetX:(float)dx offsetY:(float)dy
{
    CGPoint p = other.bottomRight;
    p = [self localFromBottomRight:p];
    p.x += dx;
    p.y = self.position.y + dy;
    self.position = p;
}

@end
