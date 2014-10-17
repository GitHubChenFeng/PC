//
//  SearchPoiInfoViewController.h
//  PC
//
//  Created by MacBook Pro on 14-9-20.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPoiInfoViewController : UIViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UISearchBar *searchBar;
@property (nonatomic , strong) UISearchDisplayController *searchCtl;

@property (nonatomic, strong) NSMutableArray *resultArr;
@property (nonatomic, strong) NSMutableArray *allItems;

@property (nonatomic , strong) UITableView *listTableView;

@end
