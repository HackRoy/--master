//
//  BaseViewController.h
//  KuiBuText
//
//  Created by Baoya on 16/2/25.
//  Copyright © 2016年 Baoya. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WBYRequest.h"
@interface BaseViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, strong) JwDataService *dataService;
@property (nonatomic, strong) JwUserService *userService;


-(void)creatLeftTtem;
-(void)headView:(NSString*)str;
-(void)litheadView:(NSString*)str;

@end
