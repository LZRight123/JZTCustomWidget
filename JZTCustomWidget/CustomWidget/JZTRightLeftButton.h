//
//  JZTRightLeftButton.h
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/6/1.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTRightLeftButton : UIControl
@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat imageTextSpace;//default is 8.
@property (nonatomic, assign) CGFloat imageRightSpace;//default is 0.
@property (nonatomic, assign) CGFloat textLeftSpace;//default is 0.

@end
