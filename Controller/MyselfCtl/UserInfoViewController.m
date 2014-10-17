//
//  UserInfoViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-28.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "UserInfoViewController.h"

static NSString *userInfoCell[] = {@"头像",@"昵称",@"性别",@"个性签名"};

@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_userTabelView;
}
@end

@implementation UserInfoViewController

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
    
    self.title = @"个人资料";
    self.view.backgroundColor = RGB_MainBgColor;
    
    _userTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 44 *4 + 36) style:UITableViewStylePlain];
    _userTabelView.delegate = self;
    _userTabelView.dataSource = self;
    _userTabelView.scrollEnabled = NO;
    [self.view addSubview:_userTabelView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80.f;
    }else{
        return 44.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = 0;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
  
    cell.textLabel.text = userInfoCell[indexPath.row];
    
    if (indexPath.row == 0) {
        UIImageView *headIcon = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 90.f, 10., 60.f, 60.f)];
        headIcon.image = IMG(@"");
        headIcon.backgroundColor = [UIColor grayColor];
        headIcon.layer.borderWidth = 1;
        headIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        headIcon.clipsToBounds = YES;
        headIcon.layer.cornerRadius = 30;
        
        [cell.contentView addSubview:headIcon];
    }else{
       
        cell.detailTextLabel.text = userInfoCell[indexPath.row];
    }
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
        actionSheet.tag = 'a';
        [actionSheet showInView:SharedApplication.keyWindow];
        
    }else if (indexPath.row == 1) {
        NicknameViewController *nickName = [[NicknameViewController alloc]init];
        [self.navigationController pushViewController:nickName animated:YES];
        
    }else if (indexPath.row == 2) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        actionSheet.tag = 'b';
        [actionSheet showInView:SharedApplication.keyWindow];
    }else if (indexPath.row == 3) {
        SignatureViewController *nickName = [[SignatureViewController alloc]init];
        [self.navigationController pushViewController:nickName animated:YES];
        
    }
}

@end
