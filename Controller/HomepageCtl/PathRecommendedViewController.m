//
//  PathRecommendedViewController.m
//  PC
//
//  Created by MacBook Pro on 14-10-16.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "PathRecommendedViewController.h"
#import "PathDetailViewController.h"
#import "PathRecommendedCell.h"

@interface PathRecommendedViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_mypathTableView;
}
@end

@implementation PathRecommendedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"路线推荐";
    
    _mypathTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _mypathTableView.dataSource = self;
    _mypathTableView.delegate = self;
    
    [self.view addSubview:_mypathTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    PathRecommendedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[PathRecommendedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = 0;
        
    }
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PathDetailViewController *detail = [[PathDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
