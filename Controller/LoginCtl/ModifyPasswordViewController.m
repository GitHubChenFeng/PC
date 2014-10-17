//
//  ModifyPasswordViewController.m
//  就医160
//
//  Created by meng on 14-1-4.
//  Copyright (c) 2014年 meng. All rights reserved.
//

#import "ModifyPasswordViewController.h"

static NSString *cell_pas_str[] = {@"原始密码",@"新密码",@"确认新密码"};

@implementation ModifyPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _modifyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 60 * 4) style:UITableViewStylePlain];
    _modifyTableView.delegate = self;
    _modifyTableView.dataSource = self;
    _modifyTableView.scrollEnabled = NO;
    
    _modifyTableView.separatorStyle = 0;
    
    [self.view addSubview:_modifyTableView];
    _modifyTableView.backgroundView = nil;
    _modifyTableView.backgroundColor = RGBA(239,242,244,1);
    self.view.backgroundColor = RGBA(239,242,244,1);
    self.title = @"修改密码";

    if (IsiOS7Later){
        _oldPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 200, 35)];
        
    }else{
        _oldPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 20, 200, 35)];
        
    }
    _oldPasswordTextField.clearButtonMode = 1;
    _oldPasswordTextField.font = [UIFont systemFontOfSize:17];
    _oldPasswordTextField.secureTextEntry = YES;
    
    
    if (IsiOS7Later){
        _newwPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 200, 35)];
        
    }else{
        _newwPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 20, 200, 35)];
        
    }
    _newwPasswordTextField.clearButtonMode = 1;
    _newwPasswordTextField.font = [UIFont systemFontOfSize:17];
    _newwPasswordTextField.secureTextEntry = YES;
    
    
    if (IsiOS7Later){
        _rnewwPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(115, 15, 200, 35)];
        
    }else{
        _rnewwPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(115, 20, 200, 35)];
        
    }
    _rnewwPasswordTextField.clearButtonMode = 1;
    _rnewwPasswordTextField.font = [UIFont systemFontOfSize:17];
    _rnewwPasswordTextField.secureTextEntry = YES;

    [_oldPasswordTextField becomeFirstResponder];
}

- (void)dealloc
{
    [_request clearDelegatesAndCancel];
}

- (void)viewWillDisappear:(BOOL)animated{

    [_request clearDelegatesAndCancel];
}


- (void)saveNewPaswword
{
    [_oldPasswordTextField resignFirstResponder];
    [_newwPasswordTextField resignFirstResponder];
    [_rnewwPasswordTextField resignFirstResponder];

    [self requestInfoModify];
}

- (void)requestInfo                                   
{
    if (_oldPasswordTextField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"请输入旧密码" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
    }else if (_newwPasswordTextField.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"请输入新密码" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
    }else if (_rnewwPasswordTextField.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"请重复输入新密码" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
    }else if (![_newwPasswordTextField.text isEqualToString:_rnewwPasswordTextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"您2次输入的新密码不一致" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
        
    }else{
  
//        _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:XIUGAIMIMAHTTPURL]];
//        
//        [_request setPostValue:TOKEN forKey:@"token"];
//        [_request setPostValue:GETSELECTCITYID  forKey:@"city_id"];
//        [_request setPostValue:GETUSERID forKey:@"f_id"];
//        
//        [_request setPostValue:_oldPasswordTextField.text forKey:@"oldpwd"];
//        [_request setPostValue:_newwPasswordTextField.text forKey:@"newpwd"];
//        
//        _request.delegate = self;
//        
//        [_request startAsynchronous];
    }
    
}

- (void)requestInfoModify
{

//    _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:ZHAOHUIMIMAHTTPURL]];
//    
//    [_request setPostValue:TOKEN forKey:@"token"];
//    [_request setPostValue:GETSELECTCITYID  forKey:@"city_id"];
//    [_request setPostValue:GETUSERID forKey:@"f_id"];
//   
//    [_request setPostValue:_oldPasswordTextField.text forKey:@"password"];
//  
//    _request.delegate = self;
//    
//    [_request startAsynchronous];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{

    NSDictionary *dict = [request responseString];
    MLOG(@"%@",dict);
    
    if ([[dict objectForKey:@"status"] intValue]>0) {
    
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
      
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
 
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
    
    if (indexPath.row !=3) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10.f, 8.f, ScreenWidth - 20.f, 44.f)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.borderColor = RGB_TextLineLightGray.CGColor;
        bgView.layer.borderWidth = 1;
        
        [cell.contentView addSubview:bgView];
    }

    
    switch (indexPath.row) {
        case 0:
        {
            [cell addSubview:_oldPasswordTextField];
        }
            break;
        case 1:
        {
            [cell addSubview:_newwPasswordTextField];
        }
            break;
        case 2:
        {
            [cell addSubview:_rnewwPasswordTextField];
        }
            break;
        case 3:
        {
            UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [exitBtn setFrame:CGRectMake(10.f, 20.f, ScreenWidth - 20, 40)];
            [exitBtn setTitle:@"确认修改" forState:UIControlStateNormal];
            [exitBtn setBackgroundColor:RGB_MainAppColor];
            [exitBtn addTarget:self action:@selector(saveNewPaswword) forControlEvents:UIControlEventTouchUpInside];
            [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.contentView addSubview:exitBtn];
        }
            break;
        default:
            break;
    }
    if (indexPath.row !=3) {
        cell.textLabel.text = [NSString stringWithFormat:@" %@:",cell_pas_str[indexPath.row]];

    }
 
    return cell;
}

@end
