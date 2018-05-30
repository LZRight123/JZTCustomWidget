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
///间隙
@property (nonatomic, assign) CGFloat imageTopSpace;
@property (nonatomic, assign) CGFloat imageTextSpace;
@property (nonatomic, assign) CGFloat textBottomSpace;
///角标
@property (nonatomic, strong) NSString *badgeValue;

@end
