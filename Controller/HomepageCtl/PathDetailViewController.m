//
//  PathDetailViewController.m
//  PC
//
//  Created by MacBook Pro on 14-10-9.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "PathDetailViewController.h"
#import "PathDetailCell.h"

static NSString *cell_info_str[] = {@"出发时间",@"出  发  地",@"目  的  地",@"途径地点",@"留       言"};

@interface PathDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_pathDetailTableView;
}
@end

@implementation PathDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详细信息";
    
    if (IOSVersion >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    _pathDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _pathDetailTableView.dataSource = self;
    _pathDetailTableView.delegate = self;
//    _pathDetailTableView.separatorStyle = 0;
    [self.view addSubview:_pathDetailTableView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80.f;
    }else if (indexPath.row == 5){
        return 45;
    }else{
        return 45.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PathDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[PathDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = 0;
        
    }
    
    if (indexPath.row == 0) {
        UIImageView *headIcon = [[UIImageView alloc]initWithFrame:CGRectMake(25.f, 10., 60.f, 60.f)];
        headIcon.image = IMG(@"");
        headIcon.backgroundColor = [UIColor grayColor];
        headIcon.layer.borderWidth = 1;
        headIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        headIcon.clipsToBounds = YES;
        headIcon.layer.cornerRadius = 30;
        
        [cell.contentView addSubview:headIcon];
        
        cell.titleDetailLabel.text = @"我是超人";
        cell.titleDetailLabel.font = KSystemFont(19);
        cell.titleDetailLabel.textColor = RGB_MainAppColor;
        cell.titleDetailLabel.frame = CGRectMake(100.f, 25.f, 200.f, 30.f);
    }else{
        cell.titleLabel.text = cell_info_str[indexPath.row - 1];
        cell.titleDetailLabel.text = cell_info_str[indexPath.row - 1];
        [cell.mapButton setImage:IMG(@"map_path_icon") forState:UIControlStateNormal];
    }
    
    return cell;
}

@end
