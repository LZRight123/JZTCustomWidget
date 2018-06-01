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
///用于外部调整
@property (nonatomic, assign) CGFloat addWidth;
@end
