//
//  UIViewController+CustomTracker.m
//  PopWallPapers
//
//  Created by sugar chen on 12-10-6.
//  Copyright (c) 2012年 NULL. All rights reserved.
//

#import "UIViewController+CustomTracker.h"

#ifndef RGBACOLOR
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:a]
#endif

#define  TABBAR_HEIGHT 49
@implementation UIViewController (CustomTracker)

///SYNTHESIZE_CATALOG_VALUE_PROPERTY(int, currentPage, setCurrentPage:)

- (void)setTitle:(NSString *)title
{
	//    [super setTitle:title];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 320-160, 42)];
    label.font = [UIFont systemFontOfSize:19.0f];
    label.text = title;
	label.textColor = RGB_MainAppColor;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
  
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}
- (UIButton *)createTitleButtonWithImage:(UIImage *)img selectedImage:(UIImage *)selImage selector:(SEL)sel
{
	
	UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button setBackgroundImage:img forState:UIControlStateNormal];
	//[button setBackgroundImage:selImage forState:UIControlStateHighlighted];
	[button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
	button.frame = CGRectMake(0, 0, img.size.width, img.size.height);
	//	UIEdgeInsets inset = {6,6,6,6};
	//	button.imageEdgeInsets = inset;
	[button setTitleColor:RGBACOLOR(63,63,63,1) forState:UIControlStateNormal];
	return  button;
}

- (void)buildCustomUI
{
    if ( NO == [self isKindOfClass:[UITableViewController class]] && [self.view subviews].count == 0)
    {
        CGRect navbarFrame = self.navigationController.navigationBar.frame;
        CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
        BOOL bottomBarHidden = self.hidesBottomBarWhenPushed;
        
        CGFloat  y = navbarFrame.size.height + statusBarFrame.size.height;
        CGFloat  height = [UIScreen mainScreen].bounds.size.height - y;
        
        if (bottomBarHidden == NO)
        {
            height -= TABBAR_HEIGHT;
        }
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, height)];
        self.view = view;

    }

//	UIImage *image = [UIImage imageNamed:@"allBackground.png"];
//   [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
        self.view.backgroundColor = RGBACOLOR(240,243,245,1);
//    self.view.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    UINavigationController * ctr = [self navigationController];
	CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
	UIViewController * parent = nil;
	if (version >= 5.0f) {
		
		parent = [self presentingViewController];
	}else {
		parent = [self parentViewController];
	}
	
	
	if ([[ctr viewControllers] count] > 0 ||parent)
	{
		UIImage * backImageNormal = [UIImage imageNamed:@"back.png"];
		UIImage * backImageSelect = [UIImage  imageNamed:@"back.png"];
        
		UIButton * button = [self createTitleButtonWithImage:backImageNormal selectedImage:backImageSelect selector:@selector(ActionBack:)];
//        [button setTitle:@"返回" forState:0];
        //button.frame = CGRectMake(0, 0, 45, 31);
		UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
        
		self.navigationItem.leftBarButtonItem = item;
        
	}else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
}

- (void)setRightBtn:(NSString *)titleStr actionDone:(SEL)selectAction
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"7.png"] forState:UIControlStateNormal];
    [btn setTitle:titleStr forState:UIControlStateNormal];
    [btn addTarget:self action:selectAction forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;

}

- (void)ActionBack:(UIButton *)sender
{
    UINavigationController * ctr = [self navigationController];
    if (ctr)
    {
        if ([ctr topViewController] == [ctr visibleViewController] && [[ctr viewControllers] count] > 1)
		{
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else {
		[self dismissViewControllerAnimated:YES completion:nil];
	}
}



@end
