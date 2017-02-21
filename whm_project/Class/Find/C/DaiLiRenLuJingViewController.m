//
//  DaiLiRenLuJingViewController.m
//  whm_project
//
//  Created by Stephy_xue on 17/1/8.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "DaiLiRenLuJingViewController.h"
#import "TextViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "MyAnimatedAnnotationView.h"
#import <MapKit/MapKit.h>

#import "WHwantMessageViewController.h"

@interface DaiLiRenLuJingViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UIActionSheetDelegate>
{
    BMKMapView* _mapView;
    BMKPointAnnotation* pointAnnotation;
    BMKLocationService * localService;
}
@property(nonatomic,strong)UIView * myView;
@property(nonatomic,strong)UIImageView * myImg;
@property(nonatomic,strong)UIImageView* sexImg;
@property(nonatomic,strong)UILabel * ageLaber;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UILabel * myLaber;
@property(nonatomic,strong)UIButton * mesBut;
@property(nonatomic,strong)UIButton * telBut;
@property(nonatomic,strong)UIButton * rodeBut;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;  //!< 要导航的坐标

@end

@implementation DaiLiRenLuJingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"代理人位置";
    [self creatLeftTtem];
    [self creatmap];
    [self creetUI];
    
}

-(void)creatmap
{
    localService = [BMKLocationService new];
    [localService startUserLocationService];
//    localService.distanceFilter = 100;
    localService.delegate = self;
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH * 0.75)];
    [_mapView setZoomLevel:13.0f];
    _mapView.delegate = self;
    _mapView.zoomEnabled=YES;

    [self.view addSubview:_mapView];
    
    pointAnnotation = [[BMKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D  coordinate;
    pointAnnotation.title = @"代理人位置";
    
    if ([_dailirenJin isEqualToString:@"dailiren"])
    {
        if (_myDataMod.location.coordinates.count == 2)
        {
            coordinate.latitude = [_myDataMod.location.coordinates[1] floatValue];
            coordinate.longitude = [_myDataMod.location.coordinates[0] floatValue];
        }
    }else
    {
        coordinate.latitude = [_pweidu floatValue];
        coordinate.longitude =[_pjingdu floatValue];
        
        
    }
    
    pointAnnotation.coordinate = coordinate;

    [_mapView  addAnnotation:pointAnnotation];
    [_mapView setCenterCoordinate:coordinate];
    
    
    self.coordinate = coordinate;
    
    
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
    for (int i = 1; i < 3; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"geren%d.png", i]];
        
        [images addObject:image];
    }
    annotationView.annotationImages = images;
    annotationView.selected = YES;
    
    return annotationView;
    

    
   


}


-(void)creetUI
{
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(0, wScreenH * 0.75, wScreenW, wScreenH * 0.25);
    [self.view addSubview:_myView];
    //
    self.myImg = [[UIImageView alloc]init];
    self.myImg.frame = CGRectMake(10, 10, wScreenW * 0.15,wScreenW * 0.15);
    self.myImg.layer.masksToBounds = YES;
    self.myImg.layer.cornerRadius = wScreenW * 0.075;
    
    [self.myView addSubview:_myImg];
    //
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.myImg.frame)+3, CGRectGetMinY(self.myImg.frame), wScreenW * 0.15, 30);
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
    self.ageLaber.frame = CGRectMake(CGRectGetMaxX(self.sexImg.frame)+3, CGRectGetMinY(self.sexImg.frame), wScreenW * 0.15, 20);
    self.ageLaber.textColor = [UIColor grayColor];
    self.ageLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_ageLaber];
    //
    self.myLaber = [[UILabel alloc]init];
    self.myLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMaxY(self.nameLaber.frame)+5, wScreenW * 0.5, 20);
    self.myLaber.textColor = [UIColor grayColor];
    self.myLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_myLaber];
    //self.myLaber.text = @"新华人寿 经理 从业5年 全国";
    //
    self.mesBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mesBut.frame = CGRectMake(wScreenW * 0.6, 10, wScreenW * 0.1, wScreenW * 0.1);
    [self.mesBut setBackgroundImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
    [self.mesBut addTarget:self action:@selector(mess) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [self.myView addSubview:_mesBut];
    //
    self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.telBut.frame = CGRectMake(CGRectGetMaxX(self.mesBut.frame)+5, CGRectGetMinY(self.mesBut.frame), wScreenW * 0.1, CGRectGetHeight(self.mesBut.frame));
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

//电话事件
-(void)telAction:(UIButton *)sender
{
    
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    [view show];
    
    
}

-(void)mess
{
    
    WHwantMessageViewController * mess = [WHwantMessageViewController new];
    [self.navigationController pushViewController:mess animated:YES];
    
    if ([_dailirenJin isEqualToString:@"dailiren"])
    {
//        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"sms:%@",self.myDataMod.data.mobile];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        
        
    }else
    {
//        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"sms:%@",self.p_myMobile];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//        
    }
    
}
-(void)lujing
{
    if ([_dailirenJin isEqualToString:@"dailiren"])
    {
//        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"sms:%@",self.myDataMod.data.mobile];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        if (_myDataMod.data.job_address.length < 5)
        {
            [WBYRequest showMessage:@"地址不详无法导航"];
            return;
        }else
        {
            [self creatMyMapUI:_myDataMod.data.job_address];
 
        }        
        
    }else
    {
        if ([_pjopAddress isEqualToString:@"地址不详"])
        {
            [WBYRequest showMessage:@"地址不详无法导航"];
            return;
        }else
        {
            [self creatMyMapUI:self.pjopAddress];

        }
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
        
        //判断是否安装了高德地图，如果安装了高德地图，则使用高德地图导航
//        if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
//            
//            [alertController addAction:[UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//                NSLog(@"alertController -- 高德地图");
//                NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",self.coordinate.latitude,self.coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
//                
//            }]];
//        }
        
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
