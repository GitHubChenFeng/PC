//
//  NYSearchDoctorViewController.m
//  就医160
//
//  Created by MacBook Pro on 14-7-18.
//  Copyright (c) 2014年 meng. All rights reserved.
//

#import "NYSearchDoctorViewController.h"
#import "NYSearchDocCell.h"


@interface NYSearchDoctorViewController ()
{
    NSMutableArray *_resultArr;
    NSMutableArray *_searchHistoryArr;
    NSMutableArray *_cacheHistoryArr;
    UISearchBar *_searchBar;
    UILabel *_noSearchList;
}
@property (nonatomic , strong) NSString *searchTips;

@end

#define kSearchHistoryTag @"searchResult91160"

@implementation NYSearchDoctorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated{
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOSVersion >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];

    _currentPage = 1;
    
    _resultArr = [[NSMutableArray alloc]initWithCapacity:0];
    _searchHistoryArr = [[NSMutableArray alloc]initWithCapacity:0];
    _cacheHistoryArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 290, 44)];
    self.searchBar.delegate = self;
    self.searchBar.backgroundColor = [UIColor clearColor];
    
    self.searchBar.placeholder = @"搜索";
    self.searchBar.tintColor = RGB(26, 188, 156);
    [self.searchBar sizeToFit];
    
    self.navigationItem.titleView = self.searchBar;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelSearch)];
    
    if (IOSVersion >= 7){
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor lightGrayColor];
    }
    
    
    [self createMainShowView];
}

- (void)createMainShowView{
    
    if (_listTableView == nil) {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0.f, ScreenWidth, ScreenHeight-44) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
       
    }
   
    [self.view addSubview:_listTableView];
    
    [self performSelector:@selector(searchBecomeFirstResponder) withObject:nil afterDelay:0.2];
    
//    if ([[EGOCache currentCache] hasCacheForKey:kSearchHistoryTag]) {
//        NSMutableArray *resultArr = (NSMutableArray *)[[EGOCache currentCache] plistForKey:kSearchHistoryTag];
//        [_searchHistoryArr addObjectsFromArray:resultArr];
//        
//        [self resultHandle:resultArr];
//        SETSEARCHLIST(@"YES");
//        
//        self.searchTips = @"  搜索记录";
//        self.listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        
//        [self removeTipsView];
//        
//    }else{
//        SETSEARCHLIST(@"NO");
//        [self.searchBar becomeFirstResponder];
//        self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        
//        [self searchTagTips];
//    }
}

- (void)searchTagTips{
    
//    if (_noSearchList == nil) {
//        _noSearchList = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 10.f, ScreenWidth, 40.f)];
//        _noSearchList.textAlignment = NSTextAlignmentCenter;
//        _noSearchList.text = @"亲，您还没有搜索记录哦";
//        _noSearchList.font = KSystemFont(15);
//        _noSearchList.textColor =  RGBCOLOR(41, 183, 237);
//    }
//   
//    [self.view addSubview:_noSearchList];
    
}

- (void)searchBecomeFirstResponder{
    
    [self.searchBar becomeFirstResponder];
}

