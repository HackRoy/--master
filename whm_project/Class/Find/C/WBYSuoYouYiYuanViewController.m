//
//  WBYSuoYouYiYuanViewController.m
//  whm_project
//
//  Created by apple on 17/1/10.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYSuoYouYiYuanViewController.h"
#import "MyAnimatedAnnotationView.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "WHorginTableViewCell.h"
#import "WBYHostilJiGouViewController.h"

@interface WBYSuoYouYiYuanViewController ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    NSMutableArray * allArr;
    NSMutableArray * myArr;
    NSMutableArray * nameArr;
    UITableView* myTabView;
    NSMutableArray*pointArr;
    NSString * myTel;
    NSInteger numindex;
    NSInteger pageIndex;
    
    
    BMKPointAnnotation* pointAnnotation;
    BMKPointAnnotation* animatedAnnotation;
    BMKMapView* _mapView;
    BMKLocationService * localService;
    
    
}


@end

@implementation WBYSuoYouYiYuanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"所有医院位置";
    allArr = [NSMutableArray array];
    myArr = [NSMutableArray array];
    nameArr = [NSMutableArray array];
    pointArr = [NSMutableArray array];
    numindex =  1;
    pageIndex = 15;

    [self creatLeftTtem];    
    [self ceatmapView];
    
    [self creatTab];

}

-(void)ceatmapView
{
    
    localService = [BMKLocationService new];
    [localService startUserLocationService];
    localService.distanceFilter = 100;
    localService.delegate = self;
    
    _mapView=[[BMKMapView alloc] initWithFrame:CGRectMake(0,0,wScreenW, wScreenH - 64 - 200)];
    [_mapView setZoomLevel:12.0f];
    _mapView.zoomEnabled=YES;
    _mapView.delegate=self;
    _mapView.showsUserLocation = NO;
    _mapView.showsUserLocation = YES;
    //_mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    [self.view addSubview:_mapView];
    
    
    [self creatRequest];
    
}

-(void)creatRequest
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * stringOne = [ud valueForKey:@"one"];
    NSString * stringTwo = [ud valueForKey:@"two"];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:stringOne forKey:@"lng"];
    [dic setObject:stringTwo forKey:@"lat"];
    [dic setObject:@"" forKey:@"city_name"];
    [dic setObject:@"" forKey:@"province"];
    [dic setObject:@"" forKey:@"city"];
    [dic setObject:@"" forKey:@"county"];
    [dic setObject:@"agent" forKey:@"type"];
    [dic setObject:@"30.00" forKey:@"distance"];
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:@"0" forKey:@"map"];
    [dic setObject:[NSString stringWithFormat:@"%ld",pageIndex] forKey:@"pagesize"];
    [dic setObject:[WBYRequest jiami:@"kb/get_organization"] forKey:@"kb"];
    
    [WBYRequest wbyPostRequestDataUrl:@"kb/get_organization" addParameters:dic success:^(WBYReqModel *model)
     {
         [WBYRequest showMessage:model.info];
         
         if ([model.err isEqualToString:TURE])
         {
             if (numindex == 1)
             {
                 [allArr removeAllObjects];
             }
             [allArr addObjectsFromArray:model.data];
             
         }
         
         [pointArr removeAllObjects];
         
         for (DataModel * mod in allArr)
         {
             pointAnnotation = [[BMKPointAnnotation alloc]init];
             CLLocationCoordinate2D coor;
             coor.latitude = [mod.latitude doubleValue];
             coor.longitude = [mod.longitude doubleValue];
             
             pointAnnotation.title=mod.data.name;
             pointAnnotation.coordinate = coor;
             [_mapView addAnnotation:pointAnnotation];
             [pointArr addObject:pointAnnotation];
             
         }
         
         
         
         [myTabView reloadData];
         
     } failure:^(NSError *error) {
         
     } isRefresh:YES];
}




-(void)creatTab
{
    myTabView=[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_mapView.frame), wScreenW, 200) style:UITableViewStylePlain];
    
    [myTabView registerClass:[WHorginTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTabView.delegate=self;
    myTabView.dataSource=self;
    myTabView.rowHeight=100;
    
    //    [myTabView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //    [myTabView headerBeginRefreshing];
    //    [myTabView addFooterWithTarget:self action:@selector(footerRefreshing)];
    //    [myTabView footerEndRefreshing];
    
    [self.view addSubview:myTabView];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHorginTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    DataModel * model = allArr[indexPath.row];
    
    [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    cell.mapImg.image = [UIImage imageNamed:@"maple"];
    myTel = model.tel;
    [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.titLaber.text = model.name;
    cell.addressLaber.text = model.address;
    cell.mapLaber.text = model.distance;
    cell.telImg.image = [UIImage imageNamed:@"tel"];
    cell.telLaber.text = model.tel;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


//电话事件
-(void)telAction:(UIButton *)sender
{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    [view show];
}

//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 )
    {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",myTel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    numindex = 1 ;
}
-(void)headerRereshing
{
    numindex = 1 ;
    
    [self creatRequest];
    
//    [myTabView headerEndRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    numindex ++ ;
    
    [self creatRequest];
    
//    [myTabView footerEndRefreshing];
    
}


-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    
    if (annotation == pointAnnotation)
    {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        
        if (annotationView == nil)
        {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            // 设置颜色
            //            annotationView.pinColor = BMKPinAnnotationColorPurple;
            // 从天上掉下效果
            annotationView.animatesDrop = YES;
            // 设置可拖拽
            annotationView.draggable = NO;
            annotationView.annotation = annotation;
            annotationView.image = [UIImage imageNamed:@"dailiren"];
            //            annotationView.selected = YES;
            
        }
        return annotationView;
    }
    
    //动画annotation
    NSString *AnnotationViewID = @"AnimatedAnnotation";
    MyAnimatedAnnotationView *annotationView = nil;
    if (annotationView == nil)
    {
        annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 5; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"geren%d.png", i]];
        
        [images addObject:image];
    }
    annotationView.annotationImages = images;
    
    
    return annotationView;
    
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //    [_mapView updateLocationData:userLocation];
    
    [self addAnimatedAnnotation:userLocation.location.coordinate];
}

// 添加动画Annotation
- (void)addAnimatedAnnotation:(CLLocationCoordinate2D )coor
{
    if (animatedAnnotation == nil)
    {
        animatedAnnotation = [[BMKPointAnnotation alloc]init];
        //        CLLocationCoordinate2D coor;
        //        coor.latitude = 40.115;
        //        coor.longitude = 116.404;
        animatedAnnotation.coordinate = coor;
        animatedAnnotation.title = @"我的位置";
        _mapView.centerCoordinate = coor;
        
    }
    
    [_mapView addAnnotation:animatedAnnotation];
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataModel * mod = allArr[indexPath.row];
    
    WBYHostilJiGouViewController * wby = [WBYHostilJiGouViewController new];
    wby.myDataModel = mod;
    [self.navigationController pushViewController:wby animated:YES];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
