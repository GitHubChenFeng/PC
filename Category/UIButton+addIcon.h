//
//  UIButton+addIcon.h
//  PC
//
//  Created by MacBook Pro on 14-9-7.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (addIcon)

// 底部菜单按钮
- (void)setIcon:(UIImage *)image whitTitle:(NSString *)title;

// 发布路线选择按钮
- (void)setReleaseRoutePath:(UIImage *)icon whitTitle:(NSString *)title withDetail:(NSString *)detailText;

@end
