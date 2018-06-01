//
//  JZTRightLeftButton.m
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/6/1.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import "JZTRightLeftButton.h"
#import <Masonry/Masonry.h>
@interface JZTRightLeftButton()
@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@end
@implementation JZTRightLeftButton
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageTextSpace = 8.;
        _imageRightSpace = 0.;
        _textLeftSpace = 0.;
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
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-self.imageRightSpace);
        make.top.greaterThanOrEqualTo(self).offset(1);
        make.bottom.lessThanOrEqualTo(self).offset(-1);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.imageView.mas_left).offset(-self.imageTextSpace);
        make.left.equalTo(self).offset(self.textLeftSpace);
        make.top.greaterThanOrEqualTo(self).offset(1);
        make.bottom.lessThanOrEqualTo(self).offset(-1);
    }];
}

- (void)setImageTextSpace:(CGFloat)imageTextSpace{
    _imageTextSpace = imageTextSpace;
    [self __layout];
}

- (void)setImageRightSpace:(CGFloat)imageRightSpace{
    _imageRightSpace = imageRightSpace;
    [self __layout];
}

- (void)setTextLeftSpace:(CGFloat)textLeftSpace{
    _textLeftSpace = textLeftSpace;
    [self __layout];
}
#pragma mark -
#pragma mark - getter property
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_imageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font  = [UIFont systemFontOfSize:12.5];
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.textColor = [UIColor colorWithRed:68/255. green:68/255. blue:68/255. alpha:1];
    }
    return _titleLabel;
}

@end
