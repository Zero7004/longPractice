//
//  UIView+SLSetFrame.m
//  SLStaticLibrary
//

#import "UIView+SLSetFrame.h"


@implementation UIView (SLSetFrame)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (void)setFrameX:(CGFloat)x {
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameWidth:(CGFloat)width {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)setFrameHeight:(CGFloat)height {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}


- (void)setFrameX:(CGFloat)x y:(CGFloat)y {
    self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameX:(CGFloat)x width:(CGFloat)width {
    self.frame = CGRectMake(x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)setFrameX:(CGFloat)x height:(CGFloat)height {
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, height);
}

- (void)setFrameY:(CGFloat)y width:(CGFloat)width {
    self.frame = CGRectMake(self.frame.origin.x, y, width, self.frame.size.height);
}

- (void)setFrameY:(CGFloat)y height:(CGFloat)height {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, height);
}

- (void)setFrameWidth:(CGFloat)width height:(CGFloat)height {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
}


- (void)setFrameX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width {
    self.frame = CGRectMake(x, y, width, self.frame.size.height);
}

- (void)setFrameX:(CGFloat)x y:(CGFloat)y height:(CGFloat)height {
    self.frame = CGRectMake(x, y, self.frame.size.width, height);
}

- (void)setFrameX:(CGFloat)x width:(CGFloat)width height:(CGFloat)height {
    self.frame = CGRectMake(x, self.frame.origin.y, width, height);
}

- (void)setFrameY:(CGFloat)y width:(CGFloat)width height:(CGFloat)height {
    self.frame = CGRectMake(self.frame.origin.x, y, width, height);
}

- (void)setCenterX:(CGFloat)x
{
    self.center = CGPointMake(x, self.center.y);
}

- (void)setCenterY:(CGFloat)y
{
    self.center = CGPointMake(self.center.x, y);
}

#pragma mark - Init
- (id)initWithSize:(CGSize)size
{
    CGRect rect = (CGRect){CGPointZero, size};
    return [self initWithFrame:rect];
}

- (void)setPosition:(CGPoint)point atAnchorPoint:(CGPoint)anchorPoint
{
    CGFloat x = point.x - anchorPoint.x * self.frame.size.width;
    CGFloat y = point.y - anchorPoint.y * self.frame.size.height;
    [self setOrigin:CGPointMake(x, y)];
}

//- (void)setOrigin:(CGPoint)origin
//{
//    self.frame = (CGRect){origin, self.frame.size};
//}
@end
