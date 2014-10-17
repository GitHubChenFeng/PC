//
//  CheckDriverOrPassengerView.h
//  PC
//
//  Created by MacBook Pro on 14-9-7.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CheckDriverOrPassengerViewDelegate <NSObject>

- (void)transitionClick:(UIButton *)sender;

@end


@interface CheckDriverOrPassengerView : UIButton
{
    __unsafe_unretained id<CheckDriverOrPassengerViewDelegate>delegate;
}

@property (nonatomic ,assign)id<CheckDriverOrPassengerViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame whitIcon:(UIImage *)img whitTitle:(NSString *)title delegate:(id<CheckDriverOrPassengerViewDelegate>)dele;

@end

