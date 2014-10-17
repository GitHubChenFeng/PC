//
//  VerifyIdentityViewController.m
//  PC
//
//  Created by MacBook Pro on 14-10-13.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "VerifyIdentityViewController.h"
#import "VerifyDriveViewController.h"

@interface VerifyIdentityViewController ()
{
    UITextField *_nameFeild;
    UITextField *_numberCardFeild;
}
@end

@implementation VerifyIdentityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"验证身份证";
    self.view.backgroundColor = [UIColor whiteColor];

    /**
     姓名
     */
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(20.f, 20.f, ScreenWidth - 40.f, 44.f)];
    nameView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    nameView.layer.borderWidth = 1;
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(4.f, 5.f, 80.f, 30.f)];
    nameLabel.text = @"姓名:";
    nameLabel.textColor = [UIColor grayColor];
    [nameView addSubview:nameLabel];
    
    _nameFeild = [[UITextField alloc]initWithFrame:CGRectMake(55.f, 2.f, 200.f, 40.f)];
   
    [_nameFeild setClearButtonMode:UITextFieldViewModeWhileEditing];
    [nameView addSubview:_nameFeild];
    
    [self.view addSubview:nameView];
    
    /**
     身份证号码
     */
    UIView *numberView = [[UIView alloc]initWithFrame:CGRectMake(20.f, 80.f, ScreenWidth - 40.f, 44.f)];
    numberView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    numberView.layer.borderWidth = 1;
    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(4.f, 5.f, 90.f, 30.f)];
    numLabel.text = @"身份证号码:";
    numLabel.textColor = [UIColor grayColor];
    [numberView addSubview:numLabel];
    
    _numberCardFeild = [[UITextField alloc]initWithFrame:CGRectMake(95.f, 2.f, 200.f, 40.f)];
    _numberCardFeild.keyboardType = UIKeyboardTypeNumberPad;
    [_numberCardFeild setClearButtonMode:UITextFieldViewModeWhileEditing];
    [numberView addSubview:_numberCardFeild];
    
    [self.view addSubview:numberView];
    
    UIButton *cardIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cardIdBtn setImage:IMG(@"verify_cardId_icon") forState:UIControlStateNormal];
    [cardIdBtn setFrame:CGRectMake((ScreenWidth - 180)/2, 150.f, 180.f, 135.f)];
    [self.view addSubview:cardIdBtn];
    
    UILabel *tip1 = [[UILabel alloc]initWithFrame:CGRectMake(20.f, 300.f, ScreenWidth - 40.f, 30)];
    tip1.text = @"1、验证身份证是为了保障用户的安全性；";
    tip1.font = KSystemFont(13);
    tip1.textColor = [UIColor lightGrayColor];
    [self.view addSubview:tip1];
    
    UILabel *tip2 = [[UILabel alloc]initWithFrame:CGRectMake(20.f, 320.f, ScreenWidth - 40.f, 30)];
    tip2.text = @"2、验证通过后系统不会泄漏任何个人信息。";
    tip2.font = KSystemFont(13);
    tip2.textColor = RGB(164, 0, 0);
    [self.view addSubview:tip2];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(20.f, 370.f, ScreenWidth - 40, 40)];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:RGB_MainAppColor];
    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
    UIButton *passBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [passBtn setFrame:CGRectMake(20.f, 425.f, ScreenWidth - 40, 40)];
    [passBtn setTitle:@"我是司机,跳过验证" forState:UIControlStateNormal];
 
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
    VerifyDriveViewController *driveCtl = [[VerifyDriveViewController alloc]init];
    [self.navigationController pushViewController:driveCtl animated:YES];
}

- (void)nextClick{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_nameFeild resignFirstResponder];
    [_numberCardFeild resignFirstResponder];
}

@end
