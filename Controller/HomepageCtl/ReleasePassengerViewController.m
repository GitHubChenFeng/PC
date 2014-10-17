//
//  ReleasePassengerViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-10.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "ReleasePassengerViewController.h"

#define kLeftMargin 15.f

@interface ReleasePassengerViewController ()
{
    UIScrollView *mainSrollView;
    UILabel *_describeTips;
    RMDateSelectionViewController *dateSelectionVC;
    
    UIButton *leftBeginTimeButton;
    UIButton *rightBeginTimeButton;
}
@end

@implementation ReleasePassengerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initReleaseRouteView];
    
    [self initLeftBarButton];
    self.title = @"发布路线";
}

- (void)initReleaseRouteView{
    mainSrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    mainSrollView.showsHorizontalScrollIndicator = NO;
	mainSrollView.showsVerticalScrollIndicator = NO;
    mainSrollView.contentSize = Size(ScreenWidth, ScreenHeight + 20);
    [self.view addSubview:mainSrollView];
    
    UILabel *chooseTips = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, 10.f, 200.f, 30.f)];
    chooseTips.text = @"请选择拼车类型";
    chooseTips.font = KSystemFont(17);
    chooseTips.textColor = RGB_TextLightDark2;
    [mainSrollView addSubview:chooseTips];
    
    UISegmentedControl  *segmentView = [[UISegmentedControl  alloc] initWithItems:[NSArray  arrayWithObjects:@"单次", @"上班", @"下班", nil]];
    segmentView.frame = CGRectMake(kLeftMargin, 65.f, ScreenWidth - 2*kLeftMargin, 35.f);
    segmentView.center = CGPointMake(160, 65);
    segmentView.selectedSegmentIndex = 0;//设置默认选择项索引
    [segmentView addTarget:self action:@selector(changeBeginTime:) forControlEvents:UIControlEventValueChanged];
    
    segmentView.tintColor = RGB_MainAppColor;
    segmentView.segmentedControlStyle = UISegmentedControlStyleBar;
    [mainSrollView  addSubview:segmentView];
    
    
    UILabel *beginTips = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, 90.f, 200.f, 30.f)];
    beginTips.text = @"出发时间";
    beginTips.font = KSystemFont(17);
    beginTips.textColor = RGB_TextLightDark2;
    [mainSrollView addSubview:beginTips];
    
    NSArray *currentTime = [[self handleDateFormatter:[NSDate date]] componentsSeparatedByString:@"="];
    
    leftBeginTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBeginTimeButton setTitle:[currentTime objectAtIndex:0] forState:UIControlStateNormal];
    [leftBeginTimeButton setFrame:CGRectMake(kLeftMargin, 125.f, (ScreenWidth - 2*kLeftMargin )/2, 44.f)];

    [leftBeginTimeButton setTitleColor:RGB_TextLightDark forState:UIControlStateNormal];
    leftBeginTimeButton.layer.borderWidth = 1;
    leftBeginTimeButton.layer.borderColor = RGB_TextLineLightGray.CGColor;
    [leftBeginTimeButton addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
    [mainSrollView addSubview:leftBeginTimeButton];
    
    rightBeginTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBeginTimeButton setTitle:[currentTime objectAtIndex:1] forState:UIControlStateNormal];
    [rightBeginTimeButton setFrame:CGRectMake( 290/2 + kLeftMargin -1, 125.f, (ScreenWidth - 2*kLeftMargin)/2 + 1, 44.f)];

    rightBeginTimeButton.layer.borderWidth = 1;
    rightBeginTimeButton.layer.borderColor = RGB_TextLineLightGray.CGColor;
    [rightBeginTimeButton setTitleColor:RGB_TextLightDark forState:UIControlStateNormal];
    [rightBeginTimeButton addTarget:self action:@selector(selectTime) forControlEvents:UIControlEventTouchUpInside];
    [mainSrollView addSubview:rightBeginTimeButton];
    
    
    UILabel *beginPlace = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, ViewY(leftBeginTimeButton) + ViewHeight(leftBeginTimeButton) + 5, 200.f, 30.f)];
    beginPlace.text = @"出发地";
    beginPlace.textColor = RGB_TextLightDark2;
    beginPlace.font = KSystemFont(17);
    [mainSrollView addSubview:beginPlace];
    
    UIButton *beginPlaceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [beginPlaceButton setTitle:@"我的位置（腾讯大厦）" forState:UIControlStateNormal];
    [beginPlaceButton setFrame:CGRectMake(kLeftMargin, ViewY(beginPlace) + ViewHeight(beginPlace) + 5, ScreenWidth - 2*kLeftMargin, 44.f)];
    //    beginPlaceButton.layer.cornerRadius = 1;
    //    beginPlaceButton.clipsToBounds = YES;
    beginPlaceButton.layer.borderWidth = 1;
    beginPlaceButton.layer.borderColor = RGB_TextLineLightGray.CGColor;
    beginPlaceButton.titleEdgeInsets = UIEdgeInsetsMake(0.f, 10.f, 0., 0.);
    [beginPlaceButton setTitleColor:RGB_TextLightDark2 forState:UIControlStateNormal];
    beginPlaceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [beginPlaceButton addTarget:self action:@selector(beginPlaceClick) forControlEvents:UIControlEventTouchUpInside];
    [mainSrollView addSubview:beginPlaceButton];
    
    UIImageView *iconRight = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 2*kLeftMargin - 35, 5.f, 35.f, 35.f)];
    [iconRight setImage:IMG(@"btn_right_arrow")];
    [beginPlaceButton addSubview:iconRight];
    
    UILabel *endPointTips = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, ViewY(beginPlaceButton) + ViewHeight(beginPlaceButton) + 5, 200.f, 30.f)];
    endPointTips.text = @"目的地";
    endPointTips.textColor = RGB_TextLightDark2;
    endPointTips.font = KSystemFont(17);
    [mainSrollView addSubview:endPointTips];
    
    UIButton *endPointButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [endPointButton setTitle:@"选择你的目的地" forState:UIControlStateNormal];
    [endPointButton setFrame:CGRectMake(kLeftMargin, ViewY(endPointTips) + ViewHeight(endPointTips) + 5, ScreenWidth - 2*kLeftMargin, 44.f)];
    //    endPointButton.layer.cornerRadius = 3;
    //    endPointButton.clipsToBounds = YES;
    [endPointButton setTitleColor:RGB_TextLightGray forState:UIControlStateNormal];
    endPointButton.layer.borderWidth = 1;
    endPointButton.layer.borderColor = RGB_TextLineLightGray.CGColor;
    endPointButton.titleEdgeInsets = UIEdgeInsetsMake(0.f, 10.f, 0., 0.);
    endPointButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [endPointButton addTarget:self action:@selector(endPointClick) forControlEvents:UIControlEventTouchUpInside];
    [mainSrollView addSubview:endPointButton];
    
    UIImageView *endIconRight = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 2*kLeftMargin - 35, 5.f, 35.f, 35.f)];
    [endIconRight setImage:IMG(@"btn_right_arrow")];
    [endPointButton addSubview:endIconRight];
    
    
    UILabel *messageTips = [[UILabel alloc]initWithFrame:CGRectMake(kLeftMargin, ViewY(endPointButton) + ViewHeight(endPointButton) + 5, 200.f, 30.f)];
    messageTips.text = @"留言（可选）";
    messageTips.textColor = RGB_TextLightDark2;
    messageTips.font = KSystemFont(17);
    [mainSrollView addSubview:messageTips];
    
    _txtView = [[UITextView alloc]initWithFrame:CGRectMake(kLeftMargin, ViewY(messageTips) + ViewHeight(messageTips) + 5, ScreenWidth - 2*kLeftMargin, 90)];
    //    txtView.layer.cornerRadius = 3;
    //    txtView.clipsToBounds = YES;
    _txtView.layer.borderWidth = 1;
    _txtView.layer.borderColor = RGB_TextLineLightGray.CGColor;
    _txtView.returnKeyType =UIReturnKeyDone;
    _txtView.delegate = self;
    [mainSrollView addSubview:_txtView];
    
    _describeTips = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, 260, 50)];
    _describeTips.textColor = [UIColor lightGrayColor];
    _describeTips.text = @"请写下你对乘客的期望或者你的拼车宣言！（仅限30字）";
    _describeTips.numberOfLines = 2;
    _describeTips.font = KSystemFont(15);
    _describeTips.backgroundColor = [UIColor clearColor];
    [_txtView addSubview:_describeTips];
    
    
    UIButton *previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [previewButton setTitle:@"预览路线" forState:UIControlStateNormal];
    [previewButton setFrame:CGRectMake(kLeftMargin * 3, ViewY(_txtView) + ViewHeight(_txtView) + 15, ScreenWidth - 6*kLeftMargin, 44.f)];
    [previewButton setBackgroundColor:RGB_MainAppColor];
    [previewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [previewButton addTarget:self action:@selector(previewClick) forControlEvents:UIControlEventTouchUpInside];
    [mainSrollView addSubview:previewButton];
    
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

// 选择拼车类型
-(void)changeBeginTime:(UISegmentedControl *)Seg{
    NSInteger segIndex = Seg.selectedSegmentIndex;
    NSString *currLeftTimeStr;
    NSString *currRightTimeStr;
    
    if (segIndex == 0) {
         NSArray *currentTime = [[self handleDateFormatter:[NSDate date]] componentsSeparatedByString:@"="];
    
        currLeftTimeStr = [currentTime objectAtIndex:0];
        currRightTimeStr = [currentTime objectAtIndex:1];
        
    }else if (segIndex == 1) {
    
    }else if (segIndex == 2) {
    
    }
    
    [leftBeginTimeButton setTitle:currLeftTimeStr forState:UIControlStateNormal];
    [rightBeginTimeButton setTitle:currRightTimeStr forState:UIControlStateNormal];
    
}

// 选择时间
- (void)selectTime{
    
    dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    [dateSelectionVC showFromViewController:self];
    
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    dateSelectionVC.datePicker.minuteInterval = 5;
    dateSelectionVC.datePicker.date = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    
}

// 出发地
- (void)beginPlaceClick{
    
}

// 目的地
- (void)endPointClick{
    
}

// 中转点
- (void)midPointClick{
    
}

// 预览路线
- (void)previewClick{
    [_txtView resignFirstResponder];//释放键盘
    
    [self resumeView];
    
}

- (NSString *)handleDateFormatter:(NSDate *)adate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  
    [dateFormatter setDateFormat:@"yyyy-MM-dd=HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate:adate];
    return currentDateStr;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleKeyboard{
    
    NSTimeInterval animationDuration=0.23f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    mainSrollView.contentSize = CGSizeMake(ScreenWidth, 580);
    mainSrollView.contentOffset = CGPointMake(0.f, 150);
    
    [UIView commitAnimations];
}

//恢复原始视图位置
- (void)resumeView
{
    NSTimeInterval animationDuration=0.23f;
    [UIView beginAnimations:@"ResizeForKeyboards" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    mainSrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight + 20);
    mainSrollView.contentOffset = CGPointMake(0.f, 0.f);
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_txtView resignFirstResponder];
    [dateSelectionVC dismiss];
}

#pragma mark - UITextViewDelegate
- (void)handleTextViewChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        
        if ([_describeTips superview]==nil) {
            [_txtView addSubview:_describeTips];
        }
        
        _describeTips.text =  @"请写下你对乘客的期望或者你的拼车宣言！（仅限30字）";
    }else{
        if ([_describeTips superview]!=nil) {
            [_describeTips removeFromSuperview];
        }
        _describeTips.text = @"";
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if(_txtView == textView){
        [self handleTextViewChange:textView];
        [self handleKeyboard];
    }
    
}
- (void)textViewDidChange:(UITextView *)textView{
    if(_txtView == textView){
        [self handleTextViewChange:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        //检测到“完成”
        [textView resignFirstResponder];//释放键盘
        
        [self resumeView];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - RMDAteSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    NSLog(@"Successfully selected date: %@", aDate);
    
    NSLog(@"1111date: %@", [self handleDateFormatter:aDate]);
    
    NSArray *currentTime = [[self handleDateFormatter:aDate] componentsSeparatedByString:@"="];
    
    [leftBeginTimeButton setTitle:[currentTime objectAtIndex:0] forState:UIControlStateNormal];
    [rightBeginTimeButton setTitle:[currentTime objectAtIndex:1] forState:UIControlStateNormal];
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"Date selection was canceled");
}

@end