- (void)removeTipsView{
    if (_noSearchList) {
        [_noSearchList removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelSearch{
     [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)resultHandle:(NSArray *)array
{
//    MLOG(@"医生列表：%@",array);
// 
//    for (int i = 0; i<array.count; i++) {
//        
//        NSDictionary *dict = [array objectAtIndex:i];
//        
//        KSYSList *list = [[KSYSList alloc]init];
//        list.image = [dict objectForKey:@"image"];
//        list.doctor_id = [dict objectForKey:@"doctor_id"];
//        list.doctor_name = [dict objectForKey:@"doctor_name"];
//        list.expert = [dict objectForKey:@"expert"];
//        list.unit_id = [dict objectForKey:@"unit_id"];
//        list.zcid = [dict objectForKey:@"zcid"];
//        list.dep_id = [dict objectForKey:@"dep_id"];
//        list.dep_name = [dict objectForKey:@"dep_name"];
//        list.unit_name = [dict objectForKey:@"unit_name"];
//        
//        [_resultArr addObject:list];
//    }
//    
//    _currentPage = _currentPage+1;

}


//医生搜索列表
- (void)requestSearchInfo:(NSString *)docName
{
//    ISLOADING;
//    _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:DOCTORSX_HTTPURL]];
//    MLOG(@"搜索医生列表URL ：%@==%@",DOCTORSX_HTTPURL,GETCHOOSECONSULTCITYID);
//    [_request setPostValue:TOKEN forKey:@"token"];
//    [_request setPostValue:GETCHOOSECONSULTCITYID forKey:@"city_id"];
//    [_request setPostValue:@"" forKey:@"cat_no"];
//    [_request setPostValue:@"" forKey:@"unit_id"];
//    
//    if (self.searchTypes == SearchTypeConsult) {
//       [_request setPostValue:@"1" forKey:@"ask"];
//    }else if (self.searchTypes == SearchTypePrivateDoctor){
//        [_request setPostValue:@"1" forKey:@"vip"];
//    }else if (self.searchTypes == SearchTypeAddNumber){
//        [_request setPostValue:@"1" forKey:@"sch"];
//    }
//    
//    [_request setPostValue:[NSString stringWithFormat:@"%d",_currentPage] forKey:@"p"];
//    [_request setPostValue:@"9" forKey:@"psize"];
//    [_request setPostValue:docName forKey:@"keyword"];
//    
//    _request.tag = 'a';
//    _request.delegate = self;
//    
//    [_request startAsynchronous];
}

//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//    NSDictionary *dict = [request responseString];
//    
//    if (_resultArr.count>0 && _currentPage == 1) {
//        [_resultArr removeAllObjects];
//    }
//    [self.searchBar resignFirstResponder];
//    
//    MLOG(@"数据结果:%@",dict);
//    
//    if ([[dict objectForKey:@"status"] intValue]>0) {
//        
//        self.listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        
//        NSArray *array = [dict objectForKey:@"data"];
//        
//        if (![[array class] isSubclassOfClass:[NSNull class]]) {
//            
//            dispatch_async(GLOBAL_QUEUE, ^{
//        
//                for (int i = array.count-1; i>=0; i--) {
//                    [_cacheHistoryArr insertObject:array[i] atIndex:0];
//                }
//
//                [_cacheHistoryArr addObjectsFromArray:_searchHistoryArr];
//                
//                [[EGOCache currentCache] setPlist:_cacheHistoryArr forKey:kSearchHistoryTag withTimeoutInterval:24*60*60];
//                
//                [self resultHandle:array];
//              
//                dispatch_async(MAIN_QUEUE, ^{
//                    if (blankView) {
//                        [blankView removeNullViewFromSuperview];
//                    }
//                    
//                    [self.listTableView reloadData];
//                    hiddentHUD;
//            
//                });
//            });
//            
//        }
//        else
//        {
//            [self.listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//            [self.listTableView reloadData];
//            hiddentHUD;
//
//            if (_resultArr.count == 0) {
//                
//                blankView = [NYNullPromptView initCreateNullStatusInView:self.view
//                                                               withFrame:CGRectMake(0.f, 0.f, ScreenWidth, ScreenHeight)
//                                                               whitImage:IMG(@"tip_error@2x")
//                                                                 andText:@"亲，没有你要搜索的结果"
//                                                                delegate:self
//                                                          withPromptView:blankView];
//            }
//            
//        }
//        
//    }
//    else
//    {
//
//        hiddentHUD;
//        
//        [[MBTipWindow GetInstance] showProgressHUDCompleteMessage:[dict objectForKey:@"msg"] type:EVENT_FAIL];
//        
//    }
//}
//
//- (void)requestFailed:(ASIHTTPRequest *)request
//{
//    hiddentHUD;
//
//}

//#pragma mark - PullTableViewDelegate
//
//- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
//{
//    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.0f];
//}
//
//- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
//{
//    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:0.0f];
//}
//
//- (int)getTableCellNumber
//{
//    if ([[EGOCache currentCache] hasCacheForKey:kSearchHistoryTag] && [GETSEARCHLIST isEqualToString:@"YES"]) {
//        return _resultArr.count + 1;
//        
//    }else{
//        return _resultArr.count;
//        
//    }
//}

#pragma mark - Refresh and load more methods
//- (void)refreshTable
//{
//    if (self.searchBar.text.length > 0) {
//        _currentPage = 1;
//        [self requestSearchInfo:self.searchBar.text];
//    }
//  
//}
//
//- (void)loadMoreDataToTable
//{
//     if (self.searchBar.text.length > 0) {
//         [self requestSearchInfo:self.searchBar.text];
//     }
//    hiddentHUD;
//}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
//    if ([[EGOCache currentCache] hasCacheForKey:kSearchHistoryTag] && [GETSEARCHLIST isEqualToString:@"YES"]) {
//        return _resultArr.count + 1;
//        
//    }else{
//        return _resultArr.count;
//        
//    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([[EGOCache currentCache] hasCacheForKey:kSearchHistoryTag] && [GETSEARCHLIST isEqualToString:@"YES"]) {
//        if (indexPath.row == _resultArr.count) {
//             return 40.0;
//        }else{
//             return 80.0;
//        }
//    }else{
//         return 80.0;
//    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_resultArr.count!=0) {
        return 30.f;
    }else{
        return 0.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *tips = [[UILabel alloc]initWithFrame:CGRectMake(20.f, 0.f, ScreenWidth, 44.f)];
    tips.backgroundColor = RGB(224, 224, 224);
    tips.textColor = [UIColor lightGrayColor];
    
    tips.font = KSystemFont(14);
    tips.text = self.searchTips;
  
    return tips;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *const reuseIdentifier = @"Cell";
    
//    KSYSList *list;
//    
//    if ([[EGOCache currentCache] hasCacheForKey:kSearchHistoryTag] && [GETSEARCHLIST isEqualToString:@"YES"]) {
//        
//        if (indexPath.row != _resultArr.count){
//            list = [_resultArr objectAtIndex:indexPath.row];
//        }
//        
//    }else{
//        list = [_resultArr objectAtIndex:indexPath.row];
//    }
    
    NYSearchDocCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        
        cell = [[NYSearchDocCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
       
    }
    
//    if (_resultArr.count !=0) {
//        
//        NSString* path =[NSString stringWithFormat: @"%@",list.image];
//        NSURL* url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        
//        [cell.avatar setImageWithURL:url placeholderImage:[UIImage imageNamed:@"jiahao2.png"]];
//        
//        cell.d_name.text = list.doctor_name;
//        
//        CGSize nameSize = [Common backStringSize:cell.d_name.text whitFontSize:17 whitHeight:17];
//        cell.h_name.frame = CGRectMake(72 + nameSize.width, 16, 100, 20);
//        
//        NSString *uname = list.unit_name;
//        NSString *hname = list.dep_name;
//        cell.k_name.text = [NSString stringWithFormat:@"%@  %@",uname,hname];
//        cell.h_name.text = [[Util sharedUtil] getDoctorLevel:list.zcid];
//        cell.expert.text = list.expert;
//        
//        
//        //如果有搜索记录添加清除按钮
//        if ([[EGOCache currentCache] hasCacheForKey:kSearchHistoryTag] && [GETSEARCHLIST isEqualToString:@"YES"]) {
//            
//            if (indexPath.row == _resultArr.count) {
//                cell.d_name.text = @"清除历史记录";
//                cell.d_name.frame = CGRectMake(0.f, 5.f, ScreenWidth, 30.f);
//                cell.d_name.textAlignment = NSTextAlignmentCenter;
//                cell.expert.hidden = YES;
//                cell.k_name.hidden = YES;
//                cell.h_name.hidden = YES;
//                cell.avatar.hidden = YES;
//            }else{
//                cell.d_name.frame = CGRectMake(65, 16, 200, 20);
//                cell.d_name.textAlignment = NSTextAlignmentLeft;
//                cell.expert.hidden = NO;
//                cell.k_name.hidden = NO;
//                cell.h_name.hidden = NO;
//                cell.avatar.hidden = NO;
//            }
//        }else{
//            cell.d_name.frame = CGRectMake(65, 16, 200, 20);
//            cell.d_name.textAlignment = NSTextAlignmentLeft;
//            cell.expert.hidden = NO;
//            cell.k_name.hidden = NO;
//            cell.h_name.hidden = NO;
//            cell.avatar.hidden = NO;
//        }
//    }
   
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([[EGOCache currentCache] hasCacheForKey:kSearchHistoryTag] && [GETSEARCHLIST isEqualToString:@"YES"]) {
//        if (indexPath.row == _resultArr.count){
//            
//            [[EGOCache currentCache] removeCacheForKey:kSearchHistoryTag];
//            
//            [_resultArr removeAllObjects];
//            [_searchHistoryArr removeAllObjects];
//            
//            [self.listTableView reloadData];
//            
//            SETSEARCHLIST(@"NO");
//            
//            self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//            
//            return;
//        }
//    }
//    
//    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    if (ISLOGIN) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        //进入医生主页
//        KSYSList *list = [_resultArr objectAtIndex:indexPath.row];
//        
//        DoctorDetailViewController *ysxqView = [[DoctorDetailViewController alloc]initWithStyle:UITableViewStylePlain];
//        
//        ysxqView.unit_id = list.unit_id;
//        ysxqView.dep_id = list.dep_id;
//        ysxqView.doctor_id = list.doctor_id;
//        ysxqView.doctor_name = list.doctor_name;
//       
//        ysxqView.type = @"0";
//        ysxqView.types= @"1";
//        [self.navigationController pushViewController:ysxqView animated:YES];
//    }
//    else{
//        LoginTableViewController *loginView = [[LoginTableViewController alloc] init];
//        loginView.delegate = self;
//        loginView.hidesBottomBarWhenPushed = YES;
//        CRNavigationController *nav = [[CRNavigationController alloc] initWithRootViewController:loginView];
//        loginView.accessType = AccessTypeConsult;
//        if ([CURRENT_VERSION intValue] >= 7){
//            [nav.navigationBar setBarTintColor:RGBCOLOR(26, 188, 156)];
//            
//        }else{
//            [nav.navigationBar setTintColor:RGBCOLOR(26, 188, 156)];
//        }
//        
//        [self.navigationController presentModalViewController:nav animated:YES];
//    }
    
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
//    if (self.searchBar.text.length > 0) {
//        _currentPage = 1;
//        self.searchTips = @"  搜索结果";
//        SETSEARCHLIST(@"NO");
//        
//        [self removeTipsView];
//        
//        [self requestSearchInfo:self.searchBar.text];
//        
//    }else{
//        
//        if (blankView) {
//            [blankView removeNullViewFromSuperview];
//        }
//        
//    }

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
//    if (searchText.length > 0) {
//        _currentPage = 1;
//        self.searchTips = @"  搜索结果";
//        SETSEARCHLIST(@"NO");
//        
//        [self removeTipsView];
//        
//    }else{
//        
//        if (blankView) {
//            [blankView removeNullViewFromSuperview];
//        }
//   
//    }
  
}



@end
