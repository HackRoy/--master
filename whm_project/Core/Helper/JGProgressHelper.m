//
//  JGProgressHelper.m
//  e-bank
//
//  Created by 汤海波 on 6/24/15.
//  Copyright (c) 2015 iHugo. All rights reserved.
//

#import "JGProgressHelper.h"

#define kShowDuration 2.5

@implementation JGProgressHelper

+ (void)showError:(NSString *)error inView:(UIView *)view {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"failure"]];
    [view addSubview:HUD];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.detailsLabelText = error;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:kShowDuration];
}

+ (void)showSuccess:(NSString *)success inView:(UIView *)view{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
    [view addSubview:HUD];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.detailsLabelText = success;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:kShowDuration];
}

+ (void)showError:(NSString *)error {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [self showError:error inView:view];
}

+ (void)showSuccess:(NSString *)success {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [self showSuccess:success inView:view];
}

+ (MBProgressHUD *)showProgressInView:(UIView *)inView {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:inView];
    HUD.mode = MBProgressHUDModeIndeterminate;
    [inView addSubview:HUD];
    [HUD show:YES];
    return HUD;
}

+ (MBProgressHUD *)showProgress{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    return [self showProgressInView:view];
}

@end
