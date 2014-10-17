//
//  ForgetPasswordViewController.m
//  PC
//
//  Created by MacBook Pro on 14-10-9.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ResetPwdViewController.h"

@interface ForgetPasswordViewController ()
{
    UITextField *_phoneFeild;
    UITextField *_verifyFeild;
}
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     手机号码
     */
    UIView *numberView = [[UIView alloc]initWithFrame:CGRectMake(20.f, 20.f, ScreenWidth - 40.f, 44.f)];
    numberView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    numberView.layer.borderWidth = 1;
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(4.f, 5.f, 80.f, 30.f)];
    phoneLabel.text = @"手机号码:";
    phoneLabel.textColor = [UIColor grayColor];
    [numberView addSubview:phoneLabel];
    
    _phoneFeild = [[UITextField alloc]initWithFrame:CGRectMake(80.f, 2.f, 200.f, 40.f)];
    _phoneFeild.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneFeild setClearButtonMode:UITextFieldViewModeWhileEditing];
    [numberView addSubview:_phoneFeild];
    
    [self.view addSubview:numberView];
    /**
     *  验证码
     */
    UIView *verifyView = [[UIView alloc]initWithFrame:CGRectMake(20.f, 80.f, ScreenWidth - 160.f, 44.f)];
    verifyView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    verifyView.layer.borderWidth = 1;
    UILabel *verifyLabel = [[UILabel alloc]initWithFrame:CGRectMake(4.f, 5.f, 80.f, 30.f)];
    verifyLabel.text = @"验 证 码:";
    verifyLabel.textColor = [UIColor grayColor];
    
    [verifyView addSubview:verifyLabel];
    
    _verifyFeild = [[UITextField alloc]initWithFrame:CGRectMake(80.f, 2.f, 80.f, 40.f)];
    _verifyFeild.keyboardType = UIKeyboardTypeNumberPad;
    [_verifyFeild  setClearButtonMode:UITextFieldViewModeWhileEditing];
    [verifyView addSubview:_verifyFeild];
    
    [self.view addSubview:verifyView];
    
    UIButton *getVerifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getVerifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getVerifyBtn setBackgroundColor:RGB_BuleColor];
    [getVerifyBtn setFrame:CGRectMake( ScreenWidth - 120.f, 80.f, 100.f, 44.f)];
    [getVerifyBtn addTarget:self action:@selector(getVerifyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getVerifyBtn];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(20.f, 150.f, ScreenWidth - 40, 40)];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:RGB_MainAppColor];
    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
}
/**
 * 下一步
 */
- (void)nextClick{
    ResetPwdViewController *resetCtl = [[ResetPwdViewController alloc]init];
    [self.navigationController pushViewController:resetCtl animated:YES];
}

/**
 *  获取验证码
 */
- (void)getVerifyClick{

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_phoneFeild resignFirstResponder];
    [_verifyFeild resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
