//
//  WBYFzljghViewController.m
//  whm_project
//
//  Created by apple on 17/1/10.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYFzljghViewController.h"
#import "WBYFlujinhTableViewCell.h"
#import <MapKit/MapKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "MyAnimatedAnnotationView.h"
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
@interface WBYFzljghViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UIActionSheetDelegate>
{
    BMKMapView* _mapView;
    BMKPointAnnotation* pointAnnotation;
    BMKLocationService * localService;

    
}
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;  //!< 要导航的坐标

@property(nonatomic,strong)UIView * myView;
@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)UILabel * addressLaber ;
@property(nonatomic,strong)UIImageView * mapImg;
@property(nonatomic,strong)UIImageView * telImg;
@property(nonatomic,strong)UILabel * telLab;

@property(nonatomic,strong)UILabel * mapLaber;
@property(nonatomic,strong)UIButton * telBut;
@property(nonatomic,strong)UIButton * rodeBut;


@end

@implementation WBYFzljghViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.title = @"分支机构位置";
    [self creatLeftTtem];

    [self creatmap];
    
    
}
-(void)creatmap
{
    
    localService = [BMKLocationService new];
    [localService startUserLocationService];
    //    localService.distanceFilter = 100;
    localService.delegate = self;
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, wScreenW,(wScreenH - 64 -80))];
    [_mapView setZoomLevel:13.0f];
    _mapView.delegate = self;
    _mapView.zoomEnabled=YES;
    
    [self.view addSubview:_mapView];
    
    pointAnnotation = [[BMKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D  coordinate;
    pointAnnotation.title = _myDataModel.name;
    coordinate.latitude = [_myDataModel.latitude floatValue];
    coordinate.longitude = [_myDataModel.longitude floatValue];
    
    pointAnnotation.coordinate = coordinate;
    
    [_mapView  addAnnotation:pointAnnotation];
    [_mapView setCenterCoordinate:coordinate];
    self.coordinate = coordinate;
    
    CGFloat hh = 80;
    CGFloat litH = hh/3;
    CGFloat ww =2 * wScreenW/3;
    
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(0, CGRectGetMaxY(_mapView.frame), wScreenW, hh);
    // self.myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_myView];
    self.titLaber = [[UILabel alloc]init];
    self.titLaber.frame =  CGRectMake(10, 0, ww, litH);
//    self.titLaber.textAlignment = 1;
    self.titLaber.font = [UIFont systemFontOfSize:12.0];
    [self.myView addSubview:_titLaber];
    
    self.titLaber.text = self.myDataModel.name;

    self.addressLaber = [[UILabel alloc]init];
    self.addressLaber.frame = CGRectMake(10,litH,ww, litH);
//    self.addressLaber.textAlignment = 1;
    self.addressLaber.textColor = [UIColor grayColor];
    self.addressLaber.font = [UIFont systemFontOfSize:10.0];
    self.addressLaber.text = self.myDataModel.address;

    [self.myView addSubview:_addressLaber];
    
    
        self.mapImg = [[UIImageView alloc]init];
        self.mapImg.frame = CGRectMake(10, CGRectGetMaxY(self.addressLaber.frame), 20, 20);
        self.mapImg.image = [UIImage imageNamed:@"maple"];
        [self.myView addSubview:_mapImg];
    
       self.mapLaber=[UILabel new];
       self.mapLaber.frame = CGRectMake(CGRectGetMaxX(self.mapImg.frame)+3, CGRectGetMaxY(self.addressLaber.frame),50, litH);
        self.mapLaber.textColor = [UIColor greenColor];
        self.mapLaber.text = self.myDataModel.distance.length>1?self.myDataModel.distance:@"暂无距离";
    self.mapLaber.textAlignment=1;
        self.mapLaber.font = [UIFont systemFontOfSize:12.0];
        [self.myView addSubview:_mapLaber];
    
    
    self.telImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.mapLaber.frame)+2, CGRectGetMaxY(self.addressLaber.frame), 20, 20)];
    self.telImg.image = [UIImage imageNamed:@"tel"];
    [self.myView addSubview:self.telImg];

    self.telLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.telImg.frame)+2, CGRectGetMaxY(self.addressLaber.frame), 100, 20)];
    self.telLab.font = [UIFont systemFontOfSize:12];
