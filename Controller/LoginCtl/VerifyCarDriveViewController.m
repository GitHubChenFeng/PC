//
//  VerifyCarDriveViewController.m
//  PC
//
//  Created by MacBook Pro on 14-10-13.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "VerifyCarDriveViewController.h"

@interface VerifyCarDriveViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITextField *_carIdFeild;
    UITextField *_carframeFeild;
    UITextField *_engineIdFeild;
    UIPickerView *_pickerView;
    NSMutableArray *_carNumberArr;
    UIToolbar *toolbarView;
    UIButton *_selectPickerBtn;
}
@property (nonatomic ,strong) NSString *selectCarnumber;
@end

@implementation VerifyCarDriveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"验证行驶证";
    self.view.backgroundColor = [UIColor whiteColor];

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CityAbbre" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    /**
     获取所有城市缩写
     */
    _carNumberArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 1 ; i<=[data allValues].count; i++) {
        [_carNumberArr addObject:[data objectForKey:[NSString stringWithFormat:@"%d",i]]];
    }
    
    UIView *numberView = [[UIView alloc]initWithFrame:CGRectMake(20.f, 20.f, ScreenWidth - 40.f, 44.f)];
    numberView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    numberView.layer.borderWidth = 1;
    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(4.f, 5.f, 90.f, 30.f)];
    numLabel.text = @"车牌号码:";
    numLabel.textColor = [UIColor grayColor];
    [numberView addSubview:numLabel];
    
    _selectCarnumber = @"京";
    
    _selectPickerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectPickerBtn setFrame:CGRectMake(85.f, 0., 45.f, 40.f)];
    [_selectPickerBtn setTitle:_selectCarnumber forState:UIControlStateNormal];
    [_selectPickerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_selectPickerBtn addTarget:self action:@selector(pickerSelectCarIdClick) forControlEvents:UIControlEventTouchUpInside];
    [_selectPickerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [numberView addSubview:_selectPickerBtn];
    UIImageView *imgIcon = [[UIImageView alloc]initWithFrame:CGRectMake(25.f, 13., 15., 15.)];
    [imgIcon setImage:IMG(@"down_dark.png")];
    [_selectPickerBtn addSubview:imgIcon];
    
    _carIdFeild = [[UITextField alloc]initWithFrame:CGRectMake(135.f, 2.f, 200.f, 40.f)];
    _carIdFeild.keyboardType = UIKeyboardTypeNumberPad;

    [_carIdFeild setClearButtonMode:UITextFieldViewModeWhileEditing];
    [numberView addSubview:_carIdFeild];
    
    [self.view addSubview:numberView];
    
    UIView *carView = [[UIView alloc]initWithFrame:CGRectMake(20.f, 80.f, ScreenWidth - 40.f, 44.f)];
    carView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    carView.layer.borderWidth = 1;
    UILabel *carnumLabel = [[UILabel alloc]initWithFrame:CGRectMake(4.f, 5.f, 90.f, 30.f)];
    carnumLabel.text = @"车架号码:";
    carnumLabel.textColor = [UIColor grayColor];
    [carView addSubview:carnumLabel];
    
    _carframeFeild = [[UITextField alloc]initWithFrame:CGRectMake(85.f, 2.f, 200.f, 40.f)];
    _carframeFeild.keyboardType = UIKeyboardTypeNumberPad;
    _carframeFeild.placeholder = @"请输入后6位号码";
    [_carframeFeild setClearButtonMode:UITextFieldViewModeWhileEditing];
    [carView addSubview:_carframeFeild];
    
    [self.view addSubview:carView];
    
    UIView *engineView = [[UIView alloc]initWithFrame:CGRectMake(20.f, 140.f, ScreenWidth - 40.f, 44.f)];
    engineView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    engineView.layer.borderWidth = 1;
    UILabel *engineLabel = [[UILabel alloc]initWithFrame:CGRectMake(4.f, 5.f, 80.f, 30.f)];
    engineLabel.text = @"发动机号:";
    engineLabel.textColor = [UIColor grayColor];
    [engineView addSubview:engineLabel];
    
    _engineIdFeild = [[UITextField alloc]initWithFrame:CGRectMake(85.f, 2.f, 200.f, 40.f)];
    _engineIdFeild.keyboardType = UIKeyboardTypeNumberPad;
    _engineIdFeild.placeholder = @"请输入后6位号码";
    [_engineIdFeild setClearButtonMode:UITextFieldViewModeWhileEditing];
    [engineView addSubview:_engineIdFeild];
    
    [self.view addSubview:engineView];
    
    UIButton *driveFrontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [driveFrontBtn setImage:IMG(@"car_front_icon") forState:UIControlStateNormal];
    [driveFrontBtn setFrame:CGRectMake(30, 200.f, 120.f, 90.f)];
    [self.view addSubview:driveFrontBtn];
    
    UIButton *driveBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [driveBackBtn setImage:IMG(@"car_back_icon") forState:UIControlStateNormal];
    [driveBackBtn setFrame:CGRectMake(180, 200.f, 120.f, 90.f)];
    [self.view addSubview:driveBackBtn];
    
    UILabel *tip1 = [[UILabel alloc]initWithFrame:CGRectMake(20.f, 300.f, ScreenWidth - 40.f, 40)];
    tip1.text = @"1、验证驾驶证是为了验证驾驶能力和资格；\n2、验证通过后仅会显示性别、年龄和驾龄;";
    tip1.font = KSystemFont(13);
    tip1.numberOfLines = 2;
    tip1.textColor = [UIColor lightGrayColor];
    [self.view addSubview:tip1];
    
    UILabel *tip2 = [[UILabel alloc]initWithFrame:CGRectMake(20.f, 330.f, ScreenWidth - 40.f, 30)];
    tip2.text = @"3、不会泄漏其他个人信息。";
    tip2.font = KSystemFont(13);
    tip2.textColor = RGB(164, 0, 0);
    [self.view addSubview:tip2];
    
    UIButton *verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verifyBtn setFrame:CGRectMake(20.f, 365.f, ScreenWidth - 40, 40)];
    [verifyBtn setTitle:@"提交验证" forState:UIControlStateNormal];
    [verifyBtn setBackgroundColor:RGB_MainAppColor];
    [verifyBtn addTarget:self action:@selector(verifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:verifyBtn];
    
    UIButton *passBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [passBtn setFrame:CGRectMake(20.f, 420.f, ScreenWidth - 40, 40)];
    [passBtn setTitle:@"我是乘客,跳过验证" forState:UIControlStateNormal];
    
    [passBtn addTarget:self action:@selector(passClick) forControlEvents:UIControlEventTouchUpInside];
    [passBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    passBtn.layer.borderColor = RGB_MainAppColor.CGColor;
    passBtn.layer.borderWidth = 0.8;
    [self.view addSubview:passBtn];
    
    [self bottomBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)verifyBtnClick{
    
}

- (void)passClick{
    
}
/**
 *  选择车牌号归属地
 */
- (void)pickerSelectCarIdClick{
    [self showSelectPicterView];
}

- (void)bottomBarView{
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 240)];
    //    指定Delegate
    _pickerView.delegate=self;
    _pickerView.dataSource = self;
    //    显示选中框
    _pickerView.showsSelectionIndicator=YES;
    _pickerView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_pickerView];
    
    toolbarView = [[UIToolbar alloc]initWithFrame:CGRectMake(0,ScreenHeight, ScreenWidth, 44)];
    [toolbarView setBarStyle:UIBarStyleDefault];
    [toolbarView setBackgroundImage:[UIImage  imageNamed:@"barBG.png"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [toolbarView setBackgroundColor:[UIColor grayColor]];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(0, 0, 45, 30);
    [sendButton addTarget:self action:@selector(moveToGroup) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitleColor:RGB_BuleColor forState:UIControlStateNormal];
    [sendButton  setTitle:@"确定" forState:UIControlStateNormal];
    UIBarButtonItem  *sendView= [[UIBarButtonItem  alloc] initWithCustomView:sendButton];
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 45, 30);
   
    [cancelButton addTarget:self action:@selector(cancelMove) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:RGB_BuleColor forState:UIControlStateNormal];
    [cancelButton  setTitle:@"取消" forState:UIControlStateNormal];
    UIBarButtonItem  *cancelView= [[UIBarButtonItem  alloc] initWithCustomView:cancelButton];
    
    UIBarButtonItem *spaseItem = [[UIBarButtonItem  alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [toolbarView setItems:[NSArray  arrayWithObjects:cancelView,spaseItem,sendView,nil] animated:YES];
    
    [self.view  addSubview:toolbarView];

}

- (void)showSelectPicterView{
    [UIView animateWithDuration:0.23 animations:^{
        _pickerView.frame = CGRectMake(0, self.view.bounds.size.height - 216, 320, 216);
        toolbarView.frame = CGRectMake(0, self.view.bounds.size.height - 216 - 40, 320, 40);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenSelectPicterView{
    
    [UIView animateWithDuration:0.23 animations:^{
        _pickerView.frame = CGRectMake(0, self.view.bounds.size.height + 40, 320, 216);
        toolbarView.frame = CGRectMake(0, self.view.bounds.size.height , 320, 40);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)cancelMove{
    [self hiddenSelectPicterView];
}

- (void)moveToGroup{
    [_selectPickerBtn setTitle:_selectCarnumber forState:UIControlStateNormal];
    [self hiddenSelectPicterView];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_carframeFeild resignFirstResponder];
    [_carIdFeild resignFirstResponder];
    [_engineIdFeild resignFirstResponder];
}

#pragma mark -UIPickerViewDelegate

//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_carNumberArr count];
}
 
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_carNumberArr objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    MLOG(@"=====%@",[_carNumberArr objectAtIndex:row]);
//    [_selectPickerBtn setTitle:[_carNumberArr objectAtIndex:row] forState:UIControlStateNormal];
    _selectCarnumber = [_carNumberArr objectAtIndex:row];
}

@end
