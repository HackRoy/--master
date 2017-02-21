//
//  WBYMYBASEViewController.m
//  whm_project
//
//  Created by apple on 17/2/17.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYMYBASEViewController.h"

@interface WBYMYBASEViewController ()

@end

@implementation WBYMYBASEViewController

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
         [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:68.0/255 green:104.0/255 blue:255.0/225 alpha:1]];
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
