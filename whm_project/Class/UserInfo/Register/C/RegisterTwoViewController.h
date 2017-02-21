//
//  RegisterTwoViewController.h
//  小胖的demo
//
//  Created by YiTu8 on 16/10/18.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwBackBaseController.h"

@interface RegisterTwoViewController : JwBackBaseController
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * mobile;
@property(nonatomic,strong)NSString * captcha;
@property(nonatomic,strong)NSString * pwd;

@end
