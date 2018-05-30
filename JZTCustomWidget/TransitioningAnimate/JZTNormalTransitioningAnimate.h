//
//  JZTNormalTransitioningAnimate.h
//  JZTAudio
//
//  Created by yanmingjun on 2017/5/9.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface JZTNormalTransitioningAnimate : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong, readonly) UIView *maskView;
@property (nonatomic, strong) NSNumber *transitionDuration;

+ (instancetype)sharedAnimate;

@end
