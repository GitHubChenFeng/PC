//
//  WriteInfoViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-29.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "WriteInfoViewController.h"

static NSString *cell_info_str[] = {@"昵      称",@"性       别",@"个性签名"};

@interface WriteInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UITextFieldDelegate>
{
    UITableView *_infoTabelView;
    UITextField *_nickNameField;
    UITextField *_signatureField;
}
@end

@implementation WriteInfoViewController

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
    
    self.title = @"填写个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _infoTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _infoTabelView.dataSource = self;
    _infoTabelView.delegate = self;
    _infoTabelView.separatorStyle = 0;
    [self.view addSubview:_infoTabelView];
    
    [self initTabelViewHeadView];
}

- (void)initTabelViewHeadView{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 140.f)];
    
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = CGRectMake((ScreenWidth - 80)/2, 20.f, 80.f, 80.f);
    headerBtn.backgroundColor = [UIColor whiteColor];
    [headerBtn setImage:IMG(@"white_info_head") forState:UIControlStateNormal];
    [headerBtn addTarget:self action:@selector(uploadHeadImage) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:headerBtn];
    
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.f, CGRectGetMaxY(headerBtn.frame) + 5, ScreenWidth, 30.f)];
    headLabel.text = @"上传头像";
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.textColor = RGB_TextLightGray;
    [headView addSubview:headLabel];
    
    _infoTabelView.tableHeaderView = headView;
    
    if (IsiOS7Later){
        _nickNameField = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 200, 35)];
        
    }else{
        _nickNameField = [[UITextField alloc] initWithFrame:CGRectMake(100, 20, 200, 35)];
        
    }
    _nickNameField.clearButtonMode = 1;
    _nickNameField.delegate = self;
    _nickNameField.font = [UIFont systemFontOfSize:17];
  
    if (IsiOS7Later){
        _signatureField = [[UITextField alloc] initWithFrame:CGRectMake(100, 15, 200, 35)];
        
    }else{
        _signatureField = [[UITextField alloc] initWithFrame:CGRectMake(100, 20, 200, 35)];
        
    }
    _signatureField.clearButtonMode = 1;
    _signatureField.delegate = self;
    _signatureField.font = [UIFont systemFontOfSize:17];
    
    
}

- (void)uploadHeadImage{
    [self resignField];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    actionSheet.tag = 'a';
    [actionSheet showInView:SharedApplication.keyWindow];
}

- (void)nextClick{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self resignField];
}

- (void)resignField{
    [_nickNameField resignFirstResponder];
    [_signatureField resignFirstResponder];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

- (void)moveUpView
{
    NSTimeInterval animationDuration=0.23f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    _infoTabelView.contentSize = CGSizeMake(ScreenWidth, 770);
    _infoTabelView.contentOffset = CGPointMake(0.f, 160);
    [UIView commitAnimations];
}

//恢复原始视图位置
- (void)resumeView
{
    NSTimeInterval animationDuration=0.23f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    _infoTabelView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight + 100);
    _infoTabelView.contentOffset = CGPointMake(0.f, 0.f);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self moveUpView];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignField];
    [self resumeView];
    return YES;
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

        cell.textLabel.text = [NSString stringWithFormat:@" %@:",cell_info_str[indexPath.row]];
    }
    
    
    switch (indexPath.row) {
        case 0:
        {
            [cell addSubview:_nickNameField];
        }
            break;
        case 1:
        {
            UIButton *manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [manBtn setFrame:CGRectMake(ScreenWidth - 90.f, 15.f, 30.f, 30.f)];
            [manBtn setBackgroundColor:[UIColor clearColor]];
            [manBtn setImage:IMG(@"white_info_sex") forState:UIControlStateNormal];
            [cell.contentView addSubview:manBtn];
            
            UIButton *wemanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [wemanBtn setFrame:CGRectMake(ScreenWidth - 50.f, 15.f, 30.f, 30.f)];
            [wemanBtn setBackgroundColor:[UIColor clearColor]];
            [wemanBtn setImage:IMG(@"white_info_sex") forState:UIControlStateNormal];
            [cell.contentView addSubview:wemanBtn];
            
        }
            break;
        case 2:
        {
            [cell addSubview:_signatureField];
        }
            break;
        case 3:
        {
            UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [nextBtn setFrame:CGRectMake(10.f, 20.f, ScreenWidth - 20, 40)];
            [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
            [nextBtn setBackgroundColor:RGB_MainAppColor];
            [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
            [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.contentView addSubview:nextBtn];
        }
            break;
        default:
            break;
    }


    return cell;
}

@end
