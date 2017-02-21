//
//  WHorgListTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/1.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHorgListTableViewController.h"
#import "MacroUtility.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
#import "WHorginTableViewCell.h"
#import "JGProgressHelper.h"
#import "WHgetnearagent.h"
#import "WHnearagentdata.h"
#import <UIImageView+WebCache.h>
#import "WHorganization.h"
#import "MJRefresh.h"
@interface WHorgListTableViewController ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>
{
    BMKMapView *_mapView;
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_geoSearch;
}
@property(nonatomic,strong) BMKUserLocation *userLocation;
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)WHorginTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * tel ;
@property(nonatomic,assign)NSInteger numindex;


@end

@implementation WHorgListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    //[self dataBase];
    [self setupRefresh];
    
}
-(void)setUI
{
    self.title = @"分支机构";
    [self setupMapViewWithParam];
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREENH * 0.70, kScreenWitdh, SCREENH * 0.30 - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHorginTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}
//刷新
-(void)setupRefresh
{
    [self.tableV addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"thable"];
    [self.tableV headerBeginRefreshing];
    [self.tableV addFooterWithTarget:self action:@selector(footerRefreshing )];
    
    
}
//下拉刷新
-(void)headerRereshing
{
    self.numindex = 1 ;
    //self.numindex ++;
    [self dataBase];
}
//上拉加载
-(void)footerRefreshing
{
     self.numindex ++ ;
    if (self.dataArry.count <= 15) {
        [self.tableV footerEndRefreshing];
    }
    else
    {
        [self dataBase];
    }
}



-(void)dataBase
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * stringOne = [ud valueForKey:@"one"];
    NSString * stringTwo = [ud valueForKey:@"two"];
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getorganizationWithLng:stringOne
                                         lat:stringTwo
                                    distance:@""
                                         map:@""
                                           p:[NSString stringWithFormat:@"%ld",self.numindex]
                                    pagesize:[NSString stringWithFormat:@"%ld",self.numindex * 15]

                                     success:^(NSArray *lists) {
                                         [hud hide:YES];
                                         self.dataArry = [NSMutableArray arrayWithArray:lists];
                                         [self.tableV headerEndRefreshing];
                                         [self.tableV footerEndRefreshing];
                                         [self.tableV reloadData];
                                     } failure:^(NSError *error) {
                                         [hud hide:YES];
                                         [JGProgressHelper showError:@""];
                                         
                                     }];

}

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
    return  self.dataArry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHorginTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    cell.mapImg.image = [UIImage imageNamed:@"maple"];
    cell.telBut.tag = 100 + indexPath.row;
    [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
    WHorganization * model = self.dataArry[indexPath.row];
    cell.titLaber.text = model.name;
    cell.addressLaber.text = model.address.length>2?model.address:@"暂无地址";
    cell.mapLaber.text = model.distance.length>1?model.distance:@"暂无距离";
    cell.telImg.image = [UIImage imageNamed:@"tel"];
    cell.telLaber.text = model.tel.length>8?model.tel:@"暂无电话";
    return cell;

}
//电话事件
-(void)telAction:(UIButton *)sender
{
//    self.tel = orgin.tel;
//    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//    
//    [view show];
    
//    DataModel * data = allArr[btn.tag - 50];
    
    WHorganization * orgin = self.dataArry[sender.tag - 100];

    if (orgin.tel.length >8)
    {
        self.tel = orgin.tel;
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [view show];
        
    }else
    {
        [WBYRequest showMessage:@"无法获取电话"];
        return;
    }
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 )
    {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
