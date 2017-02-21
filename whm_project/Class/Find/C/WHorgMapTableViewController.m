//
//  WHorgMapTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/1.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHorgMapTableViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <UIImageView+WebCache.h>
#import "MacroUtility.h"


#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

@interface WHorgMapTableViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>{
    BMKMapView *_mapView;
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_geoSearch;
}
/** 用户当前位置*/
@property(nonatomic,strong) BMKUserLocation *userLocation;
@property(nonatomic,strong)UIView * myView;
@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)UILabel * addressLaber ;
@property(nonatomic,strong)UIImageView * mapImg;
@property(nonatomic,strong)UILabel * mapLaber;
@property(nonatomic,strong)UIButton * telBut;
@property(nonatomic,strong)UIButton * rodeBut;



@end

@implementation WHorgMapTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}

-(void)setUI
{
    [self setupMapViewWithParam];
    
    self.title = @"位置";
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(0, SCREENH * 0.75, SCREENW, SCREENH * 0.25);
    // self.myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_myView];
    self.titLaber = [[UILabel alloc]init];
    self.titLaber.frame =  CGRectMake(10, 10, kScreenWitdh * 0.65, 30);
    self.titLaber.font = [UIFont systemFontOfSize:15.0];
    [self.myView addSubview:_titLaber];
    self.titLaber.text = self.p_Name;
    //
    self.addressLaber = [[UILabel alloc]init];
    self.addressLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+3, kScreenWitdh * 0.7, 20);
    self.addressLaber.textColor = [UIColor grayColor];
    self.addressLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_addressLaber];
    self.addressLaber.text = self.p_Address;
    
    //
    self.mapImg = [[UIImageView alloc]init];
    self.mapImg.frame = CGRectMake(CGRectGetMinX(self.addressLaber.frame), CGRectGetMaxY(self.addressLaber.frame)+2, 20, 20);
    self.mapImg.image = [UIImage imageNamed:@"maple"];
    [self.myView addSubview:_mapImg];
    //
    self.mapLaber = [[UILabel alloc]init];
    self.mapLaber.frame = CGRectMake(CGRectGetMaxX(self.mapImg.frame)+5, CGRectGetMinY(self.mapImg.frame), kScreenWitdh * 0.20, CGRectGetHeight(self.mapImg.frame));
    self.mapLaber.textColor = [UIColor greenColor];
    self.mapLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_mapLaber];
    self.mapLaber.text = self.p_mapLaber;
    //
    self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.telBut.frame = CGRectMake(kScreenWitdh *0.7, CGRectGetMinY(self.titLaber.frame), SCREENW * 0.1, SCREENW * 0.1);
    [self.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    [self.myView addSubview:_telBut];
    [self.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //
    self.rodeBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.rodeBut.frame = CGRectMake(CGRectGetMaxX(self.telBut.frame)+5, CGRectGetMinY(self.telBut.frame), CGRectGetWidth(self.telBut.frame), CGRectGetHeight(self.telBut.frame));
    [self.rodeBut setBackgroundImage:[UIImage imageNamed:@"rideImg"] forState:(UIControlStateNormal)];
    [self.myView addSubview:_rodeBut];
    [self.rodeBut addTarget:self action:@selector(rodeButAction:) forControlEvents:(UIControlEventTouchUpInside)];

    
}
#pragma mark - 设置百度地图
-(void)setupMapViewWithParam {
    self.userLocation = [[BMKUserLocation alloc] init];
    _locService = [[BMKLocationService alloc] init];
    _locService.distanceFilter = 200;//设定定位的最小更新距离，这里设置 200m 定位一次，频繁定位会增加耗电量
    _locService.desiredAccuracy = kCLLocationAccuracyHundredMeters;//设定定位精度
    //开启定位服务
    [_locService startUserLocationService];
    //初始化BMKMapView
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH * 0.75)];
    _mapView.buildingsEnabled = YES;//设定地图是否现显示3D楼块效果
    _mapView.overlookEnabled = YES; //设定地图View能否支持俯仰角
    _mapView.showMapScaleBar = YES; // 设定是否显式比例尺
    _mapView.zoomLevel = 12;//设置放大级别
    [self.view addSubview:_mapView];
    
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    BMKLocationViewDisplayParam *userlocationStyle = [[BMKLocationViewDisplayParam alloc] init];
    userlocationStyle.isRotateAngleValid = YES;
    userlocationStyle.isAccuracyCircleShow = NO;
}

#pragma mark - BMKLocationServiceDelegate 用户位置更新后，会调用此函数
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];// 动态更新我的位置数据
    self.userLocation = userLocation;
    [_mapView setCenterCoordinate:userLocation.location.coordinate];// 当前地图的中心点
    /// geo检索信息类,获取当前城市数据
    BMKReverseGeoCodeOption *reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoCodeOption.reverseGeoPoint = userLocation.location.coordinate;
    [_geoSearch reverseGeoCode:reverseGeoCodeOption];
}

#pragma mark 根据坐标返回反地理编码搜索结果
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    BMKAddressComponent *addressComponent = result.addressDetail;
    // self.city = addressComponent.city;
    NSString *title = [NSString stringWithFormat:@"%@%@%@%@", addressComponent.city, addressComponent.district, addressComponent.streetName, addressComponent.streetNumber];
    NSLog(@"%s -- %@", __func__, title);
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geoSearch.delegate = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geoSearch.delegate = self;
}

-(void)telAction:(UIButton *)sender
{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    [view show];
    
    
}
-(void)rodeButAction:(UIButton * )sender
{
    
  
}


//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.p_Mobile];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
