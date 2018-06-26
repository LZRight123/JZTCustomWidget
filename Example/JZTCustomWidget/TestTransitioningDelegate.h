//
//  TestTransitioningDelegate.h
//  JZTCustomWidget
//
//  Created by 梁泽 on 2018/6/11.
//  Copyright © 2018年 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestTransitioningDelegate : NSObject<UIViewControllerTransitioningDelegate>
+ (instancetype)sharedAnimate;

@end
