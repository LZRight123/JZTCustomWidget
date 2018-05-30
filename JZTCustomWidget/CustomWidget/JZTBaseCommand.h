//
//  JZTBaseCommand.h
//  JZT_SUPPLIER
//
//  Created by 梁泽 on 2018/5/24.
//  Copyright © 2018年 com.jk998.jpeg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZTBaseCommand : NSObject
@property (nonatomic, strong) NSDictionary *userInfo;
- (void)execute;
- (void)executeWithObject:(id)object;
@end
