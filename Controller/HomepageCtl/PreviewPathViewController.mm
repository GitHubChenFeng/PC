//
//  PreviewPathViewController.m
//  PC
//
//  Created by MacBook Pro on 14-9-21.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "PreviewPathViewController.h"
#import "BMKShape.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface RouteAnnotation : BMKPointAnnotation
{
	int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
	int _degree;
}

@property (nonatomic,assign) int type;
@property (nonatomic,assign) int degree;
@end

@implementation RouteAnnotation
@end

@interface UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end

@implementation UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
	CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(bitmap, degrees * M_PI / 180);
	CGContextRotateCTM(bitmap, M_PI);
	CGContextScaleCTM(bitmap, -1.0, 1.0);
	CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end


@interface PreviewPathViewController ()

@property (nonatomic, strong) NSString *end_lat;
@property (nonatomic, strong) NSString *end_lng;
@end


@implementation PreviewPathViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"预览路线";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOSVersion >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0.f, 0.f, ScreenWidth, 280.f)];
    _mapView.delegate = self;
    
    CLLocationCoordinate2D cll;
    cll.latitude = [ManageCenter shareManager].klatitude;
    cll.longitude = [ManageCenter shareManager].klongtitude;
    
    BMKCoordinateRegion region = BMKCoordinateRegionMake(cll, BMKCoordinateSpanMake(0.05, 0.05));
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
    
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
    [self.view addSubview:_mapView];
    
    _routesearch = [[BMKRouteSearch alloc]init];
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    
    [self previewBottomView];
    
    [self onDriveSearch];
    
    [self getGeocodeLngAndLat];
}

- (void)previewBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0.f,self.view.frame.size.height - 280.f, ScreenWidth, 220.f)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(10.f, 5.f, 280.f, 25.f)];
    time.text = [NSString stringWithFormat:@"时间：%@",self.pModel.start_time];
    time.textColor = RGB_TextLightDark;
    [bottomView addSubview:time];
    
    UILabel *startAddress = [[UILabel alloc]initWithFrame:CGRectMake(10.f, CGRectGetMaxY(time.frame), 280.f, 25.f)];
    startAddress.text = [NSString stringWithFormat:@"出发地：%@",self.pModel.start_addr];
    startAddress.textColor = RGB_TextLightDark;
    [bottomView addSubview:startAddress];
    
    UILabel *midPlace = [[UILabel alloc]initWithFrame:CGRectMake(10.f, CGRectGetMaxY(startAddress.frame), 280.f, 25.f)];
   
    NSArray *arr = self.pModel.posMidArr;
    NSString *miPStr;
    if (arr.count > 0) {
        miPStr = [arr componentsJoinedByString:@","];
    }else{
        miPStr = @"";
    }
    
    midPlace.text = [NSString stringWithFormat:@"途径：%@",miPStr];
    midPlace.textColor = RGB_TextLightDark;
    [bottomView addSubview:midPlace];
    
    UILabel *endPoint = [[UILabel alloc]initWithFrame:CGRectMake(10.f, CGRectGetMaxY(midPlace.frame), 280.f, 25.f)];
    endPoint.text = [NSString stringWithFormat:@"目的地：%@",self.pModel.end_addr];
  
    endPoint.textColor = RGB_TextLightDark;
    [bottomView addSubview:endPoint];
    
    UILabel *tips = [[UILabel alloc]initWithFrame:CGRectMake(10.f, CGRectGetMaxY(endPoint.frame) + 3, 200.f, 25.f)];
    tips.text = @"如路线不正确，请增加中转点";
    tips.font = KSystemFont(13);
    tips.textColor = RGBA(230, 0, 18, 1);
    [bottomView addSubview:tips];
    
    UIButton *addMindPlaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addMindPlaceBtn setFrame:CGRectMake(10.f, CGRectGetMaxY(tips.frame) + 10, 140, 40)];
    [addMindPlaceBtn setTitle:@"增加中转点" forState:UIControlStateNormal];
    [bottomView addSubview:addMindPlaceBtn];
    [addMindPlaceBtn setTitleColor:RGB_TextLightDark forState:UIControlStateNormal];
    [addMindPlaceBtn addTarget:self action:@selector(addMidPointClick) forControlEvents:UIControlEventTouchUpInside];
    addMindPlaceBtn.layer.borderColor = RGB_MainAppColor.CGColor;
    addMindPlaceBtn.layer.borderWidth = 1;
    
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [comfirmBtn setFrame:CGRectMake(165.f, CGRectGetMaxY(tips.frame) + 10, 140, 40)];
    [comfirmBtn setTitle:@"确定发布" forState:UIControlStateNormal];
    [comfirmBtn setBackgroundColor:RGB_MainAppColor];
    [comfirmBtn addTarget:self action:@selector(comfirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomView addSubview:comfirmBtn];
    
    [self.view addSubview:bottomView];
}

