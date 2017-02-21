//
//  BaseViewController.m
//  KuiBuText
//
//  Created by Baoya on 16/2/25.
//  Copyright © 2016年 Baoya. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    //关闭scroll的自适应
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = NO;
   self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.translucent = NO;
//     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:23.0/255 green:160.0/255 blue:229.0/225 alpha:1]];
    
//     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:68.0/255 green:104.0/255 blue:255.0/225 alpha:1]];
    
    //如果这个视图有导航栏 并且 不是导航控制器的根视图控制器
    //为视图控制器创建左侧的返回Item按钮
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16.f],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    if (self.navigationController && self != self.navigationController.viewControllers[0])
    {
        
       [self creatLiftItemWith:[UIImage imageNamed:@"箭头"] withFrame:CGRectMake(0, 0, 37.0/3, 56.0/3)];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

//处理内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && !self.view.window)
    {
        self.view = nil;
    }

}

#pragma mark - custom method

-(void)creatLeftTtem
{
    
    [self creatLiftItemWith:[UIImage imageNamed:@"back"] withFrame:CGRectMake(0, 0,16, 20)];  
    
}
-(void)creatLiftItemWith:(UIImage *)backImg withFrame:(CGRect)frame
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=frame;
    [button setBackgroundImage:backImg forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)creatRightItemWith:(UIImage *)backImg withFrame:(CGRect)frame
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=frame;
    [button setBackgroundImage:backImg forState:UIControlStateNormal];
    //    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
}

//导航栏左按钮(返回按钮) - 触发事件
- (void)backButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)headView:(NSString*)str
{
    UIView*bgView=[[UIView alloc] initWithFrame:CGRectMake(0,0,wScreenW,44)];
    bgView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView=bgView;

    
  UILabel*lab=[[UILabel alloc] initWithFrame:CGRectMake(0,0,wScreenW,44)];
    lab.text=str;
//  CGFloat w=[WBYRequest getWeightForString:str withHeight:44 withFontSize:24];
//    lab.bounds=CGRectMake(0,0,w,44);
    
    lab.textColor=[UIColor whiteColor];
    lab.textAlignment=1;
//    lab.textColor=kRedColor;
//    lab.center=CGPointMake(bgView.center.x, bgView.center.y);
    
    [bgView addSubview:lab];
    
}

-(void)litheadView:(NSString*)str
{
    
//    UIView*bgView=[[UIView alloc] initWithFrame:CGRectMake(0,0,wScreenW,44)];
//    bgView.contentMode=UIViewContentModeScaleAspectFit;
//    self.navigationItem.titleView=bgView;
//       UILabel*lab=[[UILabel alloc] initWithFrame:CGRectMake(0,0,50,44)];
//    lab.text=str;
//    CGFloat w=[WBYRequest getWeightForString:str withHeight:44 withFontSize:20];
//    lab.bounds=CGRectMake(0,0,w,44);
//    lab.textColor=[UIColor whiteColor];
//    lab.textAlignment=1;
//    lab.center=CGPointMake(bgView.center.x-12, bgView.center.y);
//    [bgView addSubview:lab];
//    
//    UIImageView* img=[[UIImageView alloc] init];
//    img.image=[UIImage imageNamed:@"logo"];
//    img.frame=CGRectMake(CGRectGetMidX(lab.frame)-24-w/2-8,10,24,24);
//    
//    [bgView addSubview:img];
    
    
}

#pragma mark -- Getter
-(JwDataService *)dataService
{
    _dataService = [[JwDataService alloc] init];
    return _dataService;
}

- (JwUserService *)userService{
    
    _userService = [[JwUserService alloc] init];
    return _userService;
}








@end
