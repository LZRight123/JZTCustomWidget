//
//  JZTHealthReportSegement.m
//  JZTAudio
//
//  Created by 梁泽 on 16/4/1.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#define LEFT_SPACE 20
#define RIGHT_SPACE 20
#define MIN_SPACING 20
#define TAB_HEIGHT 44
#define LINEBOTTOM_HEIGHT 2
#define TOPBOTTOMLINEBOTTOM_HEIGHT .5

#import "JZTSegmentPageView.h"
#import <objc/runtime.h>
#import "JZTBadgeButton.h"
@interface JZTSegmentPageView () <UIScrollViewDelegate>
@property (strong, nonatomic, readwrite) NSMutableArray *strongArray;
@property (assign, nonatomic, readwrite) NSInteger currentPage;
@property (strong, nonatomic) UIView *topTabView;
@property (strong, nonatomic) UIScrollView   *topTabScrollView;
@property (strong, nonatomic) UIScrollView   *scrollView;
@property (nonatomic, weak  ) UIViewController *viewController;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, strong) UIView         *lineBottom;

@property (nonatomic, assign) CGRect selfFrame;
@property (nonatomic, assign) CGFloat topTabScrollViewWidth;
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) NSArray *parameters;
///顶部topTabScrollView数据
@property (nonatomic, strong) NSMutableArray *titleSizeArray;
@property (nonatomic, strong) NSMutableArray *centerPoints;
@property (nonatomic, strong) NSMutableArray *width_k_array;
@property (nonatomic, strong) NSMutableArray *width_b_array;
@property (nonatomic, strong) NSMutableArray *point_k_array;
@property (nonatomic, strong) NSMutableArray *point_b_array;

@end

@implementation JZTSegmentPageView
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"currentPage"];
}

#pragma mark - set Method
- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor              = selectedColor;
    _lineBottom.backgroundColor = selectedColor;
    [self updateSelectedPage:self.currentPage];
}

- (void)setUnselectedColor:(UIColor *)unselectedColor{
    _unselectedColor    = unselectedColor;
    [self updateSelectedPage:self.currentPage];
}

- (void)setupPageAtIndex:(NSInteger)index{
    [self touchAction:_titleButtons[index]];
}

- (void)setbadgeValue:(NSString *)value atIndex:(NSInteger)index{
    if (value.integerValue != 0 && index < _titleButtons.count) {
        UIButton *supBtn = _titleButtons[index];
        JZTBadgeButton *badgeBtn = [self viewWithTag:(100+index)];
        badgeBtn.badgeDefaultSize = 13;
        badgeBtn.addWidths = @[@10., @13., @25.];
        badgeBtn.badgeValue = value;
        badgeBtn.center = CGPointMake(CGRectGetWidth(supBtn.bounds), CGRectGetMinY(supBtn.titleLabel.frame));
    }
}
#pragma mark - Initializes Method
- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withViewControllers:(NSArray *)controllers loadAtIndex:(NSInteger)beginIndex withParameters:(NSArray *)parameters{
    self = [super initWithFrame:frame];
    
    if (self) {
        _selfFrame             = frame;
        _selectedColor         = [UIColor colorWithRed:255.0f/255.0f green:75.0f/255.0f blue:39.0f/255.0f alpha:1.0f];
        _unselectedColor       = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
        _leftSpace             = LEFT_SPACE;
        _rightSpace            = RIGHT_SPACE;
        _minSpace              = MIN_SPACING;
        _topTabBottomLineColor = [UIColor clearColor];
        _titles                = titles;
        _viewControllers       = [NSMutableArray arrayWithArray:controllers];
        _parameters            = parameters;
        _isAverage             = YES;
        _isTranslucent         = NO;
        _isAnimated            = NO;
        _isAdapteNavigationBar = YES;
        _topSpace              = _isAdapteNavigationBar ?(([[UIApplication sharedApplication]statusBarFrame].size.height) + 44) : [[UIApplication sharedApplication]statusBarFrame].size.height;
        _font = [UIFont systemFontOfSize:14];
        _currentPage = beginIndex;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) return;
    self.viewController = [self findViewControllerWithView:newSuperview];
    self.viewController.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    if (!self.superview) return;
    [self addSubview:self.scrollView];
    [self addSubview:self.topTabView];
    [self addSubview:self.topTabScrollView];
    
    self.currentPage = _currentPage;
    [self.scrollView setContentOffset:CGPointMake(_selfFrame.size.width * _currentPage, 0) animated:NO];
    [self updateSelectedPage:self.currentPage];
}

