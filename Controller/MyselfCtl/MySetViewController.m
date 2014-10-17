//
//  MySetViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-27.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "MySetViewController.h"

static NSString *setCell[] = {@"修改密码",@"检查更新",@"关于我们"};

@interface MySetViewController ()

@end

@implementation MySetViewController

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
    
    self.title = @"设置";
    self.view.backgroundColor = RGB_MainBgColor;
    
    _setTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 44 *4 + 30) style:UITableViewStylePlain];
    _setTableView.delegate = self;
    _setTableView.dataSource = self;
    _setTableView.scrollEnabled = NO;
    [self.view addSubview:_setTableView];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 80.f)];
    footView.backgroundColor = RGB_MainBgColor;
    _setTableView.tableFooterView = footView;
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 1)];
    line.backgroundColor = RGB_TextLineLightGray;
    
    [footView addSubview:line];
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setFrame:CGRectMake(10.f, 30.f, ScreenWidth - 20, 40)];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setBackgroundColor:RGB_MainAppColor];
    [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:exitBtn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = 0;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
   
    cell.textLabel.text = setCell[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ModifyPasswordViewController *modifyPsd = [[ModifyPasswordViewController alloc]init];
        [self.navigationController pushViewController:modifyPsd animated:YES];
    }
}

@end
