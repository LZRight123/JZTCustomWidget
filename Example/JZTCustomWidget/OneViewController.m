//
//  OneViewController.m
//  JZTCustomWidget
//
//  Created by 梁泽 on 2018/5/30.
//  Copyright © 2018年 梁泽. All rights reserved.
//

#import "OneViewController.h"
#import "JZTSegmentPageView.h"
@interface OneViewController ()

@end

@implementation OneViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JZTSegmentPageView *pageview = [[JZTSegmentPageView alloc]initWithFrame:self.view.bounds withTitles:@[@"ss",@"sfaf"] withViewControllers:@[@"UIViewController"] loadAtIndex:0 withParameters:nil ];
    [self.view addSubview:pageview];
    [self.view sendSubviewToBack:pageview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end