//
//  JGProgressHelper.h
//  e-bank
//
//  Created by 汤海波 on 6/24/15.
//  Copyright (c) 2015 iHugo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface JGProgressHelper : NSObject

+ (void)showError:(NSString *)error inView:(UIView *)view;
+ (void)showSuccess:(NSString *)success inView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showSuccess:(NSString *)success;

+ (MBProgressHUD *)showProgress;

+ (MBProgressHUD *)showProgressInView:(UIView *)inView;


@end
