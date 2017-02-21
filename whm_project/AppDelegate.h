//
//  AppDelegate.h
//  whm_project
//
//  Created by chenJw on 16/10/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) BMKLocationService *locationService;
//BMKMapManager *_mapManager;


@end

