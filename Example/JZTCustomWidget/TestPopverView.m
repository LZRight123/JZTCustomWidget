//
//  TestPopverView.m
//  JZTCustomWidget
//
//  Created by 梁泽 on 2018/6/21.
//  Copyright © 2018年 梁泽. All rights reserved.
//

#import "TestPopverView.h"
@interface TestPopverView()
@end


@implementation TestPopverView
@synthesize arrowOffset = _arrowOffset;
@synthesize arrowDirection = _arrowDirection;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIPopoverArrowDirection ss = self.arrowDirection;
    CGSize arrowSize = CGSizeMake([[self class] arrowBase], [[self class] arrowHeight]);
    UIImage * image  = [self drawArrowImage:arrowSize];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake((self.frame.size.width - arrowSize.width)/2., 0.0f, arrowSize.width, arrowSize.height);
    [self addSubview:imageView];
    
    UIImageView *imv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sfsfsf"]];
    imv.frame = CGRectMake(0, [[self class] arrowHeight], self.frame.size.width, self.frame.size.height - [[self class] arrowHeight]);
    [self addSubview:imv];
    
}

- (void)setArrowOffset:(CGFloat)arrowOffset{
    _arrowOffset = arrowOffset;
}

- (void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection{
    _arrowDirection = arrowDirection;
}

+ (CGFloat)arrowBase{
    return 30;
}

+ (UIEdgeInsets)contentViewInsets{
    return UIEdgeInsetsZero;
}

+ (CGFloat)arrowHeight{
    return 50;
}

- (UIImage *)drawArrowImage:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] setFill];
    CGContextFillRect(ctx, CGRectMake(0.0f, 0.0f, size.width, size.height));
    CGMutablePathRef arrowPath = CGPathCreateMutable();
    CGPathMoveToPoint(arrowPath, NULL, (size.width/2.0f), 0.0f);
    CGPathAddLineToPoint(arrowPath, NULL, size.width, size.height);
    CGPathAddLineToPoint(arrowPath, NULL, 0.0f, size.height);
    CGPathCloseSubpath(arrowPath);
    CGContextAddPath(ctx, arrowPath);
    CGPathRelease(arrowPath);
    UIColor *fillColor = [UIColor yellowColor];
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
