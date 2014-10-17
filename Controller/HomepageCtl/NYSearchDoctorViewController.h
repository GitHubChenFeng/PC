//
//  NYSearchDoctorViewController.h
//  就医160
//
//  Created by MacBook Pro on 14-7-18.
//  Copyright (c) 2014年 meng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SearchTypeDefault,
	SearchTypeConsult,
	SearchTypePrivateDoctor,
	SearchTypeAddNumber,
}SearchType;

@interface NYSearchDoctorViewController : UIViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UISearchBar *searchBar;
@property (nonatomic , strong) UISearchDisplayController *searchCtl;

@property (nonatomic , assign) int currentPage;
@property (nonatomic , assign) BOOL isShowDelete;
@property (nonatomic , strong) UITableView *listTableView;
@property (nonatomic , assign) SearchType searchTypes;
@end
