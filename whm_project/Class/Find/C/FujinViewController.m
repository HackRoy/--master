//
//  FujinViewController.m
//  whm_project
//
//  Created by apple on 17/1/7.
//  Copyright © 2017年 chenJw. All rights reserved.
// WHnearAgentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

#import "FujinViewController.h"
#import "MJRefresh.h"
#import "MyAnimatedAnnotationView.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

#import "WHnearAgentTableViewCell.h"
#import "WHnearMapViewController.h"
#import "DaiLiRenLuJingViewController.h"

@interface FujinViewController ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKLocationServiceDelegate>
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
//@property(nonatomic,assign)

@end

@implementation FujinViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    allArr = [NSMutableArray array];
    myArr = [NSMutableArray array];
    nameArr = [NSMutableArray array];
    pointArr = [NSMutableArray array];
    numindex =  1;
    pageIndex = 15;
    [self ceatmapView];

    self.title = @"代理人位置";
    
    [self creatLeftTtem];

    [self creatTab];

    
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
    [dic setObject:@"" forKey:@"map"];
    [dic setObject:[NSString stringWithFormat:@"%ld",pageIndex] forKey:@"pagesize"];
    [dic setObject:[WBYRequest jiami:@"kb/get_near_agent"] forKey:@"kb"];
    
    [WBYRequest wbyPostRequestDataUrl:@"kb/get_near_agent" addParameters:dic success:^(WBYReqModel *model)
    {
        NSLog(@"====%@====%@",model.info,model.err);
        
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
       
        [_mapView removeAnnotations:_mapView.annotations];
        
        for (DataModel * mod in allArr)
        {

            pointAnnotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = [mod.location.coordinates[1] doubleValue];
            coor.longitude = [mod.location.coordinates[0] doubleValue];
            
            pointAnnotation.title=mod.data.name;
            pointAnnotation.coordinate = coor;
            [_mapView addAnnotation:pointAnnotation];
            [pointArr addObject:pointAnnotation];
            
            NSLog(@"112========%@",mod.location.coordinates[1]);
        }
        
        
        [myTabView reloadData];

    } failure:^(NSError *error) {
        
    } isRefresh:YES];
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
    
    [myTabView headerEndRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
       numindex ++ ;
    
        [self creatRequest];
    
    [myTabView footerEndRefreshing];
    
}



#pragma mark====tab代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHnearAgentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
           DataModel * mod = allArr[indexPath.row];
    //        NSLog(@"====%@======%@",mod.data.name,mod.location.coordinates);
    [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    cell.telBut.tag = 1212 + indexPath.row;
  [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    myTel = mod.data.mobile;
    
    cell.nameLaber.text = mod.data.name;
     [cell.myImage sd_setBackgroundImageWithURL:[NSURL URLWithString:mod.data.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Jw_user"]];
    
    if ([mod.data.sex isEqualToString:@"2"])
    {
        cell.sexImg.image = [UIImage imageNamed:@"test_famale"];
    }else
    {
        cell.sexImg.image = [UIImage imageNamed:@"test_male"];
        
    }
    cell.mapImg.image = [UIImage imageNamed:@"maple"];
    cell.telImg.image = [UIImage imageNamed:@"tel"];
    cell.addressLaber.text = mod.data.job_address?mod.data.job_address:@"地址不详";
    
    cell.telLaber.text = mod.data.mobile;
    cell.companyLaber.text = mod.data.com_name;
    
    CGFloat juli = [mod.dist floatValue];
    
    NSString * myJuli;
    if (juli < 1000)
    {
        myJuli = [NSString stringWithFormat:@"%.1fM",juli];
    }else
    {
        CGFloat kJuli = juli/1000;
        myJuli = [NSString stringWithFormat:@"%.2fKM",kJuli];
    }
    cell.mapLaber.text = myJuli;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DataModel * mod = allArr[indexPath.row];
   DaiLiRenLuJingViewController * mapNear =  [DaiLiRenLuJingViewController new];
     mapNear.myDataMod = mod;
    mapNear.dailirenJin = @"dailiren";
    
    [self.navigationController pushViewController:mapNear animated:YES];
    
    
    
}


-(void)telAction:(UIButton *)btn
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
-(void)creatTab
{
    myTabView=[[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_mapView.frame), wScreenW, 200) style:UITableViewStylePlain];
    
    [myTabView registerClass:[WHnearAgentTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTabView.delegate=self;
    myTabView.dataSource=self;
    myTabView.rowHeight=100;
    
//    [myTabView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [myTabView addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    [self.view addSubview:myTabView];
    
    
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
