//
//  MySetViewController.h
//  PC
//
//  Created by MacBook Pro on 14-9-27.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModifyPasswordViewController.h"

@interface MySetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_setTableView;
}

@end
