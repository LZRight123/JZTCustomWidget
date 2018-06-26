//
//  JZTNormalTransitioningAnimate.m
//  JZTAudio
//
//  Created by yanmingjun on 2017/5/9.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "JZTNormalTransitioningAnimate.h"
#import "JZTPresentationController.h"
@interface JZTNormalTransitioningAnimate ()

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

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[JZTPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
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
    
    if (toViewController.isBeingPresented) {
        [[transitionContext containerView] addSubview:toViewController.view];
        
        toViewController.view.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toViewController.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    } else {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
}

@end
