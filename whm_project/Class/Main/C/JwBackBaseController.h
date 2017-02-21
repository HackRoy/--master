//
//  JwBackBaseController.h
//  Jw_ebank
//
//  Created by Jw on 16/3/9.
//  Copyright © 2016年 Jw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwDataService.h"
#import "JwUserService.h"

@interface JwBackBaseController : UIViewController

@property (nonatomic, strong) JwDataService *dataService;
@property (nonatomic, strong) JwUserService *userService;

- (void)backBaseAction:(UIBarButtonItem *)barButton;

@end
