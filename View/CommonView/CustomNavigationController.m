//
//  CustomNavigationController.m
//  information
//
//  Created by MC374 on 12-12-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

-(void)popself
{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated 
{ 
    [super pushViewController:viewController animated:animated]; 
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        UIImage *image = [[UIImage alloc ]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]];
        UIButton *barbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        barbutton.frame = CGRectMake(0.0f, 7.0f, 25, 25);
        
//        if (IOSVersion > 7.0) {
//            barbutton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
//        }
        
        [barbutton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
        [barbutton setImage:image forState:UIControlStateNormal];
        UIImage *img = [[UIImage alloc ]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"return_click" ofType:@"png"]];
        [barbutton setImage:img forState:UIControlStateHighlighted];
       
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:barbutton];
        viewController.navigationItem.leftBarButtonItem = barBtnItem;
   
    } 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