//    self.telLab.backgroundColor = wRedColor;
    self.telLab.textColor = wGrayColor2;
    self.telLab.text = self.myDataModel.tel.length>8?self.myDataModel.tel:@"暂无电话";
    
    [self.myView addSubview:self.telLab];

        self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.telBut.frame = CGRectMake(CGRectGetMaxX(self.addressLaber.frame) + 5,20,40,40);
        [self.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
        [self.telBut addTarget:self action:@selector(telAction) forControlEvents:(UIControlEventTouchUpInside)];
     [self.myView addSubview:_telBut];

        self.rodeBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.rodeBut.frame = CGRectMake(CGRectGetMaxX(self.telBut.frame)+3, 20, CGRectGetWidth(self.telBut.frame), CGRectGetHeight(self.telBut.frame));
        [self.rodeBut setBackgroundImage:[UIImage imageNamed:@"rideImg"] forState:(UIControlStateNormal)];
        [self.myView addSubview:_rodeBut];
        [self.rodeBut addTarget:self action:@selector(rodeButAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
}
-(void)rodeButAction
{
    if (_myDataModel.latitude.length < 5 || _myDataModel.longitude.length < 5)
    {
        [WBYRequest showMessage:@"地址不详无法导航"];
    }else
    {
        [self creatMyMapUI:_myDataModel.name];
    }
}

-(void)telAction
{
    if (self.myDataModel.tel.length>8)
    {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [view show];
    }else
    {
        [WBYRequest showMessage:@"暂无电话"];
        return;
    }
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 )
    {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.myDataModel.tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
     //动画annotation
    NSString *AnnotationViewID = @"AnimatedAnnotation";
    MyAnimatedAnnotationView *annotationView = nil;
    if (annotationView == nil)
    {
        annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"geren%d.png", i]];
        
        [images addObject:image];
    }
    annotationView.annotationImages = images;
    annotationView.selected = YES;
    
    return annotationView;
}

-(void)creatMyMapUI:(NSString *)strName
{
    //系统版本高于8.0，使用UIAlertController
    if (IS_SystemVersionGreaterThanEight)
    {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"路径规划" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //自带地图
        [alertController addAction:[UIAlertAction actionWithTitle:@"系统地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //使用自带地图导航
            MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil]];
            
            toLocation.name = strName;
            
            [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
            
            
        }]];
        
        
        //判断是否安装了百度地图，如果安装了百度地图，则使用百度地图导航
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
        {
            [alertController addAction:[UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                        {
                                            
                                            NSLog(@"alertController -- 百度地图");
                                            NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.coordinate.latitude,self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
                                            
                                        }]];
        }
        
        //添加取消选项
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [alertController dismissViewControllerAnimated:YES completion:nil];
            
        }]];
        
        //显示alertController
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else {  //系统版本低于8.0，则使用UIActionSheet
        
        UIActionSheet * actionsheet = [[UIActionSheet alloc] initWithTitle:@"导航到设备" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"自带地图", nil];
        
        //如果安装高德地图，则添加高德地图选项
        //        if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
        //        {
        //            [actionsheet addButtonWithTitle:@"高德地图"];
        //        }
        //如果安装百度地图，则添加百度地图选项
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
        {
            [actionsheet addButtonWithTitle:@"百度地图"];
        }
        
        [actionsheet showInView:self.view];
        
        
    }
}


- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    NSLog(@"ActionSheet - 取消了");
    [actionSheet removeFromSuperview];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil]];
        [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
        
    }
    //既安装了高德地图，又安装了百度地图
    if (actionSheet.numberOfButtons == 4)
    {
        
        //        if (buttonIndex == 2) {
        //            NSLog(@"高德地图触发了");
        //            NSString *urlsting =[[NSString stringWithFormat:@"iosamap://path?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",self.coordinate.latitude,self.coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //            [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
        //
        //
        //        }
        if (buttonIndex == 3) {
            
            NSLog(@"百度地图触发了");
            NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.coordinate.latitude,self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
        }
        
    }
    //安装了高德地图或安装了百度地图
    if (actionSheet.numberOfButtons == 3)
    {
        if (buttonIndex == 2)
        {
            //            if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
            //            {
            //                NSLog(@"只安装的高德地图触发了");
            //                NSString *urlsting =[[NSString stringWithFormat:@"iosamap://path?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",self.coordinate.latitude,self.coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //                [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
            //
            //            }
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
            {
                NSLog(@"只安装的百度地图触发了");
                NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.coordinate.latitude,self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
            }
        }
        
    }
    
}






- (void)didReceiveMemoryWarning
{
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
