//
//  JZTNormalTransitioningAnimate.m
//  JZTAudio
//
//  Created by yanmingjun on 2017/5/9.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "JZTNormalTransitioningAnimate.h"

@interface JZTNormalTransitioningAnimate ()

@property (nonatomic, strong, readwrite) UIView *maskView;

@end

@implementation JZTNormalTransitioningAnimate
+ (instancetype)sharedAnimate {
    static JZTNormalTransitioningAnimate *animate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animate = [[[self class] alloc] init];
    });
    return animate;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return  self.transitionDuration?[self.transitionDuration doubleValue] : 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    self.maskView.frame = toViewController.view.bounds;
    if (toViewController.isBeingPresented) {
        self.maskView.alpha = 0;
        [[transitionContext containerView] addSubview:self.maskView];
        [[transitionContext containerView] addSubview:toViewController.view];
        
        toViewController.view.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toViewController.view.transform = CGAffineTransformIdentity;
            self.maskView.alpha = 0.5;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    } else {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
            self.maskView.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    }
}

#pragma mark - getter @property
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIButton alloc]init];
        _maskView.backgroundColor = [UIColor blackColor];
    }
    return _maskView;
}

@end
