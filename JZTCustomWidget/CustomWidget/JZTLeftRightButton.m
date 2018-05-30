//
//  JZTLeftRightButton.m
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/5/28.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import "JZTLeftRightButton.h"
@interface JZTLeftRightButton()
@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@end
@implementation JZTLeftRightButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _space = 8.;
        [self __setupUI];
    }
    return self;
}

- (void)__setupUI{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self __layout];
}

- (void)__layout{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(self);
        make.top.equalTo(self);
        make.left.equalTo(self.imageView.mas_right).offset(self.space);
    }];
}

- (void)setSpace:(CGFloat)space{
    _space = space;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(self);
        make.top.equalTo(self);
        make.left.equalTo(self.imageView.mas_right).offset(self.space);
    }];
}

#pragma mark -
#pragma mark - getter property
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font  = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
    }
    return _titleLabel;
}


@end
