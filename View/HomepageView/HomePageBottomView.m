//
//  HomePageBottomView.m
//  PC
//
//  Created by MacBook Pro on 14-9-2.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "HomePageBottomView.h"

@implementation HomePageBottomView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame buttonTitleArr:(NSArray *)arr whitIcon:(NSArray *)iconArray delegate:(id<HomePageBottomViewDelegate>)dele
{
    self = [super initWithFrame:frame];
    if (self) {
        int totalCount = arr.count;
        
        self.delegate = dele;
        self.alpha = 0.85;
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = RGB_TextLightGray.CGColor;
        
        for (int i =0 ; i<totalCount; i++) {
            UIButton *tabBar = [UIButton buttonWithType:UIButtonTypeCustom];
            [tabBar setFrame:CGRectMake( ViewWidth(self)/totalCount * i, 0.f, ViewWidth(self)/totalCount, ViewHeight(self))];
            [tabBar setTag:i];

            tabBar.backgroundColor = [UIColor whiteColor];

            [tabBar setIcon:IMG([iconArray objectAtIndex:i]) whitTitle:[arr objectAtIndex:i]];
            [tabBar addTarget:self action:@selector(tabbarClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:tabBar];
        }
        
        for (int i =1 ; i<totalCount; i++) {
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth(self)/totalCount * i - 1, 7.f, 0.6, 26.f)];
            line.alpha = 0.7;
            line.backgroundColor = RGB_TextLineLightGray;
            [self addSubview:line];
        }
        
    }
    return self;
}

- (void)tabbarClick:(UIButton *)sender{
    if (self.delegate !=nil && [self.delegate respondsToSelector:@selector(bottomBarSelectClick:)]) {
        [self.delegate performSelector:@selector(bottomBarSelectClick:) withObject:sender];
        
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
