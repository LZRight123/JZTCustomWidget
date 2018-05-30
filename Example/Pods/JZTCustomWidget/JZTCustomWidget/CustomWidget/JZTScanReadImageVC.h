//
//  JZTScanReadImageVC.h
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/5/29.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTScanReadImageVC : UIViewController
@property (nonatomic, copy  ) void(^readingCompletion)(NSString *result);

- (instancetype)initWithImage:(UIImage *)image;

@end
