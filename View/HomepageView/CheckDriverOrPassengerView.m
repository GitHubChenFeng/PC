//
//  CheckDriverOrPassengerView.m
//  PC
//
//  Created by MacBook Pro on 14-9-7.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "CheckDriverOrPassengerView.h"

@implementation CheckDriverOrPassengerView
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame whitIcon:(UIImage *)img whitTitle:(NSString *)title delegate:(id<CheckDriverOrPassengerViewDelegate>)dele
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = dele;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = RGB_TextLightGray.CGColor;
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.85;
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake((ViewWidth(self) - 25.f)/2, 5.f, 25., 25.f)];
        icon.image = img;
        [self addSubview:icon];
        
        UILabel *titles = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 32.f, self.frame.size.width, 20.f)];
        titles.font = KSystemFont(13);
        titles.text = title;
        titles.textColor = RGB_MainAppColor;
        titles.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titles];
        
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender{
    if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(buttonClick:)]) {
        [self.delegate performSelector:@selector(transitionClick:) withObject:sender];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
