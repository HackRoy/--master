//
//  WHcompanyTableViewController.h
//  whm_project
//
//  Created by 王义国 on 16/12/15.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwBackBaseController.h"

typedef void(^myblock1)(NSString * s1 ,NSString * s2);

@interface WHcompanyTableViewController : JwBackBaseController

@property(nonatomic,copy)myblock1 mblock1;

@end
