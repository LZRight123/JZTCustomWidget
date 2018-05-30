//
//  ViewController.m
//  JZTCustomWidget
//
//  Created by 梁泽 on 2018/5/30.
//  Copyright © 2018年 梁泽. All rights reserved.
//

#import "ViewController.h"
#import "JZTScanVC.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)sfsaf:(id)sender {
    
    JZTScanVC *nextVC = [[JZTScanVC alloc]init];
    [self presentViewController:nextVC animated:YES completion:nil] ;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [nextVC openPhotoLibrary];
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
