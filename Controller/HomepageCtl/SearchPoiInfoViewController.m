//
//  SearchPoiInfoViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-20.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "SearchPoiInfoViewController.h"

@interface SearchPoiInfoViewController ()

@end

@implementation SearchPoiInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOSVersion >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    _resultArr = [[NSMutableArray alloc]initWithCapacity:0];
    _allItems = [[NSMutableArray alloc]initWithCapacity:0];
    
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
    self.view.alpha = 0.5;
    
//    [self createMainShowView];
}
- (void)createMainShowView{
    
    if (_listTableView == nil) {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0.f, ScreenWidth, ScreenHeight-44) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        
    }
    
    [self.view addSubview:_listTableView];
    
    [self performSelector:@selector(searchBecomeFirstResponder) withObject:nil afterDelay:0.2];
}

- (void)searchBecomeFirstResponder{
    
    [self.searchBar becomeFirstResponder];
}

- (void)cancelSearch{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

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
    tips.text = @"搜索结果";
    
    return tips;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *const reuseIdentifier = @"Cell";

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
