//
//  ReleasePassengerViewController.h
//  PC
//
//  Created by MacBook Pro on 14-9-10.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "RMDateSelectionViewController.h"

@interface ReleasePassengerViewController : UIViewController<UITextViewDelegate,RMDateSelectionViewControllerDelegate>

@property (nonatomic, strong) UITextView *txtView;

@end
