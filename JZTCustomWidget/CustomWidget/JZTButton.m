//
//  JZTButton.m
//  ImageTitleSpacing
//
//  Created by yanmingjun on 2017/4/23.
//  Copyright © 2017年 yanmingjun. All rights reserved.
//

#import "JZTButton.h"

@interface JZTButton ()

@property (nonatomic) JZTButtonEdgeInsetsStyle style;

@property (nonatomic) CGFloat space;

//@property (nonatomic, strong) UIFont *font;

@end

@implementation JZTButton
+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    JZTButton *button = [super buttonWithType:buttonType];
    button.responseSize = CGSizeMake(44, 44);
    return button;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(self.responseSize.width - bounds.size.width, 0);
    CGFloat heightDelta = MAX(self.responseSize.height - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

- (void)layoutButtonWithEdgeInsetsStyle:(JZTButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    self.style = style;
    self.space = space;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (CGSize)intrinsicContentSize {
    JZTButtonEdgeInsetsStyle style = self.style;
    CGFloat space = self.space;
    CGSize size = [super intrinsicContentSize];
    
    // 1. 得到imageView和titleLabel的宽、高
    UIImage *image = self.currentImage;
    CGFloat imageWith = image.size.width;
    CGFloat imageHeight = image.size.height;
    
    NSString *text = self.currentTitle;
    CGSize labelSize = [text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGFloat labelWidth = labelSize.width;
    CGFloat labelHeight = labelSize.height;
    
    
    CGFloat width = size.width;
    CGFloat height = size.height;
    switch (style) {
        case JZTButtonEdgeInsetsStyleTop:
        case JZTButtonEdgeInsetsStyleBottom:
        {
            height = imageHeight + labelHeight + space;
            width = MAX(imageWith, labelWidth);
        }
            break;
        case JZTButtonEdgeInsetsStyleLeft:
        case JZTButtonEdgeInsetsStyleRight:
        {
            width = imageWith + labelWidth + space;
        }
            break;
            break;
        default:
            break;
    }
    
    return CGSizeMake(width, height);
}

- (CGRect)contentRectForBounds:(CGRect)bounds {
    return bounds;
}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect frame = CGRectZero;
    CGSize size = self.currentImage.size;
    CGFloat imageW = size.width;
    CGFloat imageH = size.height;
    switch (self.style) {
        case JZTButtonEdgeInsetsStyleLeft:
            frame = CGRectMake(_space/2.0f, (contentRect.size.height - imageH) * 0.5f, imageW, imageH);
            break;
        case JZTButtonEdgeInsetsStyleRight:{
            frame = CGRectMake(contentRect.size.width - imageW - _space/2.0f, (contentRect.size.height - imageH) * 0.5f, imageW, imageH);
        }
            break;
        case  JZTButtonEdgeInsetsStyleTop:{
            frame  = CGRectMake((contentRect.size.width - imageW) * 0.5,0, imageW, imageH);
        }
            break;
        case JZTButtonEdgeInsetsStyleBottom:{
            frame  = CGRectMake((contentRect.size.width - imageW) * 0.5, contentRect.size.height - imageH, imageW, imageH);
        }
            break;
    }
    return frame;
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect frame = CGRectZero;
    NSString *text = self.currentTitle;
    CGSize labelSize = [text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGFloat labelWidth = labelSize.width;
    CGFloat labelHeight = labelSize.height;
    
    switch (self.style) {
        case JZTButtonEdgeInsetsStyleLeft:{
            frame = CGRectMake(contentRect.size.width - labelWidth - _space/2.0f, (contentRect.size.height - labelHeight) * 0.5f, labelWidth, labelHeight);
        }
            break;
        case JZTButtonEdgeInsetsStyleRight:{
            frame = CGRectMake(_space/2.0f, (contentRect.size.height - labelHeight) * 0.5f, labelWidth, labelHeight);
        }
            break;
        case  JZTButtonEdgeInsetsStyleTop:{
            frame  = CGRectMake((contentRect.size.width - labelWidth) * 0.5, contentRect.size.height - labelHeight, labelWidth, labelHeight);
        }
            break;
        case JZTButtonEdgeInsetsStyleBottom:{
            frame  = CGRectMake((contentRect.size.width - labelWidth) * 0.5, 0, labelWidth, labelHeight);
        }
            break;
    }
    return frame;
}

// 重写去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted {}
@end
