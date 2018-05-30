//
//  JZTToolbar.m
//  qmyios
//
//  Created by 梁泽 on 2017/11/14.
//  Copyright © 2017年 九州通. All rights reserved.
//

#import "JZTToolbar.h"
#import <Masonry/Masonry.h>
@interface JZTToolbar()
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIImageView *backgroundImgView;
@property (nonatomic, strong, readwrite) UIView *safeAreaView;
@end

@implementation JZTToolbar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self jzt_commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self jzt_commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self sendSubviewToBack:self.backgroundImgView];
    [self sendSubviewToBack:self.safeAreaView];
    [self sendSubviewToBack:self.effectView];
}

- (void)jzt_commonInit{
    [self addSubview:self.backgroundImgView];
    [self addSubview:self.safeAreaView];
    [self addSubview:self.effectView];
    
    [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self).offset(34);
    }];

    [self.backgroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self).offset(([[UIApplication sharedApplication]statusBarFrame].size.height == 44) ? 34 : 0);
    }];
    
    [self.safeAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(34);
    }];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{    
    self.backgroundImgView.backgroundColor = backgroundColor;
}

- (void)setTranslucent:(BOOL)translucent{
    _translucent = translucent;
    
    self.effectView.hidden = !translucent;
}

#pragma mark - public
- (void)setBackgroundImage:(UIImage *)backgroundImage{
    self.backgroundImgView.image = backgroundImage;
}

- (void)setSafeAreaImage:(UIImage *)safeAreaImage{
    [(UIImageView *)self.safeAreaView setImage:safeAreaImage];
}

- (void)setSafeAreaBackgroundColor:(UIColor *)safeAreaBackgroundColor{
    self.safeAreaView.backgroundColor = safeAreaBackgroundColor;
}

- (void)setEffectSyle:(UIBlurEffectStyle)effectSyle{
    self.effectView.effect = nil;
    self.effectView.effect = [UIBlurEffect effectWithStyle:effectSyle];
}

#pragma mark - get property
- (UIVisualEffectView *)effectView{
    if (!_effectView) {
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _effectView.hidden = YES;
    }
    return _effectView;
}

- (UIImageView *)backgroundImgView{
    if (!_backgroundImgView) {
        _backgroundImgView = [[UIImageView alloc]init];
    }
    return _backgroundImgView;
}

- (UIView *)safeAreaView{
    if (!_safeAreaView) {
        _safeAreaView = [[UIImageView alloc]init];
    }
    return _safeAreaView;
}

#pragma mark - override
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    bounds.size.height += 34;
    return CGRectContainsPoint(bounds, point);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.didTouchToolbar) {
        self.didTouchToolbar();
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

@end