#pragma mark - lazy
- (UIView *)topTabView{
    if (!_topTabView){
        CGRect frame = CGRectMake(0, 0, _selfFrame.size.width, TAB_HEIGHT + _topSpace);
        _topTabView  = [[UIView alloc] initWithFrame:frame];
        if (_isTranslucent) {
            UIToolbar *backView = [[UIToolbar alloc] initWithFrame:_topTabView.bounds];
            backView.barStyle   = UIBarStyleDefault;
            backView.backgroundColor = [UIColor whiteColor];
            [_topTabView addSubview:backView];
        }else{
            _topTabView.backgroundColor = [UIColor whiteColor];
        }
        
        if (self.leftButton) {
            self.leftButton.center = CGPointMake(self.leftButton.bounds.size.width / 2, TAB_HEIGHT / 2 + _topSpace);
            [_topTabView addSubview:self.leftButton];
        }
        if (self.rightButton) {
            self.rightButton.center = CGPointMake(_selfFrame.size.width - self.rightButton.bounds.size.width / 2, TAB_HEIGHT / 2 + _topSpace);
            [_topTabView addSubview:self.rightButton];
        }
        UIView *topTabBottomLine = [UIView new];
        topTabBottomLine.frame = CGRectMake(0, TAB_HEIGHT + _topSpace - TOPBOTTOMLINEBOTTOM_HEIGHT, _selfFrame.size.width, TOPBOTTOMLINEBOTTOM_HEIGHT);
        topTabBottomLine.backgroundColor = _topTabBottomLineColor;
        [_topTabView addSubview:topTabBottomLine];
    }
    return _topTabView;
}

