//
//  ViewController.m
//  JZTCustomWidget
//
//  Created by 梁泽 on 2018/5/30.
//  Copyright © 2018年 梁泽. All rights reserved.
//

#import "ViewController.h"
#import "JZTScanVC.h"
#import "JZTRightLeftButton.h"
#import "OneViewController.h"
#import "JZTNormalTransitioningAnimate.h"
#import "TestTransitioningDelegate.h"
#import "JZTPopupTransitioningAnimate.h"
#import "JZTTopToBottomTransitioningAnimate.h"
#import <Masonry/Masonry.h>
#import "JZTButton.h"
@interface ViewController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation ViewController
- (IBAction)sfsaf:(id)sender {
    
//    JZTScanVC *nextVC = [[JZTScanVC alloc]init];
//    [self presentViewController:nextVC animated:YES completion:nil] ;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [nextVC openPhotoLibrary];
//    });
    OneViewController *nextVC = [[OneViewController alloc]init];
    nextVC.modalPresentationStyle = UIModalPresentationCustom;
    nextVC.transitioningDelegate = [JZTPopupTransitioningAnimate sharedAnimate];
    [self showDetailViewController:nextVC sender:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JZTButton *(^createBtn)() = ^{
        JZTButton *btn = [JZTButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"addpic"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"scan_dark"] forState:UIControlStateHighlighted];
        [btn setTitle:@"sfsjlfj" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [btn setTitle:@"sfsjlfj无可无不可f" forState:UIControlStateHighlighted];
        btn.backgroundColor = [UIColor redColor];
        return btn;
    };
    
    JZTButton *onlyBtn = createBtn();
    [onlyBtn addTarget:self action:@selector(clickPop:) forControlEvents:UIControlEventTouchUpInside];
    onlyBtn.style = JZTButtonImageEdgeNone;
    onlyBtn.responseSize = CGSizeMake(100, 100);
    [onlyBtn setImage:nil forState:UIControlStateNormal];
    [onlyBtn setTitle:@"pop" forState:UIControlStateNormal];
    [onlyBtn setTitle:@"pop" forState:UIControlStateHighlighted];
//    onlyBtn.contentEdgeInsets = UIEdgeInsetsMake(-20, -20, -10, -30);
   
//    [self.view addSubview:onlyBtn];
//    [onlyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.view).offset(-200);
////        make.width.mas_equalTo(300);
//    }];
    
    JZTButton *leftBtn = createBtn();
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, -100, -100);
//    leftBtn.titleImageSpace = 50;
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
    }];
    
//    JZTButton *rightBtn = createBtn();
//    rightBtn.style = JZTButtonImageEdgeRight;
//    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(-40, -5, 0, 0);
//    [self.view addSubview:rightBtn];
//    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.view).offset(-50);
//    }];
//
//    JZTButton *topBtn = createBtn();
//    topBtn.style = JZTButtonImageEdgeTop;
//    topBtn.contentEdgeInsets = UIEdgeInsetsMake(-10, -50, -10, 0);
//    [self.view addSubview:topBtn];
//    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.view).offset(50);
//    }];
//
//    JZTButton *bottomBtn = createBtn();
//    bottomBtn.style = JZTButtonImageEdgeBottom;
//    bottomBtn.contentEdgeInsets = UIEdgeInsetsMake(-10, -50, -10, 0);
//    [self.view addSubview:bottomBtn];
//    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.view).offset(250);
//    }];

}

- (void)clickPop:(UIButton *)sender{
    OneViewController *nextVC = [[OneViewController alloc]init];
    nextVC.preferredContentSize = CGSizeMake(100, 100);
    nextVC.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *popover = nextVC.popoverPresentationController;
    popover.sourceView = sender;
    popover.sourceRect = sender.bounds;
    popover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    popover.permittedArrowDirections = UIPopoverArrowDirectionDown;
    popover.popoverLayoutMargins = UIEdgeInsetsMake(10, -100, -100, -100);
    popover.delegate = self;
    popover.popoverBackgroundViewClass = NSClassFromString(@"TestPopverView");
    [self presentViewController:nextVC animated:YES completion:nil];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}
@end
