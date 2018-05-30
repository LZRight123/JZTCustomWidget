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
    
    CGRect newFrame = presentedView.frame;
    newFrame.origin.y = self.topSpace;
    newFrame.size.height -= self.topSpace;
    self.maskView.frame = newFrame;
    if ([transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].isBeingPresented) {
        self.maskView.alpha = 0;
        [[transitionContext containerView]addSubview:self.maskView];
        [[transitionContext containerView]addSubview:presentedView];
//        presentedView.frame = newFrame;
        presentedView.transform = CGAffineTransformMakeTranslation(0, -ScreenHeight);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            presentedView.transform = CGAffineTransformIdentity;
            self.maskView.alpha = 0.5;
        }completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }else{
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            [transitionContext viewForKey:UITransitionContextFromViewKey].transform = CGAffineTransformMakeTranslation(0, -ScreenHeight);
            self.maskView.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
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