- (UIScrollView *)topTabScrollView{
    if (!_topTabScrollView){
        CGFloat leftWidth  = 0;
        CGFloat rightWidth = 0;
        if (self.leftButton) {
            leftWidth = self.leftButton.bounds.size.width;
        }
        if (self.rightButton) {
            rightWidth = self.rightButton.bounds.size.width;
        }
        _topTabScrollViewWidth = _selfFrame.size.width - leftWidth - rightWidth;
        CGRect frame = CGRectMake(leftWidth, _topSpace + _topTabView.frame.origin.y, _topTabScrollViewWidth, TAB_HEIGHT);
        _topTabScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _topTabScrollView.showsHorizontalScrollIndicator = NO;
        _topTabScrollView.alwaysBounceHorizontal = YES;
        _topTabScrollView.scrollsToTop = NO;
        
        CGFloat totalWidth = 0;
        _titleSizeArray    = [NSMutableArray array];
        CGFloat equalX     = _leftSpace;
        NSMutableArray *equalIntervals = [NSMutableArray array];
        
        for (NSInteger i=0; i<_titles.count; i++) {
            CGSize titleSize = [_titles[i] sizeWithAttributes:@{NSFontAttributeName:_font}];
            [_titleSizeArray addObject:[NSValue valueWithCGSize:titleSize]];
            totalWidth += titleSize.width;
            [equalIntervals addObject:[NSNumber numberWithFloat:(equalX + titleSize.width/2)]];
            equalX += _minSpace + titleSize.width;
        }
        
        CGFloat dividend = _titles.count>1?_titles.count-1:1;
        CGFloat minWidth = (_topTabScrollViewWidth - totalWidth - _leftSpace - _rightSpace) / dividend;
        CGFloat averageX = _leftSpace;
        if (_isAverage) {
            minWidth = (_topTabScrollViewWidth - totalWidth) / (_titles.count + 1);
            averageX = minWidth;
        }
        NSMutableArray *averageIntervals = [NSMutableArray array];
        for (NSInteger i=0; i<_titles.count; i++) {
            [averageIntervals addObject:[NSNumber numberWithDouble:(averageX + [_titleSizeArray[i] CGSizeValue].width/2)]];
            averageX += minWidth + [_titleSizeArray[i] CGSizeValue].width;
        }
        totalWidth += (_titles.count - 1) * _minSpace + _leftSpace + _rightSpace;
        NSMutableArray *centerPoints = [NSMutableArray array];
        if (totalWidth > _topTabScrollViewWidth){
            centerPoints = equalIntervals;
        }else{
            centerPoints = averageIntervals;
            totalWidth = _topTabScrollViewWidth;
        }
        _centerPoints = centerPoints;
        _width_k_array = [NSMutableArray array];
        _width_b_array = [NSMutableArray array];
        _point_k_array = [NSMutableArray array];
        _point_b_array = [NSMutableArray array];
        
        for (NSInteger i=0; i<_titles.count-1; i++) {
            CGFloat k = ([_centerPoints[i+1] floatValue] - [_centerPoints[i] floatValue])/_selfFrame.size.width;
            CGFloat b = [_centerPoints[i] floatValue] - k * i * _selfFrame.size.width;
            [_width_k_array addObject:[NSNumber numberWithFloat:k]];
            [_width_b_array addObject:[NSNumber numberWithFloat:b]];
        }
        for (NSInteger i=0; i<_titles.count-1; i++) {
            CGFloat k = ([_titleSizeArray[i+1] CGSizeValue].width - [_titleSizeArray[i] CGSizeValue].width)/_selfFrame.size.width;
            CGFloat b = [_titleSizeArray[i] CGSizeValue].width - k * i * _selfFrame.size.width;
            [_point_k_array addObject:[NSNumber numberWithFloat:k]];
            [_point_b_array addObject:[NSNumber numberWithFloat:b]];
        }
        
        _topTabScrollView.contentSize = CGSizeMake(totalWidth, 0);
        if (totalWidth <= _topTabScrollView.frame.size.width && _titles.count <= 5) {
            _topTabScrollView.bounces = NO;
        }
        _titleButtons = [NSMutableArray array];
        for (NSInteger i=0; i<_titles.count; i++) {
            UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            titleButton.tag = i;
            [_titleButtons addObject:titleButton];
            titleButton.titleLabel.font = _font;
            [titleButton setTitle:_titles[i] forState:UIControlStateNormal];
            CGFloat x = [_centerPoints[i] floatValue];
            CGFloat width = [_titleSizeArray[i] CGSizeValue].width;
            CGRect buttonFrame = CGRectMake(x-width/2, 0, width, TAB_HEIGHT);
            titleButton.frame = buttonFrame;
            [_topTabScrollView addSubview:titleButton];
            [titleButton addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
            JZTBadgeButton *badgeBtn = [[JZTBadgeButton alloc]init];
            badgeBtn.tag = 100+i;
            [titleButton addSubview:badgeBtn];
        }
        
        UIView *topTabBottomLine = [UIView new];
        topTabBottomLine.frame = CGRectMake(-totalWidth, TAB_HEIGHT - TOPBOTTOMLINEBOTTOM_HEIGHT, totalWidth*3, TOPBOTTOMLINEBOTTOM_HEIGHT);
        topTabBottomLine.backgroundColor = _topTabBottomLineColor;
        [_topTabScrollView addSubview:topTabBottomLine];
        
        _lineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, TAB_HEIGHT - LINEBOTTOM_HEIGHT,[_titleSizeArray[0] CGSizeValue].width, LINEBOTTOM_HEIGHT)];
        _lineBottom.center = CGPointMake([centerPoints[0] floatValue], _lineBottom.center.y);
        _lineBottom.backgroundColor = _selectedColor;
        [_topTabScrollView addSubview:_lineBottom];
    }
    return _topTabScrollView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.scrollsToTop = NO;
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        _scrollView.frame = CGRectMake(0, 0, _selfFrame.size.width, _selfFrame.size.height);
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(_selfFrame.size.width * _titles.count, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    return _scrollView;
}