- (void)viewWillAppear:(BOOL)animated {
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _routesearch.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    _mapView.delegate = nil; // 不用时，置nil
    _routesearch.delegate = nil;
    _geocodesearch.delegate = nil;
}

// 增加中转点
- (void)addMidPointClick{
    [self.navigationController popViewControllerAnimated:YES];
}


// 确认发布
- (void)comfirmBtnClick{
    [SVProgressHUD showWithStatus:@"路线发布中··" maskType:1];
    [self requestInfo];
    
}

- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		return s;
	}
	return nil ;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BMKAnnotationView

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
	BMKAnnotationView* view = nil;
	switch (routeAnnotation.type) {
		case 0:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 1:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 2:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 3:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 4:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
			
		}
			break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
        }
            break;
		default:
			break;
	}
	
	return view;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[RouteAnnotation class]]) {
		return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
	}
	return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = RGBA(230, 0, 18, 1);
        polylineView.lineWidth = 3.5;
        return polylineView;
    }
	return nil;
}
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
    
	if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
		int size = [plan.steps count];
		int planPointCounts = 0;
		for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = self.pModel.start_addr;
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
    
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = self.pModel.end_addr;
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
           
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
        
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
      
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
		[_mapView addOverlay:polyLine]; // 添加路线overlay
		delete []temppoints;
        
		
	}
}
// 路径规划
- (void)onDriveSearch
{
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
	start.name = self.pModel.start_addr;
    start.cityName =  [ManageCenter shareManager].locatCity;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.name = self.pModel.end_addr;
    end.cityName =  [ManageCenter shareManager].locatCity;
    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:10];
    
    // 设置中转点
    for (int i = 0; i<self.pModel.posMidArr.count; i++) {
        BMKPlanNode* wayPointItem1 = [[BMKPlanNode alloc]init];
        wayPointItem1.cityName = [ManageCenter shareManager].locatCity;
        wayPointItem1.name = [self.pModel.posMidArr objectAtIndex:i];
        [array addObject:wayPointItem1];
    }

    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    // 有选择中转点
    BMKPlanNode*pointI = [array objectAtIndex:0];
    if (pointI.name.length  > 2) {
      drivingRouteSearchOption.wayPointsArray = array;  
    }
    
    BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];

    if(flag)
    {
        NSLog(@"search success.");
    }
    else
    {
        NSLog(@"search failed!");
    }
    
}
// 获取目的地的经纬度
- (void)getGeocodeLngAndLat
{
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= [ManageCenter shareManager].locatCity;
    geocodeSearchOption.address = self.pModel.end_addr;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];

    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    
}


#pragma mark - BMKGeoCodeSearch正向地理编码
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{

	if (error == 0) {
        self.end_lat = [NSString stringWithFormat:@"%f",result.location.latitude];
        self.end_lng = [NSString stringWithFormat:@"%f",result.location.longitude];
    }
}

#pragma mark - ASIHTTPRequest
- (void)requestInfo
{
    if (!_request.isExecuting) {
        
        NSString *url = [CommonMethod requestServiceUrl:sendRouteHttpUrl];
        
        _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
        
        [_request setPostValue:self.pModel.type forKey:@"type"];
        [_request setPostValue:self.pModel.start_time forKey:@"start_time"];
        [_request setPostValue:self.pModel.start_addr forKey:@"start_addr"];
        [_request setPostValue:self.pModel.start_lng forKey:@"start_lng"];
        [_request setPostValue:self.pModel.start_lat forKey:@"start_lat"];
        [_request setPostValue:self.pModel.end_addr forKey:@"end_addr"];
        [_request setPostValue:self.end_lng forKey:@"end_lng"];
        [_request setPostValue:self.end_lat forKey:@"end_lat"];
        [_request setPostValue:self.pModel.remark forKey:@"remark"];
        //        [_request setPostValue: forKey:@"pos"];
        [_request setPostValue:self.pModel.route_type forKey:@"route_type"];
        [_request setPostValue:self.pModel.user_id forKey:@"user_id"];
        
        _request.delegate = self;
        _request.timeOutSeconds = 30;
        [_request startAsynchronous];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSDictionary *dict1 = [request responseString];
    [SVProgressHUD dismiss];
    if ([[dict1 objectForKey:@"code"] isEqualToString:requestCodeSuccee]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
    }
    MLOG(@"%@",[dict1 objectForKey:@"msg"]);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
     [SVProgressHUD dismiss];
}

@end
