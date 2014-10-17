//
//  ResetPwdViewController.m
//  PC
//
//  Created by MacBook Pro on 14-10-9.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "ResetPwdViewController.h"

@interface ResetPwdViewController ()
{
    UITextField *_setFeild;
    UITextField *_resetFeild;
}
@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *setPwdView = [[UIView alloc]initWithFrame:CGRectMake(20.f, 20.f, ScreenWidth - 40.f, 44.f)];
    setPwdView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    setPwdView.layer.borderWidth = 1;
    UILabel *setLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.f, 5.f, 80.f, 30.f)];
    setLabel.text = @"设置密码:";
    setLabel.textColor = [UIColor grayColor];
    [setPwdView addSubview:setLabel];
    
    _setFeild = [[UITextField alloc]initWithFrame:CGRectMake(85.f, 2.f, 190.f, 40.f)];
    _setFeild.secureTextEntry = YES;
    [_setFeild setClearButtonMode:UITextFieldViewModeWhileEditing];
    [setPwdView addSubview:_setFeild];
    
    [self.view addSubview:setPwdView];
    
    UIView *resetView = [[UIView alloc]initWithFrame:CGRectMake(20.f, 85.f, ScreenWidth - 40.f, 44.f)];
    resetView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    resetView.layer.borderWidth = 1;
    UILabel *resetLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.f, 5.f, 100.f, 30.f)];
    resetLabel.text = @"确认新密码:";
    resetLabel.textColor = [UIColor grayColor];
    [resetView addSubview:resetLabel];
    
    _resetFeild = [[UITextField alloc]initWithFrame:CGRectMake(95.f, 2.f, 180.f, 40.f)];
    _resetFeild.secureTextEntry = YES;
    [_resetFeild setClearButtonMode:UITextFieldViewModeWhileEditing];
    [resetView addSubview:_resetFeild];
    
    [self.view addSubview:resetView];
    
    UIButton *achieveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [achieveBtn setFrame:CGRectMake(20.f, 150.f, ScreenWidth - 40, 40)];
    [achieveBtn setTitle:@"完 成" forState:UIControlStateNormal];
    [achieveBtn setBackgroundColor:RGB_MainAppColor];
    [achieveBtn addTarget:self action:@selector(achieveClick) forControlEvents:UIControlEventTouchUpInside];
    [achieveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:achieveBtn];
}

/**
 *  完成事件
 */
- (void)achieveClick{

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_setFeild resignFirstResponder];
    [_resetFeild resignFirstResponder];
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
