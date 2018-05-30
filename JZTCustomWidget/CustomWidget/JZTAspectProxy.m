//
//  JZTAspectProxy.m
//  JZTPerformanceMonitor_Example
//
//  Created by 梁泽 on 2018/5/8.
//  Copyright © 2018年 350442340@qq.com. All rights reserved.
//

#import "JZTAspectProxy.h"
@interface JZTAspectProxy()
@property (nonatomic, strong) NSMutableArray *selectors;
@end

@implementation JZTAspectProxy
- (instancetype)initWithTarget:(id)target delegate:(id<JZTAspectProxyDelegate>)delegate monitorSelectors:(NSArray *)selectors{
    _target = target;
    _invokerDelegate = delegate;
    _selectors = selectors.mutableCopy;
    return self;
}

- (instancetype)initWithTarget:(id)target{
    return [self initWithTarget:target delegate:nil monitorSelectors:@[]];
}

- (void)registerSelector:(SEL)selector{
    NSValue *selValue = [NSValue valueWithPointer:selector];
    [self.selectors addObject:selValue];
}

#pragma mark - override
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    NSMethodSignature *signature = [self.target methodSignatureForSelector:sel];
    if (!signature) {
        [self.target doesNotRecognizeSelector:sel];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    if ([self.invokerDelegate respondsToSelector:@selector(willInvoke:target:)]) {
        SEL nowSel = invocation.selector;
        for (NSValue *obj in self.selectors) {
            SEL targetSel = [obj pointerValue];
            if (targetSel == nowSel) {
                [self.invokerDelegate willInvoke:invocation target:self.target];
                break;
            }
        }
    }
    
    [invocation invokeWithTarget:self.target];
    
    if ([self.invokerDelegate respondsToSelector:@selector(didInvoke:target:)]) {
        SEL nowSel = invocation.selector;
        for (NSValue *obj in self.selectors) {
            SEL targetSel = [obj pointerValue];
            if (targetSel == nowSel) {
                [self.invokerDelegate didInvoke:invocation target:self.target];
                break;
            }
        }
    }
}
#pragma mark - <NSObject>
- (BOOL)isProxy{
    return YES;
}

- (BOOL)isKindOfClass:(Class)aClass{
    return [self.target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass{
    return [self.target isMemberOfClass:aClass];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    return [self.target respondsToSelector:aSelector];
}

@end
