//
//  MyInfoViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-10.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "MyInfoViewController.h"
#import "SVProgressHUD.h"
#import "WriteInfoViewController.h"
#import "MyPathViewController.h"
#import "PopShareView.h"

static NSString *cellContentTitle[] = {@"认证资料",@"我的路线",@"告诉朋友",@"设置",@"反馈意见"};
static NSString *cellContentIcon[] = {@"my_verify_icon",@"my_path_icon",@"my_share_icon",@"my_set_icon",@"my_opinion_icon"};

@interface MyInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_myTableView;
}
@end

@implementation MyInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"我的";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self initLeftBarButton];
    
    [self initMainShowView];
}

- (void)initLeftBarButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 7, 25, 25)];
    
    [backBtn setImage:IMG(@"back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

- (void)backBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initMainShowView{
    _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0., ScreenWidth, 80.f)];
    headView.image = IMG(@"my_info_bg.png");
    headView.userInteractionEnabled = YES;
    headView.backgroundColor = [UIColor whiteColor];
    _myTableView.tableHeaderView = headView;
    
    UIImageView *headIcon = [[UIImageView alloc]initWithFrame:CGRectMake(15.f, 15., 50.f, 50.f)];
    headIcon.image = IMG(@"");
    headIcon.backgroundColor = [UIColor grayColor];
    headIcon.layer.borderWidth = 1;
    headIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    headIcon.clipsToBounds = YES;
    headIcon.layer.cornerRadius = 25;
    
    [headView addSubview:headIcon];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerClick:)];
    [headIcon addGestureRecognizer:tap];
    headIcon.userInteractionEnabled = YES;
    
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(80.f, 20.f, 200.f, 30)];
    userName.text = @"我是张三";
    userName.textColor = [UIColor whiteColor];
    [headView addSubview:userName];

}

- (void)headerClick:(UITapGestureRecognizer *)sender{
    UserInfoViewController *user = [[UserInfoViewController alloc]init];
    [self.navigationController pushViewController:user animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myCell = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.imageView.image = IMG(cellContentIcon[indexPath.row]);
    cell.textLabel.text = cellContentTitle[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            WriteInfoViewController *info = [[WriteInfoViewController alloc]init];
            [self.navigationController pushViewController:info animated:YES];
        }
            break;
        case 1:
        {
            MyPathViewController *path = [[MyPathViewController alloc]init];
            [self.navigationController pushViewController:path animated:YES];
        }
            break;
        case 2:
        {
            PopShareView *shareView = [PopShareView defaultExample];
            [shareView showPopupView:self.navigationController delegate:self shareType:ShareTypeThree];
        }
            break;
        case 3:
        {
            MySetViewController *setCtl = [[MySetViewController alloc]init];
            [self.navigationController pushViewController:setCtl animated:YES];
            
        }
            break;
        case 4:
        {
            FeedbackViewController *feedBackCtl = [[FeedbackViewController alloc]init];
            [self.navigationController pushViewController:feedBackCtl animated:YES];
            
        }
            break;
        default:
            break;
    }
   
}

@end
