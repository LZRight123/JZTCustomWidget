//
//  JZTOrdetailAuditManCell.h
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/7/4.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTOrdetailAuditManCell : UITableViewCell
+ (__kindof UITableViewCell *)cellWithTableView:(UITableView*)tableView;
- (void)setupAuditMan:(NSString *)auditMan msg:(NSString *)msg;
@end
