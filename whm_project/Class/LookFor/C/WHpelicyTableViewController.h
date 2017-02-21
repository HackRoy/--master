//
//  WHpelicyTableViewController.h
//  whm_project
//
//  Created by 王义国 on 16/11/3.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JwBackBaseController.h"

typedef void(^myblock2)(NSString  *s2);
@interface WHpelicyTableViewController : JwBackBaseController

@property(nonatomic,copy)myblock2  mblock2;
@end
