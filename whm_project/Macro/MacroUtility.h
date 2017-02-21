//
//  MacroUtility.h
//  e-bank
//whmmmmmmm
//  Created by chenJw on 16/9/6.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#ifndef MacroUtility_h
#define MacroUtility_h

/*** Height */
#define kStatusBarHeight 20
#define kNavBarHeight 44
#define kTabBarHeight 49
#define kScreenWitdh [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/*** Macro */
#define Weak(name) __weak __typeof(name) w##name = name

/** 用户邮箱本地存储key */
#define kUDKeyLoginEmail @"LoginEmail"

/*** DLOG */
#if DEBUG
#ifndef DLog
#define DLog(format, args...) \
NSLog(@"[%s:%d]: " format "\n", strrchr(__FILE__, '/') + 1, __LINE__, ## args);
#endif
#else
#ifndef DLog
#define DLog(format, args...) do {} while(0)
#endif
#endif

/*** 通知中心 */
#define JwNotificationCenter [NSNotificationCenter defaultCenter]

/*** 获取当前系统的版本号 */
#define JwFloatValue [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *  RGB颜色
 */
#define JwColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/**
 *  RGBA颜色
 */
#define JwColorRGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]


/**
 *  体检-->选择被保人-->背景颜色(灰色)
 */
#define HmInsuredBGGrayColor JwColorRGB(244, 244, 244)

//Jw通知
#define kJwIsLogin @"isLogin"



#endif /* MacroUtility_h */
