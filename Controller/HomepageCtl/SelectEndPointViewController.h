//
//  SelectEndPointViewController.h
//  PC
//
//  Created by MacBook Pro on 14-9-13.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "EGOCache.h"
#import "SearchResultCell.h"
#import "SearchPoiInfoViewController.h"
#import "CustomNavigationController.h"

typedef enum {
    SearchSkipTypeDefault,
	SearchSkipTypeMidPointPlace,
	SearchSkipTypeEndPointPlace,
}SearchSkipType;


@protocol SelectEndPointViewControllerDelegate <NSObject>

- (void)selectSearchResult:(NSArray *)coor;

@end

@interface SelectEndPointViewController : UIViewController<BMKPoiSearchDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>{
    __unsafe_unretained id<SelectEndPointViewControllerDelegate>delegate;
}

@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSMutableArray *resultArr;
@property (nonatomic, strong) NSMutableArray *resultDetailArr;

@property (nonatomic, strong) NSMutableArray *allItems;
@property (nonatomic, strong) NSMutableArray *allDetailItems;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *searchTableView;

@property (nonatomic, assign) SearchSkipType searchType;
@property (nonatomic, assign) int midIndex;
@property (nonatomic, assign) id<SelectEndPointViewControllerDelegate>delegate;

@end