- (NSMutableArray *)strongArray{
    if (!_strongArray){
        _strongArray = [NSMutableArray arrayWithArray:_viewControllers];
    }
    return _strongArray;
}

#pragma mark - Calculation Method

- (CGFloat)getTitleWidth:(CGFloat)offset{
    NSInteger index = (NSInteger)(offset / _selfFrame.size.width);
    CGFloat k = [_width_k_array[index] floatValue];
    CGFloat b = [_width_b_array[index] floatValue];
    CGFloat x = offset;
    return  k * x + b;
}

- (CGFloat)getTitlePoint:(CGFloat)offset{
    NSInteger index = (NSInteger)(offset / _selfFrame.size.width);
    CGFloat k = [_point_k_array[index] floatValue];
    CGFloat b = [_point_b_array[index] floatValue];
    CGFloat x = offset;
    return  k * x + b;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentPage = (NSInteger)((scrollView.contentOffset.x + _selfFrame.size.width / 2) / _selfFrame.size.width);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.currentPage = (NSInteger)((scrollView.contentOffset.x + _selfFrame.size.width / 2) / _selfFrame.size.width);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (scrollView.contentOffset.x<=0) {
        contentOffsetX = 0;
    }
    if (scrollView.contentOffset.x >= _selfFrame.size.width * (_titles.count-1)) {
        contentOffsetX = _selfFrame.size.width * (_titles.count-1) -1;
    }
    
    _lineBottom.center = CGPointMake([self getTitleWidth:contentOffsetX], _lineBottom.center.y);
    _lineBottom.bounds = CGRectMake(0, 0, [self getTitlePoint:contentOffsetX], LINEBOTTOM_HEIGHT);
    
    CGFloat page = (NSInteger)((contentOffsetX + _selfFrame.size.width / 2) / _selfFrame.size.width);
    [self updateSelectedPage:page];
    
    if ([self.delegate respondsToSelector:@selector(JZTSegmentPageViewDidScroll:)]) {
        [self.delegate JZTSegmentPageViewDidScroll:self];
    }
}

#pragma mark - My Method

- (void)touchAction:(UIButton *)button {
    [_scrollView setContentOffset:CGPointMake(_selfFrame.size.width * button.tag, 0) animated:YES];
}

