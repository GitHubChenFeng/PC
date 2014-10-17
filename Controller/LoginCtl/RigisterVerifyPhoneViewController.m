//
//  RigisterVerifyPhoneViewController.m
//  PC
//
//  Created by MacBook Pro on 14-10-13.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "RigisterVerifyPhoneViewController.h"
#import "VerifyIdentityViewController.h"

@interface RigisterVerifyPhoneViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField *_phoneFeild;
    UITextField *_verifyFeild;
    UITextField *_passwordFeild;
    UITextField *_comfirmPwdFeild;
    UITableView *_mainTableView;
}
@end

@implementation RigisterVerifyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证手机号码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = 0;
    _mainTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainTableView];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, ScreenHeight)];
    _mainTableView.tableHeaderView = bgView;
    
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
    
    [bgView addSubview:numberView];
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
    
    [bgView addSubview:verifyView];
    
    UIButton *getVerifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getVerifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getVerifyBtn setBackgroundColor:RGB_BuleColor];
    [getVerifyBtn setFrame:CGRectMake( ScreenWidth - 120.f, 80.f, 100.f, 44.f)];
    [getVerifyBtn addTarget:self action:@selector(getVerifyClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:getVerifyBtn];
    
    
    /**
     密码
     */
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(20.f, 140.f, ScreenWidth - 40.f, 44.f)];
    pwdView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    pwdView.layer.borderWidth = 1;
    UILabel *pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(4.f, 5.f, 80.f, 30.f)];
    pwdLabel.text = @"密       码:";
    pwdLabel.textColor = [UIColor grayColor];
    [pwdView addSubview:pwdLabel];
    
    _passwordFeild = [[UITextField alloc]initWithFrame:CGRectMake(80.f, 2.f, 200.f, 40.f)];
    [_passwordFeild setClearButtonMode:UITextFieldViewModeWhileEditing];
    [pwdView addSubview:_passwordFeild];
    
    [bgView addSubview:pwdView];
    
    /**
     确认密码
     */
    UIView *comfirmPwdView = [[UIView alloc]initWithFrame:CGRectMake(20.f, 200.f, ScreenWidth - 40.f, 44.f)];
    comfirmPwdView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    comfirmPwdView.layer.borderWidth = 1;
    UILabel *cpwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(4.f, 5.f, 80.f, 30.f)];
    cpwdLabel.text = @"确认密码:";
    cpwdLabel.textColor = [UIColor grayColor];
    [comfirmPwdView addSubview:cpwdLabel];
    
    _comfirmPwdFeild = [[UITextField alloc]initWithFrame:CGRectMake(80.f, 2.f, 200.f, 40.f)];
    [_comfirmPwdFeild setClearButtonMode:UITextFieldViewModeWhileEditing];
    [comfirmPwdView addSubview:_comfirmPwdFeild];
    
    [bgView addSubview:comfirmPwdView];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(20.f, 270.f, ScreenWidth - 40, 40)];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:RGB_MainAppColor];
    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bgView addSubview:nextBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 下一步
 */
- (void)nextClick{
    [self setResign];
    
    VerifyIdentityViewController *virifyCtl = [[VerifyIdentityViewController alloc]init];
    [self.navigationController pushViewController:virifyCtl animated:YES];
}

/**
 *  获取验证码
 */
- (void)getVerifyClick{
    
}

- (void)setResign{
    [_phoneFeild resignFirstResponder];
    [_verifyFeild resignFirstResponder];
    [_comfirmPwdFeild resignFirstResponder];
    [_passwordFeild resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setResign];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _mainTableView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight +360);
    _mainTableView.contentOffset = CGPointMake(0.f, 160);
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _mainTableView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = 0;
        
    }
    cell.backgroundColor = [UIColor clearColor];

    
    
    return cell;
}
@end
