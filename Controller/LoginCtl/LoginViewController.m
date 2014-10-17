//
//  LoginViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-27.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "RigisterVerifyPhoneViewController.h"

@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_loginTableView;
}
@end

@implementation LoginViewController

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
    
    self.title = @"登录";
    self.view.backgroundColor = [UIColor colorWithPatternImage:IMG(@"Login_bg.png")];
    
    [self initLeftBarButton];
    
    [self loginMainView];
}

- (void)loginMainView{
    UIView *loginView = [[UIView alloc]initWithFrame:CGRectMake(30.f, 120.f, 260., 45)];
    loginView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
    
    [self.view addSubview:loginView];
    
    UIImageView *userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 25, 25)];
    userImgView.image = IMG(@"icon_user_login.png");
    userImgView.backgroundColor = [UIColor clearColor];
   
    [loginView addSubview:userImgView];
    
    UILabel *sline = [[UILabel alloc]initWithFrame:CGRectMake(48, 7, 0.8, 30)];
    sline.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:0.6];
    [loginView addSubview:sline];
    
    UITextField *nameText = [[UITextField alloc] initWithFrame:CGRectMake(55, 0, 245, 44)];
    self.userNameField = nameText;
    self.userNameField.borderStyle = UITextBorderStyleNone;
    self.userNameField.placeholder = @" 请输入手机号码";
    self.userNameField.textColor = [UIColor whiteColor];
    self.userNameField.delegate=self;
    self.userNameField.tag = 1;
    self.userNameField.font = [UIFont systemFontOfSize:15];
    self.userNameField.backgroundColor =[UIColor clearColor];
    self.userNameField.alpha = 0.5;
    
    self.userNameField.keyboardType = UIKeyboardTypeNumberPad;
    [self.userNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.userNameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [loginView addSubview:self.userNameField];
    
    
    if (![CommonMethod phoneNumberChecking:self.userNameField.text]&&self.userNameField.text.length!=0) {
        
        //                    [self checkProgressHUD:@"请输入正确的手机号码" andImage:nil];
    }
    
    UIView *loginPwdView = [[UIView alloc]initWithFrame:CGRectMake(30.f, 180.f, 260., 45)];
    loginPwdView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
    [self.view addSubview:loginPwdView];
    
    UIImageView *pwdImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 25, 25)];
    pwdImgView.image = IMG(@"icon_lock_login.png");
    pwdImgView.backgroundColor = [UIColor clearColor];
    [loginPwdView addSubview:pwdImgView];
    
    
    UILabel *slinee = [[UILabel alloc]initWithFrame:CGRectMake(48, 7, 0.8, 30)];
    slinee.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:0.6];
    [loginPwdView addSubview:slinee];
    
    UITextField *passwordText = [[UITextField alloc] initWithFrame:CGRectMake(55, 0, 245, 44)];
    self.userPwdField = passwordText;
    self.userPwdField.borderStyle = UITextBorderStyleNone;
    self.userPwdField.placeholder = @" 请输入密码";
    self.userPwdField.delegate=self;
    self.userPwdField.font = [UIFont systemFontOfSize:15];
    self.userPwdField.backgroundColor =[UIColor clearColor];
    [self.userPwdField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.userPwdField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [loginPwdView addSubview:self.userPwdField];
    self.userPwdField.secureTextEntry = YES;
    
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setFrame:CGRectMake(50.f, CGRectGetMaxY(loginPwdView.frame) + 5, 30.f, 30.f)];
    [selectBtn setImage:IMG(@"check_icon.png") forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setImageEdgeInsets:UIEdgeInsetsMake(15.f, 15.f, 15.f, 15.f)];
    [self.view addSubview:selectBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(loginPwdView.frame) + 5, 80, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"记住我";
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    UIButton *findPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [findPwdBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    [findPwdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [findPwdBtn setFrame:CGRectMake(ScreenWidth - 130.f, CGRectGetMaxY(loginPwdView.frame) + 5, 80.f, 30.f)];
    findPwdBtn.titleLabel.font = KSystemFont(15);
    [findPwdBtn addTarget:self action:@selector(findPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:findPwdBtn];
    
    UILabel *findLine = [[UILabel alloc]initWithFrame:CGRectMake(10.f, 24.f, 60.f, 0.8)];
    findLine.backgroundColor = [UIColor whiteColor];
    [findPwdBtn addSubview:findLine];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setFrame:CGRectMake(30.f, CGRectGetMaxY(findPwdBtn.frame) + 15, 110.f, 35.f)];
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    registerBtn.layer.borderWidth = 0.7;
    [self.view addSubview:registerBtn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setFrame:CGRectMake(ScreenWidth - 140.f, CGRectGetMaxY(findPwdBtn.frame) + 15, 110.f, 35.f)];
    [loginBtn setBackgroundColor:RGB_MainAppColor];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}

- (void)initLeftBarButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 7, 60, 30)];
    [backBtn setTitleColor:RGB_MainAppColor forState:UIControlStateNormal];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

