//
//  CMSCoinView.h
//  FlipViewTest
//
//  Created by Rebekah Claypool on 10/1/13.
//  Copyright (c) 2013 Coffee Bean Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CMSCoinViewDelegate <NSObject>

- (void)clickCoinViewHandle:(UIView *)view;

@end

@interface CMSCoinView : UIView{
    id<CMSCoinViewDelegate> delegate;
}

- (id) initWithPrimaryView: (UIView *) view1 andSecondaryView: (UIView *) view2 inFrame: (CGRect) frame;

@property (nonatomic, retain) UIView *primaryView;
@property (nonatomic, retain) UIView *secondaryView;
@property (nonatomic, retain) id<CMSCoinViewDelegate> delegate;
@property float spinTime;

@end

