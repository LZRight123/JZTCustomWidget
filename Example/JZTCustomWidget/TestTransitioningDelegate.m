//
//  TestTransitioningDelegate.m
//  JZTCustomWidget
//
//  Created by 梁泽 on 2018/6/11.
//  Copyright © 2018年 梁泽. All rights reserved.
//

#import "TestTransitioningDelegate.h"
#import "JZTPresentationController.h"
@implementation TestTransitioningDelegate
+ (instancetype)sharedAnimate {
    static TestTransitioningDelegate *animate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animate = [[[self class] alloc] init];
    });
    return animate;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[JZTPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
}
@end
