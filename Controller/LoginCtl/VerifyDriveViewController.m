//
//  VerifyDriveViewController.m
//  PC
//
//  Created by MacBook Pro on 14-10-13.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "VerifyDriveViewController.h"
#import "VerifyCarDriveViewController.h"

@interface VerifyDriveViewController ()

@end

@implementation VerifyDriveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"验证驾驶证";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *driveFrontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [driveFrontBtn setImage:IMG(@"driving_front_icon") forState:UIControlStateNormal];
    [driveFrontBtn setFrame:CGRectMake(30, 50.f, 120.f, 90.f)];
    [self.view addSubview:driveFrontBtn];
    
    UIButton *driveBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [driveBackBtn setImage:IMG(@"driving_back_icon") forState:UIControlStateNormal];
    [driveBackBtn setFrame:CGRectMake(180, 50.f, 120.f, 90.f)];
    [self.view addSubview:driveBackBtn];
    
    UILabel *tip1 = [[UILabel alloc]initWithFrame:CGRectMake(20.f, 160.f, ScreenWidth - 40.f, 40)];
    tip1.text = @"1、验证驾驶证是为了验证驾驶能力和资格；\n2、验证通过后仅会显示性别、年龄和驾龄;";
    tip1.font = KSystemFont(13);
    tip1.numberOfLines = 2;
    tip1.textColor = [UIColor lightGrayColor];
    [self.view addSubview:tip1];
    
    UILabel *tip2 = [[UILabel alloc]initWithFrame:CGRectMake(20.f, 190.f, ScreenWidth - 40.f, 30)];
    tip2.text = @"3、不会泄漏其他个人信息。";
    tip2.font = KSystemFont(13);
    tip2.textColor = RGB(164, 0, 0);
    [self.view addSubview:tip2];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(20.f, 245.f, ScreenWidth - 40, 40)];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:RGB_MainAppColor];
    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
    UIButton *passBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [passBtn setFrame:CGRectMake(20.f, 300.f, ScreenWidth - 40, 40)];
    [passBtn setTitle:@"我是乘客,跳过验证" forState:UIControlStateNormal];
    
    [passBtn addTarget:self action:@selector(passClick) forControlEvents:UIControlEventTouchUpInside];
    [passBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    passBtn.layer.borderColor = RGB_MainAppColor.CGColor;
    passBtn.layer.borderWidth = 0.8;
    [self.view addSubview:passBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)passClick{
    
}

- (void)nextClick{
    VerifyCarDriveViewController *carCtl = [[VerifyCarDriveViewController alloc]init];
    [self.navigationController pushViewController:carCtl animated:YES];
}


@end
