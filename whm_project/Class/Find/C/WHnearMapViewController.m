//
//  WHnearMapViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHnearMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "WHmaphelp.h"
#import <UIImageView+WebCache.h>
#import "TextViewController.h"

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height


//

@interface WHnearMapViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>{
    BMKMapView *_mapView;
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_geoSearch;
}
/** 用户当前位置*/
@property(nonatomic,strong) BMKUserLocation *userLocation;
@property(nonatomic,strong)UIView * myView;
@property(nonatomic,strong)UIImageView * myImg;
@property(nonatomic,strong)UIImageView* sexImg;
@property(nonatomic,strong)UILabel * ageLaber;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UILabel * myLaber;
@property(nonatomic,strong)UIButton * mesBut;
@property(nonatomic,strong)UIButton * telBut;
@property(nonatomic,strong)UIButton * rodeBut;
@end

@implementation WHnearMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(void)setUI
{
    [self setupMapViewWithParam];
    
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(0, SCREENH * 0.75, SCREENW, SCREENH * 0.25);
    [self.view addSubview:_myView];
    //
    self.myImg = [[UIImageView alloc]init];
    self.myImg.frame = CGRectMake(10, 10, SCREENW * 0.15,SCREENW * 0.15);
    self.myImg.layer.masksToBounds = YES;
    self.myImg.layer.cornerRadius = SCREENW * 0.075;
    
    [self.myView addSubview:_myImg];
    //
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.myImg.frame)+3, CGRectGetMinY(self.myImg.frame), SCREENW * 0.15, 30);
    self.nameLaber.textColor = [UIColor grayColor];
    self.nameLaber.font = [UIFont systemFontOfSize:15.0];
    [self.myView addSubview:_nameLaber];
    //
    self.sexImg = [[UIImageView alloc]init];
    self.sexImg.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+2, CGRectGetMinY(self.nameLaber.frame)+6, 20, 20);
    [self.myView addSubview:_sexImg];
    
    //self.sexImg.image = [UIImage imageNamed:@"test_male"];
       //
    self.ageLaber = [[UILabel alloc]init];
    self.ageLaber.frame = CGRectMake(CGRectGetMaxX(self.sexImg.frame)+3, CGRectGetMinY(self.sexImg.frame), SCREENW * 0.15, 20);
    self.ageLaber.textColor = [UIColor grayColor];
    self.ageLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_ageLaber];
    //
    self.myLaber = [[UILabel alloc]init];
    self.myLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMaxY(self.nameLaber.frame)+5, SCREENW * 0.5, 20);
    self.myLaber.textColor = [UIColor grayColor];
    self.myLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_myLaber];
    //self.myLaber.text = @"新华人寿 经理 从业5年 全国";
    //
    self.mesBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mesBut.frame = CGRectMake(SCREENW * 0.6, 10, SCREENW * 0.1, SCREENW * 0.1);
    [self.mesBut setBackgroundImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
     [self.mesBut addTarget:self action:@selector(mess) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [self.myView addSubview:_mesBut];
    //
    self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.telBut.frame = CGRectMake(CGRectGetMaxX(self.mesBut.frame)+5, CGRectGetMinY(self.mesBut.frame), SCREENW * 0.1, CGRectGetHeight(self.mesBut.frame));
    [self.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    [self.myView addSubview:_telBut];
    [self.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.rodeBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.rodeBut.frame = CGRectMake(CGRectGetMaxX(self.telBut.frame)+5, CGRectGetMinY(self.telBut.frame), CGRectGetWidth(self.telBut.frame), CGRectGetHeight(self.telBut.frame));
    [self.rodeBut setBackgroundImage:[UIImage imageNamed:@"rideImg"] forState:(UIControlStateNormal)];
    
    [self.rodeBut addTarget:self action:@selector(lujing) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myView addSubview:_rodeBut];
    
    
    if ([_dailirenJin isEqualToString:@"dailiren"])
    {
         [self.myImg sd_setImageWithURL:[NSURL URLWithString:_myDataMod.data.avatar] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
        
        self.nameLaber.text = _myDataMod.data.name;
        if ([_myDataMod.data.sex isEqualToString:@"2"]) {
            self.sexImg.image = [UIImage imageNamed:@"test_famale"];
        }
        else
        {
            self.sexImg.image = [UIImage imageNamed:@"test_male"];
        }
        self.ageLaber.text = [_myDataMod.data.age stringByAppendingString:@"岁"];
        self.myLaber.text = _myDataMod.data.profession;
        
        
    }else
    {
       [self.myImg sd_setImageWithURL:[NSURL URLWithString:self.p_myImg] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
        self.nameLaber.text = self.p_myName;
        if ([self.p_mySex isEqualToString:@"2"]) {
            self.sexImg.image = [UIImage imageNamed:@"test_famale"];
        }
        else
        {
            self.sexImg.image = [UIImage imageNamed:@"test_male"];
        }
        self.ageLaber.text = [self.p_myAge stringByAppendingString:@"岁"];
        self.myLaber.text = self.p_myPro;


    }
    
    
    
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
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    
    BMKAddressComponent *addressComponent = result.addressDetail;
   // self.city = addressComponent.city;
    NSString *title = [NSString stringWithFormat:@"%@%@%@%@", addressComponent.city, addressComponent.district, addressComponent.streetName, addressComponent.streetNumber];
    NSLog(@"%s -- %@", __func__, title);
}

//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
//    [_mapView updateLocationData:userLocation];// 动态更新我的位置数据
//    self.userLocation = userLocation;
//    [_mapView setCenterCoordinate:userLocation.location.coordinate];// 当前地图的中心点
//}
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
//电话事件
-(void)telAction:(UIButton *)sender
{
  
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
       [view show];
    
    
}

-(void)mess
{
   
    
    if ([_dailirenJin isEqualToString:@"dailiren"])
    {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"sms:%@",self.myDataMod.data.mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else
    {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"sms:%@",self.p_myMobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
    
}


//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 )
    {
      
        if ([_dailirenJin isEqualToString:@"dailiren"])
        {
            NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.myDataMod.data.mobile];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        }else
        {
            NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.p_myMobile];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
        
        
        
    }
}
#pragma mark -新修改

-(void)lujing
{
    
 TextViewController * myText = [TextViewController new];
    
    [self.navigationController pushViewController:myText animated:YES];
    
//  0  113.6947937,
//    NSArray * jinweiArr = _myDataMod.location.coordinates;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
