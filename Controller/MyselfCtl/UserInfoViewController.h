//
//  UserInfoViewController.h
//  PC
//
//  Created by MacBook Pro on 14-9-28.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NicknameViewController.h"
#import "SignatureViewController.h"

@interface UserInfoViewController : UIViewController<UIActionSheetDelegate>

@property (nonatomic,assign) BOOL isCanModify;//能否修改个人资料
@end
