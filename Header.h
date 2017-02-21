//
//  Header.h
//  whm_project
//
//  Created by Stephy_xue on 16/12/23.
//  Copyright © 2016年 chenJw. All rights reserved.

#ifndef Header_h
#define Header_h
#import "UMSocial.h"
#import "YCXMenu.h"
#import "UIColor+Hex.h"
#import "JGProgressHelper.h"
#import <UIImageView+WebCache.h>
#import "WBYRequest.h"
#import "JwDataService.h"
#import "JwUserService.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "JwUserCenter.h"
#import "JwModelBase.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "WXApiManager.h"
#import "MyDdddd.h"
#import "UIButton+WebCache.h"

#define kKeyMobileBase @"user"

#define   TONGZHI   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[[NSNotificationCenter defaultCenter] postNotificationName:@"signOut" object:nil];});


#define MYTOKEN @"mytoken"
#define MYUID @"myuid"


#define IS_SystemVersionGreaterThanEight  ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0)
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>
#define BASE_REST_URL @"https://www.kuaibao365.com/product/details"
#define STOREAPPID @"1133378369"
#define WEICHATAPPKEY @"wxbdc42b2a35e9884e" //微信appkey
#define TURE @"0"

#define SAME @"1304"


#define BASEURL    @"https://www.kuaibao365.com/api/"
#define wScreenW   [UIScreen mainScreen].bounds.size.width
#define wScreenH   [UIScreen mainScreen].bounds.size.height

#define XINGMING  [[NSUserDefaults standardUserDefaults] objectForKey:@"xingming"]



//42 109 123

#define wLvColour [UIColor colorWithRed:42 / 255.0 green:209 / 255.0 blue:123 / 255.0 alpha:1.0]
#define wBaseColor [UIColor colorWithRed:246 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]
#define wBlue  [UIColor colorWithRed:68.0/255 green:103.0/255 blue:255.0/225 alpha:1]
#define wOrangeColor [UIColor colorWithRed:230.0/255 green:100.0/255 blue:8.0/255 alpha:1]
#define wBlueColor UIColorFromRGB(0x1874CD)

#define wRedColor  [UIColor colorWithRed:255/255.0 green:80/255.0 blue:100/255.0 alpha:1.0]
#define wWhiteColor [UIColor whiteColor]

#define wGrayColor [UIColor colorWithRed:195.0/255 green:196.0/255 blue:197.0/255 alpha:1.0]
#define wGrayColor1 [UIColor colorWithRed:101.0/255 green:102.0/255 blue:103.0/255 alpha:1.0]

#define wGrayColor2 [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1.0]

#define JinSe [UIColor colorWithRed:255/255.f green:199/255.f blue:117/255.f alpha:1]

#define APPID_VALUE           @"586dfe31"



#endif /* Header_h */
