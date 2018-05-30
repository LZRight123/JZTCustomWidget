//
//  JZTUpDownButton.h
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/5/23.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTUpDownButton : UIControl
@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
///图片文字间隙
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, strong) NSString *badgeValue;

- (void)setImage:(UIImage *)image forState:(UIControlState)state; 
@end
