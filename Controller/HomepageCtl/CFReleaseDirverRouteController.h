//
//  CFReleaseDirverRouteController.h
//  PC
//
//  Created by MacBook Pro on 14-9-9.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "RMDateSelectionViewController.h"
#import "SelectEndPointViewController.h"
#import "SelectStartPointViewController.h"
#import "PreviewPathViewController.h"

@interface CFReleaseDirverRouteController : CFBaseViewController<UITextViewDelegate,RMDateSelectionViewControllerDelegate,SelectEndPointViewControllerDelegate>

@property (nonatomic, strong) UITextView *txtView;
@property (nonatomic, strong) NSMutableArray *nearPointArr;//定位附近的地点

@end
