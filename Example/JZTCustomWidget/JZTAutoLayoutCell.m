//
//  JZTAutoLayoutCell.m
//  JZTCustomWidget
//
//  Created by 梁泽 on 2018/7/4.
//  Copyright © 2018年 梁泽. All rights reserved.
//

#import "JZTAutoLayoutCell.h"
#import <Masonry/Masonry.h>
@implementation JZTAutoLayoutCell

+ (__kindof UITableViewCell *)cellWithTableView:(UITableView*)tableView{
    static NSString *ID = @"JZTAutoLayoutCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[self class] alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

- (void)setupUI{
    self.label = [[UILabel alloc]init];
    self.label.numberOfLines = 0;
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.bottomView];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(13);
        make.top.equalTo(self.contentView).offset(13);
        make.right.equalTo(self.contentView).offset(-13);

    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.label.mas_bottom).offset(13);
    }];
}

@end
