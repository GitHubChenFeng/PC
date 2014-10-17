//
//  UINavigationBar+setBgImage.m
//  PC
//
//  Created by MacBook Pro on 14-9-9.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "UINavigationBar+setBgImage.h"

@implementation UINavigationBar (setBgImage)

+ (UINavigationBar *)createNavigationBarWithBackgroundImage:(UIImage *)backgroundImage title:(NSString *)title {
    
    UINavigationBar *customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIImageView *navigationBarBackgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    
    [customNavigationBar addSubview:navigationBarBackgroundImageView];
    UINavigationItem *navigationTitle = [[UINavigationItem alloc] initWithTitle:title];
    [customNavigationBar pushNavigationItem:navigationTitle animated:NO];

    return customNavigationBar;
}

- (void) drawRect:(CGRect)rect
{
    UIImage *barImage = IMG(@"top_bar");
    [barImage drawInRect:rect];
}

@end

