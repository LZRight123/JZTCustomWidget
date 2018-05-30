//
//  JZTUpDownButton.m
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/5/23.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import "JZTUpDownButton.h"
#import "JZTBadgeButton.h"
#import <Masonry/Masonry.h>
@interface JZTUpDownButton()
@property (nonatomic, strong, readwrite) UIImageView *imageView;


@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong) JZTBadgeButton *badgeBtn;//
@end

@implementation JZTUpDownButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageTopSpace = 0.;
        _imageTextSpace = 8.;
        _textBottomSpace = 0.;
        [self __setupUI];
    }
    return self;
}

- (CGSize)intrinsicContentSize{
    CGFloat width = MAX(51, self.imageView.image.size.width);
    CGFloat height = self.imageTopSpace + self.imageView.image.size.height + self.imageTextSpace + 20 + self.textBottomSpace;
    return CGSizeMake(width, height);
}

- (void)__setupUI{
    [self addSubview:self.imageView];
    [self addSubview:self.badgeBtn];
    [self addSubview:self.titleLabel];
    [self __layout];
}

- (void)__layout{
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(self.imageTopSpace);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-self.textBottomSpace);
    }];
}

- (void)setImageTopSpace:(CGFloat)imageTopSpace{
    _imageTopSpace = imageTopSpace;
    [self __layout];
}

- (void)setTextBottomSpace:(CGFloat)textBottomSpace{
    _textBottomSpace = textBottomSpace;
    [self __layout];
}

- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    self.badgeBtn.badgeValue = badgeValue;
    
    if (badgeValue.integerValue != 0) {
        [self.badgeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.imageView.mas_right);
            make.centerY.equalTo(self.imageView.mas_top);
            make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.badgeBtn.frame), CGRectGetHeight(self.badgeBtn.frame)));
        }];
    }
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
        _titleLabel.font  = [UIFont systemFontOfSize:12.5];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:68/255. green:68/255. blue:68/255. alpha:1];
    }
    return _titleLabel;
}

- (JZTBadgeButton *)badgeBtn{
    if (!_badgeBtn) {
        _badgeBtn = [[JZTBadgeButton alloc]init];
    }
    return _badgeBtn;
}


@end
