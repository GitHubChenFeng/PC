//
//  SelectEndPointViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-13.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "SelectEndPointViewController.h"

NSString * const CellIdentifier = @"CellIdentifiers";
NSString * const searchCellIdentifier = @"searchCellIdentifier";

@interface SelectEndPointViewController ()<BMKGeoCodeSearchDelegate>
{
    BMKPoiSearch* _poisearch;
    BMKGeoCodeSearch *_geocodesearch;
}
@end

@implementation SelectEndPointViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOSVersion >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, ScreenHeight - 49) style:UITableViewStylePlain];
    _searchTableView.dataSource = self;
    _searchTableView.delegate = self;
    
    [self.view addSubview:_searchTableView];
    
    [self initSearchBarCtl];
    
    _poisearch = [[BMKPoiSearch alloc]init];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    
    MLOG(@"searchType==%d",self.searchType);
    
    if (self.searchType == SearchSkipTypeEndPointPlace) {
        self.title = @"选择目的地";
    }else if (self.searchType == SearchSkipTypeMidPointPlace) {
        self.title = @"选择中转点";
    }
    
}

- (void)initSearchBarCtl{
    
    _searchBar = [[UISearchBar alloc] init];
    [_searchBar sizeToFit];
    _searchBar.placeholder = @"输入终点";
    _searchBar.delegate = self;
    _searchBar.barStyle = UIBarStyleDefault;
    _searchTableView.tableHeaderView = self.searchBar;

    _resultArr = [[NSMutableArray alloc]initWithCapacity:0];
    _resultDetailArr = [[NSMutableArray alloc]initWithCapacity:0];
    _allItems = [[NSMutableArray alloc]initWithCapacity:0];
    _allDetailItems = [[NSMutableArray alloc]initWithCapacity:0];
}

- (void)clearSearchCache{
    
    if ([[EGOCache currentCache] hasCacheForKey:kSearchPlace])
    {
        [[EGOCache currentCache]removeCacheForKey:kSearchPlace];
        [_searchTableView reloadData];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _poisearch.delegate = self;
    [_searchBar resignFirstResponder];
    
    switch (self.searchType) {
        case SearchSkipTypeEndPointPlace:
        {
            if ([[EGOCache currentCache] hasCacheForKey:kSearchPlace]) {
                NSMutableArray *arr = (NSMutableArray *)[[EGOCache currentCache] objectForKey:kSearchPlace];
                [self handleSearchOldData:arr];
             
            }
        }
            break;
        case SearchSkipTypeMidPointPlace:
        {
            
        }
            break;
        default:
            break;
    }
    
}


- (void)viewWillDisappear:(BOOL)animated{
    _poisearch.delegate = nil;
}

- (void)handleSearchOldData:(NSMutableArray *)arr{

    _allItems = arr;
    
    [_resultArr addObjectsFromArray:arr];
    
    [_searchTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkGeocodeSearchOption:(NSString *)address whthBMKGeoCodeSearch:(BMKGeoCodeSearch *)geocodesearch{
    
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= [ManageCenter shareManager].locatCity;

    geocodeSearchOption.address = GETBeginDepart;

    BOOL flag = [geocodesearch geoCode:geocodeSearchOption];
    
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}


#pragma mark - BMKGeoCodeSearch
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    MLOG(@"%f",result.location.latitude);

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.allDetailItems.count > 0) {
        return 60.f;
    }
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SearchResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (self.allItems.count > 0) {
        cell.titileL.text = self.allItems[indexPath.row];
        
        [self.searchBar resignFirstResponder];
    }
    if (self.allDetailItems.count > 0) {
        cell.detailTitleL.text = self.allDetailItems[indexPath.row];
        cell.iconImg.image = IMG(@"search_icon");
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.searchType) {
        case SearchSkipTypeEndPointPlace:
        {
            
            if (self.allItems.count > 0) {
                SETDestination(self.allItems[indexPath.row]);
            }else{
                SETDestination(self.resultArr[indexPath.row]);
            }
        }
            break;
        case SearchSkipTypeMidPointPlace:
        {
            if (self.midIndex == 0) {
                if (self.allItems.count > 0) {
                    SETMidPlaceOne(self.allItems[indexPath.row]);
                }else{
                    SETMidPlaceOne(self.resultArr[indexPath.row]);
                }
                
            }else if (self.midIndex == 1){
                if (self.allItems.count > 0) {
                    SETMidPlaceTwo(self.allItems[indexPath.row]);
                }else{
                    SETMidPlaceTwo(self.resultArr[indexPath.row]);
                }
            }else if (self.midIndex == 2){
                if (self.allItems.count > 0) {
                    SETMidPlaceThere(self.allItems[indexPath.row]);
                }else{
                    SETMidPlaceThere(self.resultArr[indexPath.row]);
                }
            }
        }
            break;
        default:
            break;
    }

    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.searchType == SearchSkipTypeEndPointPlace) {
        return 60.f;
    }else{
        return 0.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.searchType == SearchSkipTypeEndPointPlace) {
        UIView *footClearView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 60.f)];
        
        UIImageView *clearIcon = [[UIImageView alloc]initWithFrame:CGRectMake(100.f, 10.f, 30.f, 30.f)];
        clearIcon.image = IMG(@"");
        clearIcon.backgroundColor = [UIColor redColor];
        [footClearView addSubview:clearIcon];
        
        UIButton *tips = [[UIButton alloc]initWithFrame:CGRectMake(135.f, 10.f, 100., 30.f)];
        [tips setTitle:@"清空历史" forState:UIControlStateNormal];
        [tips setTitleColor:RGB_TextDarkGray forState:UIControlStateNormal];
        [tips addTarget:self action:@selector(clearSearchCache) forControlEvents:UIControlEventTouchUpInside];
        
        [footClearView addSubview:tips];
        return footClearView;
    }else{
        return nil;
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    for(id cc in  [[[self.searchBar subviews] objectAtIndex:0] subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = NO;
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 20;
    citySearchOption.city= [ManageCenter shareManager].locatCity;
    citySearchOption.keyword = _searchBar.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
    
    if (_resultArr.count > 0) {
        [_resultArr insertObject:searchBar.text atIndex:0];
    }else{
        
        [_resultArr addObject:searchBar.text];
    }
    
    [[EGOCache currentCache] setObject:_resultArr forKey:kSearchPlace];

}

#pragma mark - implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        if (self.allItems.count > 0) {
            [self.allItems removeAllObjects];
        }
		for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            [_allItems addObject:poi.name];
            [_allDetailItems addObject:poi.address];
            
            MLOG(@"poi=%@",poi.name);
		}
        
        [self.searchTableView reloadData];
        
	} else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{

    if ([self.resultArr count] == 0) {
        
        UITableView *tableView1 = self.searchDisplayController.searchResultsTableView;
        
        for( UIView *subview in tableView1.subviews ) {
            
            if([subview isKindOfClass:[UILabel class]]) {
                
                UILabel *lbl = (UILabel*)subview; // sv changed to subview.
                
                lbl.text = @"没有你要搜索的结果";
                
            }
        }
    }
    // Return YES to cause the search result table view to be reloaded.
    return YES;
    
}

@end
