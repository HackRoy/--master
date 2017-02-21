//
//  AppDelegate.m
//  whm_project
//
//  Created by chenJw on 16/10/17.
//  Copyright © 2016年 chenJw. All rights reserved.

#import "AppDelegate.h"
#import "JwTabBarController.h"
#import "IQKeyboardManager.h"
#import "WZGuideViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import <CoreLocation/CoreLocation.h>
#import "JwLoginController.h"
#import "YinDaoViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import "iflyMSC/IFlyMSC.h"

@interface AppDelegate () <BMKLocationServiceDelegate>
@property(nonatomic,strong) CLLocationManager *locationManager;
@property(nonatomic,strong)BMKMapManager * mapManager;
@end

@implementation AppDelegate

- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self initKeyboardManager];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changelogin) name:@"signOut" object:nil];
    NSUserDefaults*defau=[NSUserDefaults standardUserDefaults];
    
    NSString*str=[defau objectForKey:@"zheshidiyici"];
    
    if ([str isEqualToString:@"diyici"])
    {
        JwTabBarController*view=[JwTabBarController new];
        self.window.rootViewController=view;
    }
    else
    {
        YinDaoViewController*view=[YinDaoViewController new];
        self.window.rootViewController=view;
    }
    
//    self.window.rootViewController = [[JwTabBarController alloc] init];
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
   
    BOOL ret = [_mapManager start:@"CSZv39bjvYYwu3D2mO5xKwxc4fwDA01I" generalDelegate:self];
    
    if (!ret)
    {
        NSLog(@"manager start failed!");
    } else {
        NSLog(@"鉴权成功！");
    }
    if ([CLLocationManager locationServicesEnabled])
    {
        //  如果没有授权则请求用户授权
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
        {
            NSLog(@"请求用户授权");
            [self.locationManager requestWhenInUseAuthorization];
        }
    }else
    {
        NSLog(@"还没有打开手机定位功能");
    }
    self.locationService = [[BMKLocationService alloc] init];
    //    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    
    //引导页
    //增加标识，用于判断是否是第一次启动应用...
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
//        
//    }
 
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
//        [WZGuideViewController show];
//    }
    
    [WXApi registerApp:WEICHATAPPKEY withDescription:@"微信demo"];
    [self shareUmeng];    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    [IFlySpeechUtility createUtility:initString];
    [self.window makeKeyAndVisible];
       return YES;
}

-(void)changelogin
{
   NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:[JwUserCenter sharedCenter].uid];
    [user removeObjectForKey:[JwUserCenter sharedCenter].key];
    [user removeObjectForKey:MYUID];
    [user removeObjectForKey:MYTOKEN];
    [user synchronize];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[[JwLoginController alloc] init]];
    
    self.window.rootViewController=nav;
    
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"signOut" object:nil];
}

//分享
-(void)shareUmeng
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"576bac6d67e58e0b6b000a36"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxff52ab613da7ab0c" appSecret:@"fcf5880a37638b5cf21f344d92220042" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105469472" appKey:@"t7lum7Vsb1K9bOvq" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
//                                              secret:@"04b48b094faeb16683c32669824ebdad"
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//
    
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //调用其他SDK，例如支付宝SDK等
//    }
//    return result;
//}


/*
 *  键盘高度计算以及BarTool
 */
- (void)initKeyboardManager {
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"])
    {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic)
        {
            NSLog(@"result = %@",resultDic);
            
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic)
        {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0)
            {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr)
                {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="])
                    {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
        }];
        
    }else
    {
        BOOL result = [UMSocialSnsService handleOpenURL:url];
        [[IFlySpeechUtility getUtility] handleOpenURL:url];
        return result;
    }
        return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"])
    {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic)
        {
            NSString * wwww=resultDic[@"resultStatus"];
            if ([wwww isEqualToString:@"9000"])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tiaozhuan" object:nil];
            }
        }];
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic)
        {
            NSLog(@"456result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            
        }];
    }
    return YES;
}
//
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
 
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.window endEditing:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
