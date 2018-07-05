//
//  JZTAutoLayoutCell.h
//  JZTCustomWidget
//
//  Created by 梁泽 on 2018/7/4.
//  Copyright © 2018年 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTAutoLayoutCell : UITableViewCell
@property (nonatomic, strong) UILabel *label;//
@property (nonatomic, strong) UIView *bottomView;//
+ (__kindof UITableViewCell *)cellWithTableView:(UITableView*)tableView;
@end
