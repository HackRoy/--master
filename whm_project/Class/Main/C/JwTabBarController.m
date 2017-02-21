//
//  JwTabBarController.m
//  Jw_Frame
//
//  Created by Jw on 16/6/17.
//  Copyright © 2016年 Jw. All rights reserved.
//

#import "JwTabBarController.h"
#import "JwNavigationController.h"
#import "UIView+Extension.h"
#import "MacroUtility.h"

//#import "JwHomeController.h"
#import "JwPhysicalController.h"
#import "TiJianShouYeViewController.h"


#import "JwLookForController.h"
#import "JwFindController.h"

#import "WHpersonCenterViewController.h"
#import "WBYmySelfViewController.h"

#import "JwLoginController.h"

#import "UIImage+Color.h"
#import "UIColor+Hex.h"
#import "JwUserCenter.h"
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#import "CCLocationManager.h"


@interface JwTabBarController ()<UITabBarControllerDelegate,CLLocationManagerDelegate>{
    CLLocationManager *locationmanager;
}
@end

@implementation JwTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self setupControllers];
    //用户登陆后的的通知
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginAction:) name:kJwIsLogin object:nil];
    
    if (IS_IOS8)
    {
        [UIApplication sharedApplication].idleTimerDisabled = TRUE;
        locationmanager = [[CLLocationManager alloc] init];
        [locationmanager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        locationmanager.delegate = self;
        
    }
    
    //获取经纬度
    [self getLat];

}

-(void)getLat
{
    __block __weak JwTabBarController *wself = self;
    
    if (IS_IOS8) {
        
        [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
            
//            NSLog(@"%f %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
            
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            
            [ud setValue:[NSString stringWithFormat:@"%f",locationCorrrdinate.longitude > 1 ? locationCorrrdinate.longitude:113.42] forKey:@"one"];
            [ud setValue:[NSString stringWithFormat:@"%f",locationCorrrdinate.latitude > 1 ? locationCorrrdinate.latitude:34.44] forKey:@"two"];
            
            [ud synchronize];
            
            [wself setLabelText:[NSString stringWithFormat:@"%f %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude]];
           
        }];
    }
    
}
-(void)setLabelText:(NSString *)text
{
    NSLog(@"text %@",text);
   // NSString * s1  = text;
    
    
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kJwIsLogin object:nil];
}



