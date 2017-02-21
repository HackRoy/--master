//
//  WHmaplistTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/1.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHmaplistTableViewController.h"
#import "MacroUtility.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
#import "WHnearAgentTableViewCell.h"
#import "JGProgressHelper.h"
#import "WHgetnearagent.h"
#import "WHnearagentdata.h"
#import <UIImageView+WebCache.h>
#import "MJRefresh.h"

@interface WHmaplistTableViewController ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>
{
    BMKMapView *_mapView;
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_geoSearch;
}
/** 用户当前位置*/
@property(nonatomic,strong) BMKUserLocation *userLocation;
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)WHnearAgentTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * s ;
@property(nonatomic,strong)NSString * nearID;
@property(nonatomic,strong)NSString * StrDist;
@property(nonatomic,strong)NSMutableArray * imgArry;
@property(nonatomic,strong)NSMutableArray * mobileArry;
@property(nonatomic,strong)NSMutableArray * comArry;
@property(nonatomic,strong)NSMutableArray * sexArry;
@property(nonatomic,strong)NSMutableArray * addressArry;
@property(nonatomic,strong)NSMutableArray * distArry;
@property(nonatomic,strong)NSMutableArray * telArry;
@property(nonatomic,strong)NSString * tel;
@property(nonatomic,assign)NSInteger numindex;



@end

@implementation WHmaplistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];

   // [self dateBase];
    self.dataArry = [NSMutableArray array];
    self.imgArry = [NSMutableArray array];
    self.mobileArry = [NSMutableArray array];
    self.sexArry = [NSMutableArray array];
    self.comArry = [NSMutableArray array];
    self.addressArry = [NSMutableArray array];
    self.distArry = [NSMutableArray array];
    self.telArry = [NSMutableArray array];
    self.title = @"位置";
    [self setupRefresh];
    
}
//刷新
-(void)setupRefresh
{
    [self.tableV addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"thable"];
    [self.tableV headerBeginRefreshing];
    [self.tableV addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    
}
//下拉刷新
-(void)headerRereshing
{
    self.numindex = 1 ;
    //self.numindex ++;
    [self dateBase];
}
//上拉加载
-(void)footerRefreshing
{
    
    
    self.numindex ++ ;
    if (self.dataArry.count <= 10) {
        [self.tableV footerEndRefreshing];
    }
    else
    {
        [self dateBase];
    }
}

-(void)dateBase
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * stringOne = [ud valueForKey:@"one"];
    NSString * stringTwo = [ud valueForKey:@"two"];
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getnearagentWithLng:stringOne
                                      lat:stringTwo
                                city_name:@""
                                 province:@""
                                     city:@""
                                   county:@""
                                     type:@"agent"
                                 distance:@"10.00"
                                      map:@""
                                        p:[NSString stringWithFormat:@"%ld",self.numindex]
                                 pagesize:[NSString stringWithFormat:@"%ld",self.numindex * 15]
                                  success:^(NSArray *lists)
     {
                                         [hud hide:YES];
                                         //  self.dataArry = [NSMutableArray arrayWithArray:lists];
                                         //  NSLog(@"%@",self.dataArry);
         
         NSArray *nearagents = [WHgetnearagent  arrayOfModelsFromDictionaries:lists error:nil];
         
         
                                         for (WHgetnearagent * near in nearagents) {
                                             
                                            self.nearID = near.id;
                                             self.StrDist = near.dist;
                                             //小数点处理
                                             float  f = [near.dist floatValue];
                                             int a = (int)f;
                                             // NSLog(@"====%d",a);
                                             if (a >= 1000) {
                                                 int  b = a /1000;
                                                 // NSLog(@"LLL%d",b);
                                                 NSString * s1 = [NSString stringWithFormat:@"%d",b];
                                                 self.s = [s1 stringByAppendingString:@"KM"];
                                             }
                                             else
                                             {
                                                 NSString * s2  = [NSString stringWithFormat:@"%d",a];
                                                 self.s = [s2 stringByAppendingString:@"M"];
                                             }
                                             [self.distArry addObject:self.s];//距离
                                             
                                             
                                             
                                             // NSLog(@"oo%@",self.StrDist);
                                             // NSLog(@"ppp%@",near.data.name);
                                             [self.dataArry addObject:near.data.name];
                                             
                                             [self.imgArry addObject:near.data.avatar];
                                             [self.sexArry addObject:near.data.sex];
                                             if (near.data.com_name == nil) {
                                                 near.data.com_name = @"公司不详";
                                             }
                                             [self.comArry addObject:near.data.com_name];
                                             [self.mobileArry addObject:near.data.mobile];
                                             if (near.data.job_address == nil) {
                                                 near.data.job_address = @"地址不详";
                                             }
                                             [self.addressArry addObject:near.data.job_address];
                                             [self.telArry addObject:near.data.mobile];
                                             
                                            
                                         }
                                      [self.tableV headerEndRefreshing];
                                      [self.tableV footerEndRefreshing];
                                      
                                         [self.tableV reloadData];
                                     } failure:^(NSError *error) {
                                         [hud hide:YES];
                                         [JGProgressHelper showError:@""];
                                         
                                     }];

    
}
-(void)setUI
{
    [self setupMapViewWithParam];
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREENH * 0.70, kScreenWitdh, SCREENH * 0.30 - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHnearAgentTableViewCell class] forCellReuseIdentifier:@"cell"];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH * 0.70)];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHnearAgentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    
    cell.telBut.tag = 100 + indexPath.row;
    [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    cell.nameLaber.text = self.dataArry[indexPath.row];
    
//    if ([self.imgArry[indexPath.row ]isEqualToString:@"0"])
//    {
//        cell.myImage.image = [UIImage imageNamed:@"Jw_user"];
//    }else
//    {
//        [cell.myImage sd_setImageWithURL:[NSURL URLWithString:self.imgArry[indexPath.row]]];
//    }
    
    [cell.myImage sd_setBackgroundImageWithURL:[NSURL URLWithString:self.imgArry[indexPath.row]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Jw_user"]];
    
    if ([self.sexArry[indexPath.row] isEqualToString: @"2"]) {
        cell.sexImg.image = [UIImage imageNamed:@"test_famale"];
    }else
    {
        cell.sexImg.image = [UIImage imageNamed:@"test_male"];
    }
    cell.mapImg.image = [UIImage imageNamed:@"maple"];
    cell.telImg.image = [UIImage imageNamed:@"tel"];
    cell.addressLaber.text = self.addressArry[indexPath.row];
    cell.telLaber.text = self.telArry[indexPath.row];
    cell.companyLaber.text = self.comArry [indexPath.row];
    cell.mapLaber.text = self.distArry[indexPath.row];
    
    return cell;

}
//电话事件
-(void)telAction:(UIButton *)sender
{
    self.tel = self.mobileArry[sender.tag - 100];
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    [view show];
    
    
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.tel];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
