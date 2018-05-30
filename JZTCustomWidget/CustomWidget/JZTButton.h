//
//  JZTButton.h
//  ImageTitleSpacing
//
//  Created by yanmingjun on 2017/4/23.
//  Copyright © 2017年 yanmingjun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JZTButtonEdgeInsetsStyle) {
    JZTButtonEdgeInsetsStyleLeft, // image在左，label在右
    JZTButtonEdgeInsetsStyleRight, // image在右，label在左
    JZTButtonEdgeInsetsStyleTop, // image在上，label在下
    JZTButtonEdgeInsetsStyleBottom, // image在下，label在上
};

@interface JZTButton : UIButton

@property (nonatomic) CGSize responseSize;
+ (instancetype)buttonWithType:(UIButtonType)buttonType;
/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(JZTButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