- (void)setupControllers
{
    
    
//    TiJianShouYeViewController *physical = [[TiJianShouYeViewController alloc] init];
    
    JwPhysicalController *physical = [[JwPhysicalController alloc] init];

    
    JwLookForController *lookfor = [[JwLookForController alloc] init];
    JwFindController *find = [[JwFindController alloc] init];
    //JwLoginController *login = [[JwLoginController alloc] init];
//    WHpersonCenterViewController *center = [[WHpersonCenterViewController alloc] init];
    WBYmySelfViewController *center = [[WBYmySelfViewController alloc] init];

    
    JwNavigationController *physicalVC = [[JwNavigationController alloc] initWithRootViewController:physical];
    JwNavigationController *findVC = [[JwNavigationController alloc] initWithRootViewController:find];
    JwNavigationController *lookforVC = [[JwNavigationController alloc] initWithRootViewController:lookfor];
    //JwNavigationController *loginVC = [[JwNavigationController alloc] initWithRootViewController:login];
    JwNavigationController *centerVC = [[JwNavigationController alloc] initWithRootViewController:center];
    
    
    physicalVC.tabBarItem.image = [[UIImage imageNamed:@"physical"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    lookforVC.tabBarItem.image = [[UIImage imageNamed:@"lookfor"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    findVC.tabBarItem.image = [[UIImage imageNamed:@"find"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    centerVC.tabBarItem.image = [[UIImage imageNamed:@"user"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    //loginVC.tabBarItem.image = [[UIImage imageNamed:@"user"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    lookforVC.tabBarItem.selectedImage = [UIImage imageNamed:@"lookfor_h"];
    findVC.tabBarItem.selectedImage = [UIImage imageNamed:@"find_h"];
    findVC.tabBarItem.tag = 101;
   // loginVC.tabBarItem.selectedImage = [UIImage imageNamed:@"user_h"];
     centerVC.tabBarItem.selectedImage = [UIImage imageNamed:@"user_h"];
    physicalVC.tabBarItem.selectedImage = [UIImage imageNamed:@"physical_h"];
     physicalVC.title = @"体检";
    lookfor.title = lookforVC.title = @"首页";
     physicalVC.title = @"体检";
    lookfor.title = lookforVC.title = @"找险种";
    find.title = findVC.title = @"发现";
    //login.title = loginVC.title = @"我的";
    center.title = centerVC.title = @"我的";
    if ([JwUserCenter sharedCenter].key == nil)
    {
    //self.viewControllers = @[lookforVC,physicalVC, findVC, loginVC];
    }
    else
    {
       // self.viewControllers = @[lookforVC,physicalVC, findVC, centerVC];
    }
    
    self.viewControllers = @[lookforVC,physicalVC, findVC, centerVC];

    
    //[self setupView];
    
    
    
    /*
    JwHomeController *home = [[JwHomeController alloc] init];
    JwPhysicalController *physical = [[JwPhysicalController alloc] init];
    JwLookForController *lookfor = [[JwLookForController alloc] init];
    JwFindController *find = [[JwFindController alloc] init];
    
    WHpersonCenterViewController *center = [[WHpersonCenterViewController alloc] init];
    JwLoginController *login = [[JwLoginController alloc] init];
    
    JwNavigationController *homeVC = [[JwNavigationController alloc] initWithRootViewController:home];
    JwNavigationController *physicalVC = [[JwNavigationController alloc] initWithRootViewController:physical];
    JwNavigationController *lookforVC = [[JwNavigationController alloc] initWithRootViewController:lookfor];
    JwNavigationController *findVC = [[JwNavigationController alloc] initWithRootViewController:find];
    
    JwNavigationController *centerVC = [[JwNavigationController alloc] initWithRootViewController:center];
    JwNavigationController *loginVC = [[JwNavigationController alloc] initWithRootViewController:login];
    
   homeVC.tabBarItem.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    physicalVC.tabBarItem.image = [[UIImage imageNamed:@"physical"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    lookforVC.tabBarItem.image = [[UIImage imageNamed:@"lookfor"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    lookforVC.tabBarItem.tag = 101;
    
    
    findVC.tabBarItem.image = [[UIImage imageNamed:@"find"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    centerVC.tabBarItem.image = [[UIImage imageNamed:@"user"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    loginVC.tabBarItem.image = [[UIImage imageNamed:@"user"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
   homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"home_h"];
    physicalVC.tabBarItem.selectedImage = [UIImage imageNamed:@"physical_h"];
   lookforVC.tabBarItem.selectedImage = [UIImage imageNamed:@"lookfor_h"];
    findVC.tabBarItem.selectedImage = [UIImage imageNamed:@"find_h"];
    
    centerVC.tabBarItem.selectedImage = [UIImage imageNamed:@"user_h"];
    loginVC.tabBarItem.selectedImage = [UIImage imageNamed:@"user_h"];
    
   home.title = homeVC.title = @"首页";
    physical.title = physicalVC.title = @"体检";
    lookfor.title = lookforVC.title = @"找险";
    find.title = findVC.title = @"发现";
    
    center.title = centerVC.title = @"我的";
    login.title = loginVC.title = @"我的";
    
    [self setupView];
    
    if ([JwUserCenter sharedCenter].key == nil) {
        self.viewControllers = @[homeVC, physicalVC, lookforVC, findVC, loginVC];
    }else{
        self.viewControllers = @[homeVC, physicalVC, lookforVC, findVC, centerVC];
    }
    
//    if ([JwUserCenter sharedCenter].key == nil) {
//        self.viewControllers = @[ physicalVC, lookforVC, findVC, loginVC];
//    }else{
//        self.viewControllers = @[ physicalVC, lookforVC, findVC, centerVC];
//    }

    */
}

- (void)setupView{
    self.tabBar.translucent = NO;
    [self.tabBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHex:0xf5f7f9]]];
    [self.tabBar setShadowImage:[UIImage createImageWithColor:[UIColor colorWithHex:0xf5f7f9]]];
    
    UIView *view = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, self.tabBar.jw_height + 25, self.tabBar.jw_height + 0))];
    view.layer.cornerRadius = view.jw_width/2;
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage createImageWithColor:[UIColor colorWithHex:0xf5f7f9]]];
    view.layer.masksToBounds = YES;
    view.jw_centerX = self.tabBar.jw_width/2;
    view.jw_centerY = self.tabBar.jw_height/2;
    [self.tabBar addSubview:view];
    [self.tabBar sendSubviewToBack:view];
}

/*
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item.tag == 101)
    {
        [self setupShareView];
    }
}

- (void)setupShareView{
    
    //中间按钮pop控制器
    DLog(@"中间点击事件");
    JwFindController * lookfor = [[JwFindController alloc]init];
    JwNavigationController *lookforVC = [[JwNavigationController alloc] initWithRootViewController:lookfor];
    lookfor.title = lookforVC.title = @"发现";
 
    JwLookForController *lookfor = [[JwLookForController alloc] init];
    JwNavigationController *lookforVC = [[JwNavigationController alloc] initWithRootViewController:lookfor];
    lookfor.title = lookforVC.title = @"找险";
 
    
   // [self presentViewController:lookforVC animated:YES completion:nil];
  
    
//}



- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (viewController == [tabBarController.viewControllers objectAtIndex:2]) {
        return NO;
    }else{
        return YES;
    }
}


*/
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
