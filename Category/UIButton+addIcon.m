//
//  UIButton+addIcon.m
//  PC
//
//  Created by MacBook Pro on 14-9-7.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "UIButton+addIcon.h"

@implementation UIButton (addIcon)

- (void)setIcon:(UIImage *)image whitTitle:(NSString *)title{

    CGFloat kleftMargin = 10.f;
    if (self.tag == 1 || self.tag == 2) {
        kleftMargin = 16.f;
    }
    
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(kleftMargin, 10.f, 20., 20.f)];
    icon.image = image;
    [self addSubview:icon];
    
    UILabel *titles = [[UILabel alloc]initWithFrame:CGRectMake(30.f, 10.f, 55.f, 20.f)];
    titles.font = KSystemFont(13);
    titles.text = title;
    titles.textColor = RGB_MainAppColor;
    titles.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titles];

}

- (void)setReleaseRoutePath:(UIImage *)icon whitTitle:(NSString *)title withDetail:(NSString *)detailTxts{
    UIImageView *headIcon = [[UIImageView alloc]initWithFrame:CGRectMake(45.f, 7.f, 30.f, 30.f)];
    headIcon.image = icon;
    [self addSubview:headIcon];
    
    UILabel *titles = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 45.f, 120.f, 20.f)];
    titles.font = KSystemFont(16);
    titles.text = title;
    titles.textColor = [UIColor whiteColor];
    titles.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titles];
    
    UILabel *detailTxt = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 70.f, 120.f, 20.f)];
    detailTxt.font = KSystemFont(13);
    detailTxt.text = detailTxts;
    detailTxt.textColor = [UIColor whiteColor];
    detailTxt.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detailTxt];
    
}

@end
