//
//  ModifyPasswordViewController.h
//  就医160
//
//  Created by meng on 14-1-4.
//  Copyright (c) 2014年 meng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIFormDataRequest.h"

@interface ModifyPasswordViewController :UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_modifyTableView;
}
@property (nonatomic, strong) ASIFormDataRequest *request;
@property (nonatomic, strong) UITextField *oldPasswordTextField;
@property (nonatomic, strong) UITextField *newwPasswordTextField;
@property (nonatomic, strong) UITextField *rnewwPasswordTextField;
@property (nonatomic, assign) BOOL fromfindpass;

@end