- (void)updateSelectedPage:(NSInteger)page{
    for (UIButton *button in _titleButtons) {
        if (button.tag == page) {
            [button setTitleColor:_selectedColor forState:UIControlStateNormal];
            if (_isAnimated) {
                [UIView animateWithDuration:0.3 animations:^{
                    button.transform = CGAffineTransformMakeScale(1.2, 1.2);
                    self.lineBottom.transform = CGAffineTransformMakeScale(1.2, 1.2);
                }];
            }
        }else{
            [button setTitleColor:_unselectedColor forState:UIControlStateNormal];
            if (_isAnimated) {
                [UIView animateWithDuration:0.3 animations:^{
                    button.transform = CGAffineTransformIdentity;
                }];
            }
        }
    }
    if ([self.delegate respondsToSelector:@selector(JZTSegmentPageView:didScorllAtIndex:)]) {
        [self.delegate JZTSegmentPageView:self didScorllAtIndex:page];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"currentPage"]) {
        NSInteger page = [change[@"new"] integerValue];
        CGFloat offset = [_centerPoints[page] floatValue];
        if (_topTabScrollView.contentSize.width <= _selfFrame.size.width) {
            
        }else if (offset < _topTabScrollViewWidth/2) {
            [_topTabScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if(offset+_topTabScrollViewWidth/2 <_topTabScrollView.contentSize.width) {
            [_topTabScrollView setContentOffset:CGPointMake(offset-_topTabScrollViewWidth/2, 0) animated:YES];
        }else{
            [_topTabScrollView setContentOffset:CGPointMake(_topTabScrollView.contentSize.width-_topTabScrollViewWidth, 0) animated:YES];
        }
        for (NSInteger i=0; i<_viewControllers.count; i++) {
            if (page == i) {
                NSString *className = _viewControllers[page];
                
                for (NSInteger j=0; j<self.strongArray.count; j++) {
                    id obj = self.strongArray[j];
                    if ([[obj class] isSubclassOfClass:[UIViewController class]]) {
                        UIViewController *viewController = obj;
                        if ([viewController.view.class isSubclassOfClass:[UIScrollView class]]) {
                            UIScrollView *view = (UIScrollView *)viewController.view;
                            if (j == page) {
                                view.scrollsToTop = YES;
                            }else{
                                view.scrollsToTop = NO;
                            }
                        }
                        if ([NSStringFromClass([viewController.view class]) isEqualToString:@"UICollectionViewControllerWrapperView"]) {
                            UIScrollView *view = (UIScrollView *)viewController.view.subviews[0];
                            if (j == page) {
                                view.scrollsToTop = YES;
                            }else{
                                view.scrollsToTop = NO;
                            }
                        }
                    }
                }
                
                //Create only once
                if ([className isEqualToString:@"JZTPAGEVIEW_AlreadyCreated"]) {
                    return;
                }
                Class class = NSClassFromString(className);
                
                UIViewController *viewController = class.new;
                self.strongArray[i] = viewController;
                
                if (_parameters && _parameters.count > i && _parameters[i] && [self getVariableWithClass:viewController.class varName:@"parameter"]) {
                    [viewController setValue:_parameters[i] forKey:@"parameter"];
                }
                
                CGFloat offset = _topSpace + TAB_HEIGHT;
                CGRect frame = CGRectMake(_selfFrame.size.width * i, offset, _selfFrame.size.width, _scrollView.bounds.size.height - offset);
                
                if ([viewController.view.class isSubclassOfClass:[UIScrollView class]]) {
                    UIScrollView *view = (UIScrollView *)viewController.view;
                    view.contentInset = UIEdgeInsetsMake(offset, 0, 0, 0);
                    view.contentOffset = CGPointMake(0,-offset);
                    frame = CGRectMake(_selfFrame.size.width * i, 0, _selfFrame.size.width, _scrollView.bounds.size.height);
                }
                if ([NSStringFromClass([viewController.view class]) isEqualToString:@"UICollectionViewControllerWrapperView"]) {
                    UIScrollView *view = (UIScrollView *)viewController.view.subviews[0];
                    view.contentInset = UIEdgeInsetsMake(offset, 0, 0, 0);
                    view.contentOffset = CGPointMake(0,-offset);
                    frame = CGRectMake(_selfFrame.size.width * i, 0, _selfFrame.size.width, _scrollView.bounds.size.height);
                }
                viewController.view.frame = frame;
                [self.scrollView addSubview:viewController.view];
                _viewControllers[page] = @"JZTPAGEVIEW_AlreadyCreated";
                
                [self.viewController addChildViewController:viewController];
            }
        }
    }
}

#pragma mark -
#pragma mark - helper
- (UIViewController *)findViewControllerWithView:(UIView *)view{
    id target = view;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

- (BOOL)getVariableWithClass:(Class)myClass varName:(NSString *)name{
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            free(ivars);
            return YES;
        }
    }
    free(ivars);
    return NO;
}

@end
