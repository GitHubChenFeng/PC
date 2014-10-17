//
//  MyPathViewController.m
//  PC
//
//  Created by MacBook Pro on 14-10-9.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "MyPathViewController.h"
#import "PathDetailViewController.h"
#import "MyPathCell.h"
#import "PathRecommendedCell.h"

@interface MyPathViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_mypathTableView;
}
@end

@implementation MyPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的路线";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mypathTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _mypathTableView.dataSource = self;
    _mypathTableView.delegate = self;
  
    [self.view addSubview:_mypathTableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"map_path_icon.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(mapClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  地图模式
 */
- (void)mapClick{
    
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
    MyPathCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[MyPathCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
