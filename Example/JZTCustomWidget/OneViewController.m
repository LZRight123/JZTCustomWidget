//
//  OneViewController.m
//  JZTCustomWidget
//
//  Created by 梁泽 on 2018/5/30.
//  Copyright © 2018年 梁泽. All rights reserved.
//

#import "OneViewController.h"
#import "JZTSegmentPageView.h"
#import <Masonry/Masonry.h>
#import "JZTAutoLayoutCell.h"
#import "JZTOrdetailAuditManCell.h"
@interface OneViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation OneViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    //    self.tableView.tableFooterView = [self createBottomView];
    self.tableView.estimatedRowHeight = 95;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JZTOrdetailAuditManCell *cell = [JZTOrdetailAuditManCell cellWithTableView:tableView];
    [cell setupAuditMan:@"您 好" msg:@"不会吧不会吧不会吧兴因果不会吧不会吧不会吧兴因果不会吧不会吧不会吧兴因果不会吧不会吧不会吧兴因果不会吧不会吧不会吧兴因果不会吧不会吧不会吧兴因果不会吧不会吧不会吧兴因果不会吧不会吧不会吧兴因果"];
    
    return cell;
}


@end
