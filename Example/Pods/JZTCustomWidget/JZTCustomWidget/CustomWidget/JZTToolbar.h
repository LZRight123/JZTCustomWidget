//
//  JZTToolbar.h
//  qmyios
//
//  Created by 梁泽 on 2017/11/14.
//  Copyright © 2017年 九州通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTToolbar : UIView
@property(nonatomic,assign,getter=isTranslucent) BOOL translucent;//default is no
@property (nonatomic, assign) UIBlurEffectStyle effectSyle;//when translucent is yes,default is UIBlurEffectStyleExtraLight
@property (nonatomic, strong, readonly) UIView *safeAreaView;
@property (nonatomic, copy  ) dispatch_block_t didTouchToolbar;

- (void)setBackgroundImage:(UIImage *)backgroundImage;
- (void)setSafeAreaImage:(UIImage *)safeAreaImage;
//default set backgroundColor  safeAreaBackgroundColor = backgroundColor
- (void)setSafeAreaBackgroundColor:(UIColor *)safeAreaBackgroundColor;
@end
