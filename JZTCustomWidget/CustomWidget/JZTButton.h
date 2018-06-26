//
//  JZTButton.h
//
//  Created by 梁泽 on 2017/4/23.
//  Copyright © 2017年 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JZTButtonImageEdge) {
    JZTButtonImageEdgeLeft, // image在左，label在右 default
    JZTButtonImageEdgeRight, // image在右，label在左
    JZTButtonImageEdgeTop, // image在上，label在下
    JZTButtonImageEdgeBottom, // image在下，label在上
    JZTButtonImageEdgeNone,//only set image or title
};
///contentEdgeInsets can set edge
@interface JZTButton : UIButton
@property (nonatomic, assign) JZTButtonImageEdge style;//
@property (nonatomic, assign) CGSize responseSize;//default is 44*44
@property (nonatomic, assign) CGFloat titleImageSpace;//default is 6

@end
