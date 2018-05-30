//
//  JZTAspectProxy.h
//  JZTPerformanceMonitor_Example
//
//  Created by 梁泽 on 2018/5/8.
//  Copyright © 2018年 350442340@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol JZTAspectProxyDelegate<NSObject>
- (void)willInvoke:(NSInvocation *)ivoke target:(id)target;
- (void)didInvoke:(NSInvocation *)ivoke target:(id)target;
@end

@interface JZTAspectProxy : NSProxy
@property (nonatomic, weak) id target;
@property (nonatomic, weak) id<JZTAspectProxyDelegate> invokerDelegate;

- (instancetype)initWithTarget:(id)target delegate:(id<JZTAspectProxyDelegate>)delegate monitorSelectors:(NSArray *)selectors;
- (instancetype)initWithTarget:(id)target;

- (void)registerSelector:(SEL)selector;

@end
