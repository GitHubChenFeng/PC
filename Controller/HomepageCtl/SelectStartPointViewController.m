//
//  SelectStartPointViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-13.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "SelectStartPointViewController.h"
#import "CurrentLocationAnnotation.h"
#import "SynptomCell.h"

@interface SelectStartPointViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *nearPlaceArr;
    NSMutableDictionary*selectConditionDict;
    int selectIndexRow;
    UIImageView *myHeadImage;
}

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *nearbyTabelView;

@end

@implementation SelectStartPointViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"选择地点";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selectIndexRow = 0;
    
    selectConditionDict=[[NSMutableDictionary alloc]init];
    _nearPointArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    [_nearPointArr insertObject:[ManageCenter shareManager].city atIndex:0];

    
    MLOG(@"_nearPointArr=%d",_nearPointArr.count);
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 40.f)];
    [self.searchBar sizeToFit];
    self.searchBar.placeholder = @"输入出发地";
    self.searchBar.delegate = self;
    
    [self.view addSubview:self.searchBar];
    
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0.f, 40.f, ScreenWidth, 200.f)];
    _mapView.delegate = self;
    _mapView.zoomLevel = 15;

    [self.view addSubview:_mapView];
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){[ManageCenter shareManager].klatitude, [ManageCenter shareManager].klongtitude};
    _mapView.centerCoordinate = pt;
    
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    [_locService startUserLocationService];
//    NSLog(@"%@", _locService.userLocation.location);
    
    CurrentLocationAnnotation *annotation = [[CurrentLocationAnnotation alloc] initWithCoordinate:pt andTitle:[ManageCenter shareManager].city andSubtitle:nil andImage:nil];
    
//    BMKAnnotationView *annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotationPin"];
    
    //添加自己位置标注
    [_mapView addAnnotation:annotation];
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    [self initShowTableView];
}

- (void)initShowTableView{
    _nearbyTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0.f, 240.f, ScreenWidth, ScreenHeight  - 300) style:UITableViewStylePlain];
    _nearbyTabelView.delegate = self;
    _nearbyTabelView.dataSource = self;
    [self.view addSubview:_nearbyTabelView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BMKUserLocation
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation{
      
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    NSLog(@"生成标注");
    if ([annotation isKindOfClass:[CurrentLocationAnnotation class]]) {
        
//        BMKAnnotationView *annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotationPin"];
//        annotationView.canShowCallout               = NO;
//        annotationView.clipsToBounds                = YES;
//        annotationView.layer.cornerRadius           = 29;
//        annotationView.userInteractionEnabled       = YES;
//        annotationView.frame=CGRectMake(0, 0, 60, 60);
//   
//        myHeadImage = [[UIImageView alloc]initWithFrame:CGRectZero];
//        myHeadImage.backgroundColor          = [UIColor clearColor];
//        myHeadImage.center                   = annotationView.center;
//        myHeadImage.layer.cornerRadius       = 29;
//        myHeadImage.clipsToBounds            = YES;
//        myHeadImage.userInteractionEnabled   = YES;
//    
//        myHeadImage.layer.cornerRadius       = 16;
//        myHeadImage.frame = CGRectMake(14.5, 14.5, 31, 31);
//     
//        annotationView.image = IMG(@"manager_default_home.png");
//        return annotationView;
    }
    
    return nil;
        
}
    
#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    for(id cc in  [[[self.searchBar subviews] objectAtIndex:0] subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nearPointArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 44.f)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *pointL = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 10.f, 15.f, 25.f)];
    pointL.backgroundColor = RGB_MainAppColor;
    [headView addSubview:pointL];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(25.f, 10., 200.f, 30.f)];
    titleL.text = @"附近的地点";
    titleL.textColor = RGB_MainAppColor;
    titleL.font = KSystemFont(17);
    [headView addSubview:titleL];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SynptomCell*cell=(SynptomCell*)[tableView dequeueReusableCellWithIdentifier:@"SynptomCell"];
    if(cell==nil)
    {
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"SynptomCell" owner:tableView options:nil];
        cell=[nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *selectValue = [_nearPointArr objectAtIndex:indexPath.row];
    cell.textLabel.text = selectValue;

    if (indexPath.row == selectIndexRow) {
        [cell.cellImgView setImage:[UIImage imageNamed:@"EnterPay01.png"]];
    }else{
        [cell.cellImgView setImage:[UIImage imageNamed:@"EnterPay02.png"]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SynptomCell*cell=(SynptomCell*)[tableView cellForRowAtIndexPath:indexPath];

    [cell.cellImgView setImage:[UIImage imageNamed:@"EnterPay01.png"]];
    
    selectIndexRow = indexPath.row;
    
    SETBeginDepart([_nearPointArr objectAtIndex:indexPath.row]);
    MLOG(@"%@",GETBeginDepart);
    [_nearbyTabelView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
