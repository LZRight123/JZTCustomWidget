//
//  JZTHealthReportSegement.m
//  JZTAudio
//
//  Created by 梁泽 on 16/4/1.
//  Copyright © 2017年 梁泽. All rights reserved.
//
#import <UIKit/UIKit.h>
///可利用parameter给childVC传参
@class JZTSegmentPageView;
@protocol JZTSegmentPageViewDelegate <NSObject>
- (void)JZTSegmentPageView:(JZTSegmentPageView *)pageView didScorllAtIndex:(NSInteger)index;
- (void)JZTSegmentPageViewDidScroll:(JZTSegmentPageView *)pageView;
@end

@interface JZTSegmentPageView : UIView
@property (strong, nonatomic, readonly) NSMutableArray *strongArray;
@property (assign, nonatomic, readonly) NSInteger currentPage;
// 个性化配置属性
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *unselectedColor;
@property (nonatomic, strong) UIColor *topTabBottomLineColor;
@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat rightSpace;
@property (nonatomic, assign) CGFloat minSpace;
///横向滚动条距离上方距离
@property (nonatomic, assign) CGFloat topSpace;
///default YES
@property (nonatomic, assign) BOOL isAdapteNavigationBar;
///default NO.
@property (nonatomic, assign) BOOL isAnimated;
///default NO.
@property (nonatomic, assign) BOOL isTranslucent;
///default YES
@property (nonatomic, assign) BOOL isAverage;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, weak  ) id<JZTSegmentPageViewDelegate> delegate;

/**
 @param frame       ...
 @param titles      all titles
 @param controllers all controllers name
 @param beginIndex  开始的位置下标
 @param parameters  您需要设置一个名为“参数”的属性，以便控制器接收。
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withViewControllers:(NSArray *)controllers loadAtIndex:(NSInteger)beginIndex withParameters:(NSArray *)parameters;
- (void)setupPageAtIndex:(NSInteger)index;

- (void)setbadgeValue:(NSString *)value atIndex:(NSInteger)index;
@end
