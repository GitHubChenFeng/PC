//
//  HomePageBottomView.h
//  PC
//
//  Created by MacBook Pro on 14-9-2.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+addIcon.h"

@protocol HomePageBottomViewDelegate <NSObject>

- (void)bottomBarSelectClick:(UIButton *)btn;

@end

@interface HomePageBottomView : UIView
{
    __unsafe_unretained id<HomePageBottomViewDelegate>delegate;
}
@property (nonatomic ,assign) id<HomePageBottomViewDelegate>delegate;
@property (nonatomic ,strong) NSMutableArray *buttonTitleArray;

- (id)initWithFrame:(CGRect)frame buttonTitleArr:(NSArray *)arr whitIcon:(NSArray *)iconArray delegate:(id<HomePageBottomViewDelegate>)delegate;


@end
