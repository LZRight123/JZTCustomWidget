//
//  JZTBadgeButton.h
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/5/23.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTBadgeButton : UIButton
@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, assign) CGFloat badgeDefaultSize;//默认高度 = 17.
///用于外部调整 example @[@8, @8,@15 ...] 表示1个字符需要增加宽度 2个....
@property (nonatomic, strong) NSArray<NSNumber *> *addWidths;//
@end
