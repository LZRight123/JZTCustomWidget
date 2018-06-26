//
//  JZTTopToBottomTransitioningAnimate.m
//  JZTAudio
//
//  Created by 梁泽 on 2017/8/23.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import "JZTTopToBottomTransitioningAnimate.h"

@implementation JZTTopToBottomTransitioningAnimate
+ (instancetype)sharedAnimate {
    static JZTTopToBottomTransitioningAnimate *animate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animate = [[[self class] alloc] init];
    });
    animate.topSpace = [UIApplication sharedApplication].statusBarFrame.size.height + 44;
    return animate;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    if ([transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].isBeingPresented) {
        [[transitionContext containerView]addSubview:presentedView];
        presentedView.transform = CGAffineTransformMakeTranslation(0, -[UIScreen mainScreen].bounds.size.height);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            presentedView.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }else{
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            [transitionContext viewForKey:UITransitionContextFromViewKey].transform = CGAffineTransformMakeTranslation(0, -[UIScreen mainScreen].bounds.size.height);
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
    
    
//    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    
//    CGRect newFrame = fromViewController.view.frame;
//    newFrame.origin.y = 64.;
//    newFrame.size.height -= 64;
//    self.maskView.frame = newFrame;
//    if (toViewController.isBeingPresented) {
//        self.maskView.alpha = 0;
//        [[transitionContext containerView] addSubview:self.maskView];
//        [[transitionContext containerView] addSubview:toViewController.view];
//        
//        toViewController.view.transform = CGAffineTransformMakeTranslation(0, -ScreenHeight);
//        
//        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//            toViewController.view.transform = CGAffineTransformIdentity;
//            self.maskView.alpha = 0.5;
//        } completion:^(BOOL finished) {
//            [transitionContext completeTransition:finished];
//        }];
//    } else {
//        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//            fromViewController.view.transform = CGAffineTransformMakeTranslation(0, -ScreenHeight);
//            self.maskView.alpha = 0;
//        } completion:^(BOOL finished) {
//            [transitionContext completeTransition:finished];
//        }];
//    }
}
@end
