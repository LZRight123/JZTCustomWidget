//
//  JZTBadgeButton.m
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/5/23.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import "JZTBadgeButton.h"

@implementation JZTBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.addWidth = 8.;
        self.badgeDefaultSize = 17.;
        self.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:75.0f/255.0f blue:39.0f/255.0f alpha:1.0f];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    if ([badgeValue integerValue] != 0) {//badgeValue && [badgeValue intValue] != 0
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.badgeDefaultSize;
        CGFloat badgeW = self.badgeDefaultSize;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            NSDictionary *attrs = @{NSFontAttributeName : self.titleLabel.font};
            CGSize badgeSize = [badgeValue boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
             badgeW = badgeSize.width + self.addWidth;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
        self.layer.cornerRadius = badgeH/2.;
    } else {
        self.hidden = YES;
    }
}

@end
