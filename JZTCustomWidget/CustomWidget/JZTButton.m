//
//  JZTButton.m
//
//  Created by 梁泽 on 2017/4/23.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "JZTButton.h"

@interface JZTButton ()


@end

@implementation JZTButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.responseSize = CGSizeMake(44, 44);
        self.titleImageSpace = 6.;
    }
    return self;
}

- (void)setStyle:(JZTButtonImageEdge)style{
    _style = style;
    switch (style) {
        case JZTButtonImageEdgeLeft:
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            break;
        case JZTButtonImageEdgeRight:
            self.titleLabel.textAlignment = NSTextAlignmentRight;
            break;
        case JZTButtonImageEdgeTop:
        case JZTButtonImageEdgeBottom:
        case JZTButtonImageEdgeNone:{
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(self.responseSize.width - bounds.size.width, 0);
    CGFloat heightDelta = MAX(self.responseSize.height - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

- (CGSize)selfImageSize{
    UIImage *image = [self imageForState:UIControlStateNormal];
    if (!image) {
        image = self.currentImage;
    }
    if (!image) {
        return CGSizeZero;
    }
    return image.size;
}

- (CGSize)selfTitleSize{
    NSString *text = [self titleForState:UIControlStateNormal];
    if (!text) {
        text = self.currentTitle;
    }
    if (!text) {
        return CGSizeZero;
    }
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName : self.font}];
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

- (CGSize)selfSize{
    UIEdgeInsets contentInsets = self.contentEdgeInsets;
    CGSize titleSize = [self selfTitleSize];
    CGSize imageSize = [self selfImageSize];
    
    CGFloat width = 0;
    CGFloat height = 0;
    switch (self.style) {
        case JZTButtonImageEdgeLeft:
        case JZTButtonImageEdgeRight:{
            width = titleSize.width + imageSize.width + self.titleImageSpace - contentInsets.left - contentInsets.right;
            height = MAX(titleSize.height, imageSize.height) - contentInsets.top - contentInsets.bottom;
        }
            break;
        case  JZTButtonImageEdgeTop:
        case JZTButtonImageEdgeBottom:{
            width = MAX(titleSize.width, imageSize.width) - contentInsets.left - contentInsets.right;
            height = titleSize.height + imageSize.height + self.titleImageSpace  - contentInsets.top - contentInsets.bottom;
        }
            break;
        case JZTButtonImageEdgeNone:{
            width = MAX(titleSize.width, imageSize.width) - contentInsets.left - contentInsets.right;
            height = MAX(titleSize.height, imageSize.height) - contentInsets.top - contentInsets.bottom;
        }
            break;
    }
    return CGSizeMake(ceil(width), ceil(height));
}

- (CGSize)intrinsicContentSize{
    CGSize size = [self selfSize];
    return size;
}

- (CGRect)contentRectForBounds:(CGRect)bounds {
    CGSize size = [self selfSize];
    return CGRectMake(0, 0, size.width, size.height);
}


// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    UIEdgeInsets contentInsets = self.contentEdgeInsets;
    CGSize titleSize = [self selfTitleSize];
    CGSize imageSize = [self selfImageSize];

    CGRect frame = CGRectZero;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat imageW = imageSize.width;
    CGFloat imageH = imageSize.height;
    switch (self.style) {
        case JZTButtonImageEdgeLeft:
            x = -contentInsets.left;
            y = (contentRect.size.height - imageH) * 0.5f;
            break;
        case JZTButtonImageEdgeRight:{
            x = contentRect.size.width + contentInsets.right - imageW;
            y = (contentRect.size.height - imageH) * 0.5f;
        }
            break;
        case  JZTButtonImageEdgeTop:{
            x = (contentRect.size.width - imageW) * 0.5;
            y = -contentInsets.top;
        }
            break;
        case JZTButtonImageEdgeBottom:{
            x = (contentRect.size.width - imageW) * 0.5;
            y = contentRect.size.height - imageH + contentInsets.top;
        }
            break;
        case JZTButtonImageEdgeNone:{
            x = (contentRect.size.width - imageW)*0.5;
            y = (contentRect.size.height - imageH)*0.5;
        }
            break;
    }
    return CGRectMake(x, y, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    UIEdgeInsets contentInsets = self.contentEdgeInsets;
    CGSize titleSize = [self selfTitleSize];
    CGSize imageSize = [self selfImageSize];

    CGRect frame = CGRectZero;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat labelWidth = titleSize.width;
    CGFloat labelHeight = titleSize.height;
    switch (self.style) {
        case JZTButtonImageEdgeLeft:{
            x = -contentInsets.left + imageSize.width + self.titleImageSpace;
            y = (contentRect.size.height - labelHeight) * 0.5f;
            frame = CGRectMake(x, y, contentRect.size.width - x, labelHeight);
        }
            break;
        case JZTButtonImageEdgeRight:{
            x = 0;
            y = (contentRect.size.height - labelHeight) * 0.5f;
            frame = CGRectMake(x, y, contentRect.size.width + contentInsets.right - imageSize.width - self.titleImageSpace, labelHeight);
        }
            break;
        case  JZTButtonImageEdgeTop:{
            x = 0;
            y = -contentInsets.top + imageSize.height + self.titleImageSpace;
            frame  = CGRectMake(x, y, contentRect.size.width, labelHeight);
        }
            break;
        case JZTButtonImageEdgeBottom:{
            x = 0;
            y = contentRect.size.height - imageSize.height + contentInsets.top - self.titleImageSpace - labelHeight;
            frame  = CGRectMake(x, y, contentRect.size.width, labelHeight);
        }
            break;
        case JZTButtonImageEdgeNone:{
            x =  (contentRect.size.width - labelWidth)*0.5;
            y = (contentRect.size.height - labelHeight)*0.5;
            frame  = CGRectMake(0, 0, contentRect.size.width, contentRect.size.height);
        }
            break;
    }
    return frame;
}

@end
