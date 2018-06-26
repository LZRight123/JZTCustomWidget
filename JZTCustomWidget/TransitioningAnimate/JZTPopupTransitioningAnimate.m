//
//  JZTPopupTransitioningAnimate.m
//  JZTAudio
//
//  Created by 梁泽 on 2017/12/28.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "JZTPopupTransitioningAnimate.h"

@implementation JZTPopupTransitioningAnimate
+ (instancetype)sharedAnimate {
    static JZTPopupTransitioningAnimate *animate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animate = [[[self class] alloc] init];
    });
    return animate;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (toViewController.isBeingPresented) {
        [[transitionContext containerView] addSubview:toViewController.view];
        
        toViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        [UIView animateWithDuration:duration*0.8 animations:^{
            toViewController.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration*0.1 animations:^{
                toViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration*0.1 animations:^{
                    toViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                } completion:^(BOOL finished) {
                    BOOL wasCancelled = [transitionContext transitionWasCancelled];
                    [transitionContext completeTransition:!wasCancelled];
                }];
//                [transitionContext completeTransition:finished];
            }];
            
//            [transitionContext completeTransition:finished];
        }];
    } else {
        [UIView animateWithDuration:duration * 0.8 animations:^{
            fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
}

@end
