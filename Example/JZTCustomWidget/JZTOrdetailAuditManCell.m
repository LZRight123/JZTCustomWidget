//
//  JZTOrdetailAuditManCell.m
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/7/4.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import "JZTOrdetailAuditManCell.h"
#import <Masonry/Masonry.h>
@interface JZTOrdetailAuditManCell()
@property (nonatomic, strong) UILabel *auditManLabel;
@property (nonatomic, strong) UILabel *manLabel;//
@property (nonatomic, strong) UILabel *auditMsgLabel;
@property (nonatomic, strong) UILabel *msgLabel;//
@property (nonatomic, strong) UIView *bottomLineView;//
@property (nonatomic, strong) UIStackView *titleStackView;//
@property (nonatomic, strong) UIStackView *contentStackView;//
@end
@implementation JZTOrdetailAuditManCell
CGFloat Adapt_scaleL(CGFloat x){
    return x;
}
+ (__kindof UITableViewCell *)cellWithTableView:(UITableView*)tableView{
    static NSString *ID = @"JZTOrdetailAuditManCell";
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

//- (void)setupUI{
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    _titleStackView = [[UIStackView alloc]initWithArrangedSubviews:@[self.auditManLabel, self.auditMsgLabel]];
//    _titleStackView.axis = UILayoutConstraintAxisVertical;
//    _titleStackView.distribution = UIStackViewDistributionFill;
//    _titleStackView.alignment = UIStackViewAlignmentLeading;
//    _titleStackView.spacing = Adapt_scaleL(6);
//
//    _contentStackView = [[UIStackView alloc]initWithArrangedSubviews:@[self.manLabel, self.msgLabel]];
//    _contentStackView.axis = UILayoutConstraintAxisVertical;
//    _contentStackView.distribution = UIStackViewDistributionFill;
//    _contentStackView.alignment = UIStackViewAlignmentLeading;
//    _contentStackView.spacing = Adapt_scaleL(6);
//
//    [self.contentView addSubview:self.titleStackView];
//    [self.contentView addSubview:self.contentStackView];
//    [self.contentView addSubview:self.bottomLineView];
//
//    CGFloat width = 56;
//    [self.titleStackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView).offset(Adapt_scaleL(12));
//        make.left.equalTo(self.contentView).offset(Adapt_scaleL(13));
//    }];
//
//    [self.contentStackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView).offset(Adapt_scaleL(12));
//        make.left.equalTo(self.contentView).offset(Adapt_scaleL(13) + width);
//        make.right.equalTo(self.contentView).offset(Adapt_scaleL(-13));
//    }];
//
//    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentStackView.mas_bottom).offset(Adapt_scaleL(12));
//        make.bottom.right.left.equalTo(self.contentView);
//        make.height.mas_equalTo(Adapt_scaleL(10));
//    }];
//
//
//}

- (void)setupUI{
    [self.contentView addSubview:self.auditManLabel];
    [self.contentView addSubview:self.manLabel];
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.auditMsgLabel];
    [self.contentView addSubview:self.msgLabel];

    CGFloat width = 56;

    [self.auditManLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Adapt_scaleL(12));
        make.left.equalTo(self.contentView).offset(Adapt_scaleL(13));
        make.height.mas_equalTo(20);
    }];
   
    [self.manLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Adapt_scaleL(12));
        make.left.equalTo(self.auditManLabel.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    [self.auditMsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(Adapt_scaleL(13));
        make.top.equalTo(self.auditManLabel.mas_bottom).offset(Adapt_scaleL(6));
        make.width.mas_equalTo(width);
    }];

    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.auditMsgLabel);
        make.left.equalTo(self.contentView).offset(width + Adapt_scaleL(13));
        make.right.equalTo(self.contentView).offset(Adapt_scaleL(-13));
    }];

    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.msgLabel.mas_bottom).offset(Adapt_scaleL(12));
        make.bottom.right.left.equalTo(self.contentView);
        make.height.mas_equalTo(Adapt_scaleL(10));
    }];
}
- (void)setupAuditMan:(NSString *)auditMan msg:(NSString *)msg{
    self.manLabel.text = auditMan;
    if (msg.length > 0) {
        self.msgLabel.text = msg;
    } else {
        self.msgLabel.text = nil;
        [self.titleStackView removeArrangedSubview:self.auditMsgLabel];
        [self.contentStackView removeArrangedSubview:self.msgLabel];
        [self.auditMsgLabel removeFromSuperview];
//        [self.auditMsgLabel removeFromSuperview];
//        [self.msgLabel removeFromSuperview];
//
//        [self.auditManLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView).offset(Adapt_scaleL(12));
//            make.left.equalTo(self.contentView).offset(Adapt_scaleL(13));
//            make.bottom.equalTo(self.contentView).offset(Adapt_scaleL(-10 - 12));
//        }];
//        [self.manLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.auditManLabel);
//            make.left.equalTo(self.auditManLabel.mas_right);
//        }];
//        [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.right.left.equalTo(self.contentView);
//            make.height.mas_equalTo(Adapt_scaleL(10));
//        }];
    }
}
#pragma mark -
#pragma mark - getter property
- (UILabel *)auditManLabel{
    if (!_auditManLabel) {
        _auditManLabel = [[UILabel alloc]init];
        _auditManLabel.font = [UIFont systemFontOfSize:13];
       _auditManLabel.text = @"负责人：";
//        [_auditManLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//        [_auditManLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//        [_auditManLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//        [_auditManLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _auditManLabel;
}

- (UILabel *)manLabel{
    if (!_manLabel) {
       _manLabel = [[UILabel alloc]init];
        _manLabel.font = [UIFont systemFontOfSize:13];
    }
    return _manLabel;
}

- (UILabel *)auditMsgLabel{
    if (!_auditMsgLabel) {
        _auditMsgLabel = [[UILabel alloc]init];
        _auditMsgLabel.font = [UIFont systemFontOfSize:13];
        _auditMsgLabel.text = @"意    见：";
//        [_auditMsgLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//        [_auditMsgLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//        [_auditMsgLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//        [_auditMsgLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _auditMsgLabel;
}

- (UILabel *)msgLabel{
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc]init];
        _msgLabel.font = [UIFont systemFontOfSize:13];
        _msgLabel.numberOfLines = 0;
//        [_msgLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
//        [_msgLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _msgLabel;
}

- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = [UIColor redColor];
    }
    return _bottomLineView;
}
@end