/**
 *  返回
 */
- (void)backBtnClick{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 *  找回密码
 */
- (void)findPasswordClick{
    ForgetPasswordViewController *forgetPwd = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetPwd animated:YES];
}

/**
 *  注册
 */
- (void)registerClick{
    RigisterVerifyPhoneViewController *rigisterCtl = [[RigisterVerifyPhoneViewController alloc]init];
    [self.navigationController pushViewController:rigisterCtl animated:YES];
}

/**
 *  登录
 */
- (void)loginClick{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self resign];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 放弃第一响应者
- (void)resign{
    [_userNameField resignFirstResponder];
    [_userPwdField resignFirstResponder];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
        cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        
		switch (indexPath.row) {
            case 0:
            {
                UIImageView *userImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
                userImgView.image = IMG(@"icon_user_login.png");
                userImgView.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:userImgView];
                
                UILabel *sline = [[UILabel alloc]initWithFrame:CGRectMake(48, 12, 1, 20)];
                sline.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
                [cell.contentView addSubview:sline];
                
				UITextField *nameText = [[UITextField alloc] initWithFrame:CGRectMake(55, 0, 245, 44)];
                self.userNameField = nameText;
				self.userNameField.borderStyle = UITextBorderStyleNone;
                self.userNameField.placeholder = @" 请输入手机号码";
                self.userNameField.delegate=self;
                self.userNameField.tag = 1;
                self.userNameField.font = [UIFont systemFontOfSize:15];
				self.userNameField.backgroundColor =[UIColor clearColor];
                self.userNameField.alpha = 0.5;
             
				self.userNameField.keyboardType = UIKeyboardTypeNumberPad;
                [self.userNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
				[self.userNameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
				[cell.contentView addSubview:self.userNameField];

                
                if (![CommonMethod phoneNumberChecking:self.userNameField.text]&&self.userNameField.text.length!=0) {
                    
//                    [self checkProgressHUD:@"请输入正确的手机号码" andImage:nil];
                }
            }break;
            case 1:
            {
                UIImageView *pwdImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
                pwdImgView.image = IMG(@"icon_lock_login.png");
                pwdImgView.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:pwdImgView];
                
                
                UILabel *sline = [[UILabel alloc]initWithFrame:CGRectMake(48, 12, 1, 20)];
                sline.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
                [cell.contentView addSubview:sline];
                
				UITextField *passwordText = [[UITextField alloc] initWithFrame:CGRectMake(55, 0, 245, 44)];
                self.userPwdField = passwordText;
				self.userPwdField.borderStyle = UITextBorderStyleNone;
                self.userPwdField.placeholder = @" 请输入密码";
                self.userPwdField.delegate=self;
                self.userPwdField.font = [UIFont systemFontOfSize:15];
				self.userPwdField.backgroundColor =[UIColor clearColor];
                [self.userPwdField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
                [self.userPwdField setClearButtonMode:UITextFieldViewModeWhileEditing];
				[cell.contentView addSubview:self.userPwdField];
				self.userPwdField.secureTextEntry = YES;
	
            }break;
				
            default:
                break;
        }
    }
	
	return cell;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resign];
    return YES;
}

@end
