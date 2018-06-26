//
//  JZTPresentationController.m
//  JZTCustomWidget
//
//  Created by 梁泽 on 2018/6/11.
//  Copyright © 2018年 梁泽. All rights reserved.
//

#import "JZTPresentationController.h"
@interface JZTPresentationController()
@property (nonatomic, strong) UIView *dimmingView;
@end

@implementation JZTPresentationController
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _dimmingView = [[UIView alloc]init];
        _dimmingView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    }
    return self;
}

- (void)presentationTransitionWillBegin {
    UIView *containerView = [self containerView] ;
    CGRect frame = containerView.bounds;
    _dimmingView.frame = frame;
    [[self containerView] addSubview:_dimmingView];
    [_dimmingView addSubview:[[self presentedViewController] view]];
    
    id <UIViewControllerTransitionCoordinator> transitionCoordinator =
    [[self presentingViewController] transitionCoordinator];
    
    [_dimmingView setAlpha:0.0];
    [transitionCoordinator animateAlongsideTransition:
     ^(id<UIViewControllerTransitionCoordinatorContext> context) {
         [self.dimmingView setAlpha:1.0];
     } completion:nil];
    
    
}

- (void)dismissalTransitionWillBegin{
    id <UIViewControllerTransitionCoordinator> transitionCoordinator =
    [[self presentingViewController] transitionCoordinator];
    [transitionCoordinator animateAlongsideTransition:
     ^(id<UIViewControllerTransitionCoordinatorContext> context) {
         [self.dimmingView setAlpha:0.0];
     } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [_dimmingView removeFromSuperview];
    }
}

@end
